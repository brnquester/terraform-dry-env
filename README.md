# terraform-multienv

This repository contains Terraform configurations for managing multiple environments and/or multiple accounts by leveraging native Terraform workspaces and modules. The goal is to provide a scalable and maintainable way to manage infrastructure as code without the need of another provider such as Terragrunt.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup for a quick test](#setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) 
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials in `~/.aws/credentials`
- [Git](https://git-scm.com/)

## Setup for a quick test

1. Update your local `~/.aws/credentials` with the correct profile name
2. Make a copy of this entire repository
3. Test the system by choosing if you want to use local or remote AWS S3+DynamoDB backend state, enter the respective folder
4. For remote, update the files `variables.tf` and the `*.tfbackend` files. For local, you just need to update `variables.tf`.
5. Enter the Terraform folder test you chose, then run `./start.sh production` or `./start.sh stage`. 

## The purpose


## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.