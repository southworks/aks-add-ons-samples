import sys
import json
import os
import subprocess
from pathlib import Path
from azure.cli.core import get_default_cli

CONST_SECRET_PROVIDER_TEMPLATE = "SecretProviderTemplate.yaml"
CONST_OBJECTS_ARRAY_TEMPLATE = "SecretProviderObjectsArrayTemplate.yaml"
CONST_POD_YAML_FILE = "Pod.yaml"
CONST_TEMPLATES_FILE_NAMES = [CONST_SECRET_PROVIDER_TEMPLATE, CONST_OBJECTS_ARRAY_TEMPLATE, CONST_POD_YAML_FILE]

CONST_OBJECT_NAME_REPLACEABLE_STRING = "<<object_name>>"
CONST_OBJECT_TYPE_REPLACEABLE_STRING = "<<object_type>>"

CONST_SECRET_TYPE = "secret"
CONST_TEMPLATE = "Template"

CONST_IDENTITY_CLIENT_ID_REPLACEABLE_STRING = "<<identity_client_id>>"
CONST_KEY_VAULT_NAME_REPLACEABLE_STRING = "<<key_vault_name>>"
CONST_SECRETS_TEMPLATE_REPLACEABLE_STRING = "<<secrets_template>>"
CONST_TENANT_ID_REPLACEABLE_STRING = "<<tenant_id>>"

def validateArguments(args):
    if len(args) != 4:
        sys.exit("Invalid arguments. The scripts expects three arguments (TF OUTPUT JSON FILE PATH; TEMPLATE FOLDER PATH; AZURE TENANT ID)")

    tf_output_file_path = args[1]

    if not Path(tf_output_file_path).is_file():
        sys.exit("The first argument is not a valid JSON file.")

    template_folder_path = args[2]
    if not Path(template_folder_path).is_dir():
        sys.exit("The second argument is not a valid directory.")
    
    for template in CONST_TEMPLATES_FILE_NAMES:
        file_path = os.path.join(template_folder_path, template)
        if not Path(file_path).is_file():
            sys.exit("The file {0} does not exist in the {1} folder.".format(template, template_folder_path))

def readJsonData(file_path):
    with open(file_path, 'r') as jsonfile:
        json_data=jsonfile.read()

    json_obj = json.loads(json_data)

    # dict data type
    resource_groups_names = json_obj["resource_groups_names"]["value"]
    aks_names = json_obj["aks_names"]["value"]
    aks_identity_client_ids = json_obj["aks_identity_client_ids"]["value"]
    kv_names = json_obj["kv_names"]["value"]

    # array data type
    regions = json_obj["regions"]["value"]
    kv_secrets_names = json_obj["kv_secrets_names"]["value"]

    return resource_groups_names, aks_names, aks_identity_client_ids, kv_names, regions, kv_secrets_names

def getNewFilePath(region, template_folder):
    new_file_name = CONST_SECRET_PROVIDER_TEMPLATE.replace(CONST_TEMPLATE, region)
    return os.path.join(template_folder, new_file_name)

def generateKeyVaultSecretsTemplate(template_folder, kv_secrets_names):
    template_file_path = os.path.join(template_folder, CONST_OBJECTS_ARRAY_TEMPLATE)

    with open(template_file_path, 'r') as file:
        template_data = file.read()

    formatted_info = []

    for secret in kv_secrets_names:
        formatted_data = template_data.replace(CONST_OBJECT_NAME_REPLACEABLE_STRING, secret)
        formatted_data = formatted_data.replace(CONST_OBJECT_TYPE_REPLACEABLE_STRING, CONST_SECRET_TYPE)
        formatted_info.append(formatted_data)

    return "\n".join(formatted_info)

def generateSecretProviderFiles(tf_output_file_path, template_folder, tenant_id, aks_identity_client_ids, kv_names, regions, kv_secrets_names):
    formatted_secrets = generateKeyVaultSecretsTemplate(template_folder, kv_secrets_names)

    template_file_path = os.path.join(template_folder, CONST_SECRET_PROVIDER_TEMPLATE)
    with open(template_file_path, 'r') as file:
        template_data = file.read()

    for region in regions:
        new_file_path = getNewFilePath(region, template_folder)

        new_data = template_data.replace(CONST_IDENTITY_CLIENT_ID_REPLACEABLE_STRING, aks_identity_client_ids[region])
        new_data = new_data.replace(CONST_KEY_VAULT_NAME_REPLACEABLE_STRING, kv_names[region])
        new_data = new_data.replace(CONST_SECRETS_TEMPLATE_REPLACEABLE_STRING, formatted_secrets)
        new_data = new_data.replace(CONST_TENANT_ID_REPLACEABLE_STRING, tenant_id)

        with open(new_file_path, 'w') as wFile:
            wFile.write(new_data)

def integrate_kv_secrets(tf_output_file_path, template_folder, resource_groups_names, aks_names, regions):
    for region in regions:
        new_file_path = getNewFilePath(region, template_folder)

        aks_cluster_name = aks_names[region]
        rg_name = resource_groups_names[region]

        get_default_cli().invoke(["aks", "get-credentials", "--name", aks_cluster_name, "--resource-group", rg_name])
        subprocess.run(["kubectl", "apply", "-f", new_file_path])
        subprocess.run(["kubectl", "apply", "-f", os.path.join(template_folder, CONST_POD_YAML_FILE)])

def main():

    validateArguments(sys.argv)

    tf_output_file_path = sys.argv[1]
    template_folder = sys.argv[2]
    tenant_id = sys.argv[3]

    resource_groups_names, aks_names, aks_identity_client_ids, kv_names, regions, kv_secrets_names = readJsonData(tf_output_file_path)

    generateSecretProviderFiles(tf_output_file_path, template_folder, tenant_id, aks_identity_client_ids, kv_names, regions, kv_secrets_names)

    integrate_kv_secrets(tf_output_file_path, template_folder, resource_groups_names, aks_names, regions)

if __name__=="__main__": 
    main()
