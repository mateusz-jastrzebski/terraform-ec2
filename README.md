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