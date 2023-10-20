# Azure Keyvault Secrets Provider addon

This deployment implements the **Azure Keyvault Secrets Provider** addon, i.e., a *CSI Driver* that enables the integration of an *Azure Key Vault* as a secret store with *Azure Kubernetes Service* (AKS) via a [CSI Volume][k8s-csi-volume].

You can find more information [here][msft-addon-description], as well as the feature description [here][msft-addon-features].

## Related code

1. The Terraform infrastructure is created via the [kv-secrets-provider][code-kv-secrets-provider-deployment] deployment.
1. [Python script][code-py-aks-code-integration] for configuration.
1. GitHub Actions:
    1. The [terraform-plan-apply][gha-terraform-plan-apply] GH Action creates the Azure infrastructure
    1. The [configure-aks-instances][gha-configure-aks-instances] GH Action configures the Azure infrastructure

## How is this addon being implemented?

For implementing this, we are creating a set of Azure resources via a Terraform deployment. This deployment is being implemented using GitHub Actions, and is also being configured using Python custom scripts.

## What do we need for running this sample?

### Microsoft App registration + Federated Identity

As we'll be deploying some Azure resources (via Terraform) from some GitHub Actions, we'll need a way to authenticate to Azure. To do so, we first need a [Microsoft Entra Application and Service Principal][msft-app-service-principal].
It's important to store the *CLIENT ID*, *SUBSCRIPTION ID*, and the *TENANT ID* values, as we'll be using them later.
After createing it, it's necessary to [assign a proper role to the application][msft-app-role] (in this case, we opted for the *Owner role*, but there might be other roles that might fit your necessities).
Finally, as we'll be running these GitHub Actions from our repo, and from an specific branch (main, for our case), it's necessary to [Add Federated Credentials][msft-add-federated-credentials] to the App registration.

### Azure Storage Account

Given that we are using Terraform in this solution, we would need to define how we are going to manage and where we'll store the *State File*.
We decided to store it in a *Azure Storage Account*, so, the next step is to **MANUALLY** create it, as well as an *Azure Container* within it.

> **NOTE**: we're manually creating the Storage Account because this resource MUST exist before we start the process that creates, via Terraform, the current deployment.

It's important to store the name of the *Storage Account* and the *Container*, as well as the name of the *Resource Group* where they are hosted, because we'll be using these values later.

### Configure the GitHub environment

First, it is necessary to create a [GitHub environment][gh-environments]. In our case, we created the *Test* environment, but you can create as many environment as Azure deployments you want/will need.
Keep in mind that, if you want to deploy to such environments, you'll need to add their names [here][gh-workflow-terraform] (it might be necessary to do this also in other workflows).

Once the environment is created, you'll need to create the next **secrets**:

- `AZURE_CLIENT_ID`: corresponds to the Azure App registration's `CLIENT ID`.
- `AZURE_SUBSCRIPTION_ID`: corresponds to the Azure App registration's `SUBSCRIPTION ID`.
- `AZURE_TENANT_ID`: corresponds to the Azure App registration's `TENANT ID`.

You'll need also the next *environment variables*:

- `AZURERM_RESOURCE_GROUP_NAME`: corresponds to the *Azure Resource Group*'s name where the Storage Account for storing the *Terraform State File* is deployed.
- `AZURERM_STORAGE_ACCOUNT_NAME`: corresponds to the *Azure Storage Account*'s name where the *Terraform State File* will be stored.
- `AZURERM_CONTAINER_NAME`: corresponds to the *Azure Storage Account Container*'s name where the *Terraform State File* will be stored.
- `AZURERM_KEY`: corresponds to the *Terraform State File*'s name. You can use any valid name (if and only if there isn't any similar name in use in the same Container).

Finally, in case you want to ensure that each deployment job in the current GitHub environment needs to be approved by any team member you want, it would be necessary to configure the [Deployment protection rules][gh-deployment-protection-rules].

## How to run this deployment

### Creating the Azure infrastructure

For creating the Azure infrastructure, you need to run the [terraform-plan-apply][gha-terraform-plan-apply] GitHub Action.
This GitHub action has two jobs:

1. The first job runs a *Terraform Plan*, which result shows the Azure resources that will be created.
1. The second job runs a *Terraform Apply*, i.e, it will create all the Azure resources that the Plan shows in the previous job.

Each job has some approval gates (a.k.a, *Deployment protection rules*), which means that, for running them, an approver is necessary.

### Configuring the Azure infrastructure

After creating the Azure infrastructure, it's necessary to configure the Azure Kubernetes Services (AKS) cluster that are being created.
To do so, you'll need to run the [configure-aks-instances][gha-configure-aks-instances].
This GitHub action has two jobs:

1. The first one gets the *Terraform output* from the state file for this solution.
2. The second one runs a set of *Python scripts* using the *Terraform output* from the previous job in order to configure each *AKS cluster instance* created by the Terraform deployment.

<!-- Links to MSFT docs -->
[msft-addon-description]: https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver
[msft-addon-features]: https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver#features
[msft-app-service-principal]: https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal
[msft-app-role]: https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal#assign-a-role-to-the-application
[msft-add-federated-credentials]: https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#add-federated-credentials
<!-- Links to K8s docs -->
[k8s-csi-volume]: https://kubernetes-csi.github.io/docs/
<!-- Links to GitHub docs -->
[gh-environments]: https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment
[gh-deployment-protection-rules]: https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#deployment-protection-rules
<!-- files -->
[gh-workflow-terraform]: https://github.com/southworks/aks-add-ons-samples/blob/main/.github/workflows/terraform-plan-apply.yml#L5
[code-kv-secrets-provider-deployment]: ../../deployments//kv-secrets-provider/
[code-py-aks-code-integration]: ../../scripts/aks-kv-integration-output-formatter.py
<!-- GitHub actions -->
[gha-terraform-plan-apply]: https://github.com/southworks/aks-add-ons-samples/blob/main/.github/workflows/terraform-plan-apply.yml
[gha-configure-aks-instances]: https://github.com/southworks/aks-add-ons-samples/blob/main/.github/workflows/configure-aks-instances.yml
