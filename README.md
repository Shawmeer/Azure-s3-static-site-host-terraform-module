# S3 Website Hosting with Terraform Modules

This project sets up static website hosting on AWS using S3 and CloudFront, managed with Terraform modules. It includes automated CI/CD deployment via GitHub Actions.

## Architecture

```
┌─────────────────┐     ┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   GitHub        │────▶│   S3        │────▶│  CloudFront  │────▶│   Users     │
│   (Push to main)│     │   Bucket    │     │  CDN         │     │             │
└─────────────────┘     └─────────────┘     └──────────────┘     └─────────────┘
```

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── deploy.yml          # CI/CD workflow
├── .gitignore
├── main.tf                     # Root Terraform configuration
├── outputs.tf                  # Root outputs
├── providers.tf                # AWS provider configuration
├── variables.tf                # Root variables
├── modules/
│   ├── cloudfront/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── s3/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── static-site-react/          # React frontend application
    ├── src/
    ├── public/
    ├── package.json
    └── vite.config.js
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [Node.js](https://nodejs.org/) >= 18
- [AWS CLI](https://aws.amazon.com/cli/)
- AWS Account with appropriate permissions

## Getting Started

### 1. Configure AWS Credentials

```bash
# Configure AWS CLI
aws configure
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
- `bucket_name` - S3 bucket name
- `website_endpoint` - S3 website endpoint
- `cloudfront_url` - CloudFront distribution URL

## GitHub Actions CI/CD

The project includes automated deployment via GitHub Actions.

### Setup

1. **Create IAM User** with these permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowS3Sync",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::samir-module-s3-bucket-hosting",
        "arn:aws:s3:::samir-module-s3-bucket-hosting/*"
      ]
    },
    {
      "Sid": "AllowCloudFrontInvalidation",
      "Effect": "Allow",
      "Action": [
        "cloudfront:CreateInvalidation"
      ],
      "Resource": "*"
    }
  ]
}
```

2. **Add GitHub Secrets:**
   - Go to: **Settings → Secrets and variables → Actions**
   - Add `AWS_ACCESS_KEY_ID`
   - Add `AWS_SECRET_ACCESS_KEY`

### Workflow Triggers

- **Automatic**: Push to `main` branch
- **Manual**: Go to GitHub Actions tab → Deploy to CloudFront → Run workflow

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `bucket_name` | S3 bucket name | `samir-module-s3-bucket-hosting` |
| `index_document` | Index document | `index.html` |
| `error_document` | Error document | `error.html` |
| `region` | AWS region | `ap-south-1` |

## Customization

### Change Bucket Name

```bash
terraform apply -var="bucket_name=my-custom-bucket"
```

### Change AWS Region

```bash
terraform apply -var="region=us-east-1"
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

## Notes

- The S3 bucket policy allows public read access only through CloudFront (OAC)
- CloudFront redirects HTTP to HTTPS
- Custom error pages (403, 404) return `index.html` for SPA routing support
- Cache invalidation runs automatically after each deployment

## License

MIT
