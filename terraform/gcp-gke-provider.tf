# AGISIT Project Team 29
# Check how configure the provider here:
# https://www.terraform.io/docs/providers/google/index.html

provider "google" {
    # Create/Download your credentials from:
    # Google Console -> "APIs & services -> Credentials"
    credentials = file("agi-project-29-8d4af8b04373.json")
}
