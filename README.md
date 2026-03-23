# Static Website Hosting with Terraform Modules

This project sets up static website hosting on **Azure** using Storage Accounts with Static Website feature, managed with Terraform modules. It includes automated CI/CD deployment via GitHub Actions.

> Note: Uses Azure Storage Account Static Website - **free tier eligible**!

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   GitHub        │────▶│   Azure Storage │────▶│   Users         │
│   (Push to main)│     │   Account        │     │   (Browser)     │
└─────────────────┘     └──────────────────┘     └─────────────────┘
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
├── modules/
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
- `static_website_endpoint` - Static website endpoint URL

### 5. Upload React Files

```bash
# Upload built React app to Azure Blob Storage $web container
az storage blob upload-batch \
  --source ./static-site-react/dist \
  --destination '$web' \
  --account-name samirazurestaticsite
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

## License

MIT
