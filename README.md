# Static Website Hosting with Terraform Modules

This project sets up static website hosting on **Azure** using Storage Accounts and CDN, managed with Terraform modules. It includes automated CI/CD deployment via GitHub Actions.

> Note: The previous AWS (S3 + CloudFront) version has been replaced with Azure.

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────┐     ┌─────────────┐
│   GitHub        │────▶│   Azure Storage   │────▶│  Azure CDN  │────▶│   Users     │
│   (Push to main)│     │   Account        │     │             │     │             │
└─────────────────┘     └──────────────────┘     └─────────────┘     └─────────────┘
```

## Project Structure

```
.
├── .github/
│   └── workflows/
│       ├── deploy.yml             # AWS CloudFront CI/CD
│       └── deploy_azure.yml       # Azure CDN CI/CD
├── .gitignore
├── main.tf                        # Root Terraform configuration
├── outputs.tf                     # Root outputs
├── providers.tf                   # Azure provider configuration
├── variables.tf                   # Root variables
├── modules/
│   ├── cdn/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── storage-account/
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
- Azure Account with appropriate subscriptions

## Getting Started

### 1. Authenticate to Azure

```bash
# Login to Azure
az login

# Set subscription (if needed)
az account set --subscription "your-subscription-id"
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Plan and Apply

```bash
# Review changes
terraform plan

# Apply infrastructure
terraform apply
```

### 4. Get Outputs

After deployment, you'll see:
- `storage_account_name` - Azure Storage Account name
- `static_website_endpoint` - Static website endpoint
- `cdn_endpoint_url` - CDN endpoint URL

### 5. Upload React Files

```bash
# Upload built React app to Azure Blob Storage
az storage blob upload-batch \
  --source ./static-site-react/dist \
  --destination '$web' \
  --account-name <storage-account-name>
```

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
- **Manual**: Go to GitHub Actions tab → Deploy to Azure CDN → Run workflow

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `resource_group_name` | Resource group name | `azure-static-site-rg` |
| `storage_account_name` | Storage account name | `samirazurestaticsite` |
| `location` | Azure region | `eastus` |
| `storage_account_tier` | Storage tier | `Standard` |
| `storage_account_replication_type` | Replication type | `LRS` |
| `index_document` | Index document | `index.html` |
| `cdn_profile_name` | CDN profile name | `cdn-profile` |
| `cdn_endpoint_name` | CDN endpoint name | `samir-static-site-cdn` |
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

## Azure vs AWS Comparison

| Feature | AWS | Azure |
|---------|-----|-------|
| Storage | S3 Bucket | Blob Storage Account |
| CDN | CloudFront | Azure CDN |
| Static Website | S3 Website Hosting | Static Website (preview) |
| TLS | CloudFront Certificate | Azure CDN Managed |
| Global Distribution | 250+ edge locations | 130+ point of presence |

## Notes

- The storage account allows public read access through CDN
- CDN serves content globally with edge caching
- The `$web` blob container stores static files
- Cache purge runs after each deployment for updates

## License

MIT
