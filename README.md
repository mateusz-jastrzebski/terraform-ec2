# A simple Terraform script to create an EC2 instance

Terraform script will create an EC2 instance and add a "A" record for it inside your Cloudflare zone.

## Prerequisites

### 1. Install Terraform

Fetch newest versions of software and install needed dependencies

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

Obtain Hashicorp's gpg key

```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

Verify obtained key

```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```

Add Hashicorp's repository

```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```

Fetch updates

```
sudo apt update
```

Install Terraform

```
sudo apt-get install terraform
```

### 2. Install AWS-CLI

Download `.zip` package, extract it and use the installation script

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### 3. Obtain a Cloudflare managed domain

### 4. Create a SSL Flexible Root Configuration Rule on Cloudflare (only if you have chosen Full SSL setting)

## How to run

### 1. Clone repository

```
git clone git@github.com:mateusz-jastrzebski/terraform-ec2.git
```

### 2. Create `terraform.tfvars` file inside the directory

```
cd terraform-ec2/
touch terraform.tfvars
```

### 3. Fill the file with needed content

```
aws_region = "my_aws_region"
aws_access_key = "my_aws_access_key"
aws_secret_key = "my_aws_secret_key"

cloudflare_email = "my_email_address"
cloudflare_zone_id = "my_cloudflare_zone_id"
cloudflare_api_token = "my_cloudflare_api_token"

key_name = "my_aws_private_key_name"
user_name = "my_name"
```

### 4. Run Terraform commands inside the directory

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

Enter `yes` when prompted after apply.

## Verify website is running

After around 30 seconds access `https://ec2-test.example.com` in your browser