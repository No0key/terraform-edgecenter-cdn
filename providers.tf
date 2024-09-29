terraform {
  required_version = ">= 1.3.0"
  required_providers {
    edgecenter = {
      source  = "Edge-Center/edgecenter"
      version = "0.7.3"
    }
  }
}

provider "edgecenter" {
  edgecenter_platform_api = "https://api.edgecenter.ru/iam"
  edgecenter_cloud_api    = "https://api.edgecenter.ru/cloud"
  permanent_api_token     = "$EDGECENTER_API_TOKEN" # create your token here https://accounts.edgecenter.ru/profile/api-tokens
}
