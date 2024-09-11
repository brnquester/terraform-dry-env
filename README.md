# Terraform DRY Environment

This repository contains Terraform configurations designed to manage multiple environments and/or accounts by leveraging a combination of native Terraform [workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces) and [modules](https://developer.hashicorp.com/terraform/language/modules). The primary focus is to adhere to DRY (Don't Repeat Yourself) principles, eliminating redundancy and duplication of files and code between environments within the same account. By leveraging this approach, the repository provides a scalable, maintainable infrastructure-as-code solution without relying on external tools like Terragrunt.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup for a quick test](#setup-for-a-quick-test)
- [Quick tips](#quick-tips)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) 
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials in `~/.aws/credentials`
- [Git](https://git-scm.com/)
- Bash - Native support for macOS and Linux. For Windows users, you can use [Git Bash](https://gitforwindows.org/).

## Setup for a quick test

1. **Update AWS Credentials:** Ensure your local `~/.aws/credentials` file is updated with the correct AWS profile name.
2. **Clone the Repository:** Make a copy of this repository to your local environment.
3. **Choose Backend State:** Decide whether to use a local or remote AWS S3 + DynamoDB backend state. Navigate to the corresponding folder (local or remote).
4. **Update Configuration Files:**
   - For remote backend, update both `variables.tf` and the `**.tfbackend` files.
   - For local backend, only `variables.tf` needs to be updated.

5. **Run Terraform:** Navigate to the appropriate Terraform folder based on your backend choice, then execute `./start.sh production` or `./start.sh stage` depending on the environment you want to test.

## Quick tips

- Make use of conditionals to define names and specifics per environment `local.environment == "production" ? "www.test-website.com" : "stage.test-website.com"`
- If you have a resource that should be created on one environment only, you may use count: `count = local.environment == "production" ? 1 : 0`. If `0`, it doesn't create it. Just remember that if you implement the count parameter, when calling that resources you need to account for it `aws_resource.resource_name[0].arn`.
- This can also be used with loops: `for_each = local.environment == "production" ? [] : [1]` 

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.