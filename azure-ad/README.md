# Integrate on-premises Active Directory domains with Azure Active Directory

Azure Active Directory (Azure AD) is a cloud based multi-tenant directory and identity service. This reference architecture shows best practices for integrating on-premises Active Directory domains with Azure AD to provide cloud-based identity authentication.

![](https://docs.microsoft.com/azure/architecture/reference-architectures/identity/images/azure-ad.png)

For guidance about best practices, see the article [Integrate on-premises Active Directory domains with Azure Active Directory](https://docs.microsoft.com/azure/architecture/reference-architectures/identity/azure-ad) on the Azure Architecture Center.

## Deploy the solution

A deployment for a reference architecture that implements these recommendations and considerations is available on [GitHub][github]. This reference architecture deploys a simulated on-premises network in Azure that you can use to test and experiment. The reference architecture can be deployed with either with Windows or Linux VMs by following the directions below.

### Prerequisites

1. Clone, fork, or download the zip file for the [identity reference architectures](https://github.com/mspnp/identity-reference-architectures) GitHub repository.

2. Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).

3. Install the [Azure building blocks](https://github.com/mspnp/template-building-blocks/wiki/Install-Azure-Building-Blocks) npm package.

   ```bash
   npm install -g @mspnp/azure-building-blocks
   ```

4. From a command prompt, bash prompt, or PowerShell prompt, sign into your Azure account as follows:

   ```bash
   az login
   ```

### Deploy the simulated on-premises datacenter

1. Navigate to the `azure-ad` folder of the GitHub repository.

2. Open the `onprem.json` file. Search for instances of `AdminPassword`, `SafeModeAdminPassword` and `Password` and change values for the passwords.

3. Run the following command and wait for the deployment to finish:

    ```bash
    azbb -s <subscription_id> -g <resource group> -l <location> -p onprem.json --deploy
    ```

### Deploy the Azure N-Tier VNet

The reference architecture can be deployed with either with Windows or Linux VMs. Steps are the same for boths, but for Linux you need use `ntier-linux.json` instead of `ntier-windows.json`.

1. Navigate to the `azure-ad` folder of the GitHub repository.

2. Open the `ntier-windows.json` file. Search for instances of `AdminPassword`, `SafeModeAdminPassword` and `Password` and change values for the passwords.

3. Run the following command and wait for the deployment to finish:

    ```bash
    azbb -s <subscription_id> -g <resource group> -l <location> -p ntier-windows.json --deploy
    ```

<!-- links -->
[github]: https://github.com/mspnp/identity-reference-architectures/tree/master/azure-ad

