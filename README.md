# Static Website Hosting with Terraform Modules

This project sets up static website hosting on **Azure** using Storage Accounts with Static Website feature, managed with Terraform modules. It includes optional CDN for global content delivery and automated CI/CD deployment via GitHub Actions.

> Note: Uses Azure Storage Account Static Website - **free tier eligible**!

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   GitHub        │────▶│   Azure Storage │────▶│   CDN (Optional)│────▶│   Users         │
│   (Push to main)│     │   Account        │     │                 │     │   (Browser)     │
└─────────────────┘     └──────────────────┘     └─────────────────┘     └─────────────────┘
```

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── deploy_azure.yml       # Azure deployment workflow
├── .gitignore
├── main.tf                        # Root Terraform configuration
├── outputs.tf                     # Root outputs
├── providers.tf                   # Azure provider configuration
├── variables.tf                   # Root variables
├── terraform.tfvars               # Variable values
├── modules/
│   ├── storage-account/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── cdn/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── static-site-react/             # React frontend application
    ├── src/
    ├── public/
    ├── package.json
    └── vite.config.js
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [Node.js](https://nodejs.org/) >= 18
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- Azure Account with free trial or subscription

## Getting Started

### 1. Authenticate to Azure

```bash
# Login to Azure
az login
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Configure Variables

Edit `terraform.tfvars` to set your preferred values:

```hcl
resource_group_name              = "azure-static-site-rg"
storage_account_name             = "samirazurestaticsite"
location                         = "eastus"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
index_document                   = "index.html"

# CDN Configuration (Optional)
enable_cdn        = false         # Set to true to enable CDN
cdn_profile_name  = "samir-cdn-profile"
cdn_endpoint_name = "samir-cdn-endpoint"
cdn_sku          = "Standard_Microsoft"  # CDN SKU
```

### 4. Plan and Apply

```bash
# Review changes
terraform plan

# Apply infrastructure
terraform apply
```

### 5. Get Outputs

After deployment, you'll see:
- `storage_account_name` - Azure Storage Account name
- `static_website_endpoint` - Static website endpoint URL
- `cdn_endpoint_url` - CDN endpoint URL (when CDN is enabled)
- `cdn_endpoint_host_name` - CDN endpoint host name (when CDN is enabled)

### 6. Upload React Files

```bash
# Upload built React app to Azure Blob Storage $web container
az storage blob upload-batch \
  --source ./static-site-react/dist \
  --destination '$web' \
  --account-name samirazurestaticsite
```

## CDN Configuration

The project includes an optional CDN module that can be enabled for global content delivery.

### Enabling CDN

Set `enable_cdn = true` in `terraform.tfvars`:

```hcl
enable_cdn        = true
cdn_profile_name  = "samir-cdn-profile"
cdn_endpoint_name = "samir-cdn-endpoint"
cdn_sku          = "Standard_Microsoft"
```

### Available CDN SKUs

| SKU | Description |
|-----|-------------|
| `Standard_Microsoft` | Azure CDN from Microsoft (default) |
| `Standard_Verizon` | Azure CDN from Verizon |
| `Premium_Verizon` | Azure CDN Premium from Verizon |

> **Note**: Azure CDN (classic) and Azure Front Door may not be available on all subscription types including free trial accounts. If CDN creation fails, you can still use the storage account static website directly.

### CDN Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `enable_cdn` | Enable CDN | `false` |
| `cdn_profile_name` | CDN profile name | `cdn-profile` |
| `cdn_endpoint_name` | CDN endpoint name | `cdn-endpoint` |
| `cdn_sku` | CDN SKU | `Standard_Microsoft` |

## GitHub Actions CI/CD

The project includes automated deployment via GitHub Actions.

### Setup

1. **Create Azure Service Principal** with contributor permissions:

```bash
# Create service principal
az ad sp create-for-rbac --name "github-actions" --role Contributor --scope /subscriptions/<subscription-id>
```

2. **Add GitHub Secrets:**
   - Go to: **Settings → Secrets and variables → Actions**
   - Add `AZURE_CREDENTIALS` with the JSON output from the previous step

### Workflow Triggers

- **Automatic**: Push to `main` branch
- **Manual**: Go to GitHub Actions tab → Deploy to Azure Storage → Run workflow

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `resource_group_name` | Resource group name | `azure-static-site-rg` |
| `storage_account_name` | Storage account name | `samirazurestaticsite` |
| `location` | Azure region | `eastus` |
| `storage_account_tier` | Storage tier | `Standard` |
| `storage_account_replication_type` | Replication type | `LRS` |
| `index_document` | Index document | `index.html` |
| `enable_cdn` | Enable CDN | `false` |
| `cdn_profile_name` | CDN profile name | `cdn-profile` |
| `cdn_endpoint_name` | CDN endpoint name | `cdn-endpoint` |
| `cdn_sku` | CDN SKU | `Standard_Microsoft` |

## Customization

### Change Storage Account Name

```bash
terraform apply -var="storage_account_name=my-custom-account"
```

### Change Azure Region

```bash
terraform apply -var="location=westus2"
```

### Enable CDN

```bash
terraform apply -var="enable_cdn=true"
```

## Development

### Local React Development

```bash
cd static-site-react
npm install
npm run dev
```

### Build for Production

```bash
cd static-site-react
npm run build
```

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

## Azure Free Tier

This setup uses **Azure Storage Account Static Website** which is **free tier eligible**:

- **5 GB storage** - free
- **2 million read requests** - free
- **2 million write requests** - free

For more details, see: https://azure.microsoft.com/free/

## Notes

- Files are stored in the `$web` blob container for static website hosting
- The static website feature provides direct HTTP/HTTPS access
- Custom routing for SPA apps is supported through the index document
- CDN is optional and can be enabled/disabled via `terraform.tfvars`
- Both Azure CDN and Azure Front Door are available as CDN options

## License

MIT
