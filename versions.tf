terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.3.4"
    }
  }
}
provider "minikube" {
  kubernetes_version = "v1.26.3"
}
provider "kubernetes" {
  load_config_file = "false"
  config_path      = "~/.kube/config"
  config_context   = "minikube"
}

provider "aws" {
  region = "us-west-1"


}