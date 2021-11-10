provider "google" {
    credentials = file("./credentials.json")
    project = "playground-s-21-67f210a5"
    region = var.region-common
    version     = "~> 3.5.0"
}