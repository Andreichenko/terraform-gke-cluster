provider "google" {
    credentials = file("./credentials.json")
    project = "playground-s-11-45d410c9"
    region = var.region-common
    version     = "~> 3.5.0"
}