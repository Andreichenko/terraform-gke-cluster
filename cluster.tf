
module "network" {
  source = "git::https://github.com/Andreichenko/terraform-gcp-vpc.git//vpc?ref=gke-node-pool-v2.0.1"
  network_name     = "kube"
  subnetwork_name  = "kube-subnet"
  region           = "us-central1"
  enable_flow_logs = "false"
  // subnetwork primary and secondary CIDRS for IP aliasing
  subnetwork_range    = "10.240.0.0/16"
  subnetwork_pods     = "10.241.0.0/16"
  subnetwork_services = "10.242.0.0/16"
}

module "cluster" {
  source                           = "git::https://github.com/Andreichenko/terraform-gcp-vpc.git//vpc?ref=gke-node-pool-v2.0.1"
  region                           = "us-central1"
  name                             = "gke-cluster"
  project                          = "terraform-module-cluster"
  network_name                     = "kube"
  nodes_subnetwork_name            = module.network.subnetwork
  kubernetes_version               = "1.16.10-gke.8"
  pods_secondary_ip_range_name     = module.network.gke_pods_1
  services_secondary_ip_range_name = module.network.gke_services_1
}

module "node_pool" {
  source             = "git::https://github.com/Andreichenko/terraform-gcp-vpc.git//vpc?ref=gke-node-pool-v2.0.1"
  name               = "gke-cluster-node-pool"
  region             = module.cluster.region
  gke_cluster_name   = module.cluster.name
  machine_type       = "e2-medium"
  min_node_count     = "1"
  max_node_count     = "3"
  kubernetes_version = module.cluster.kubernetes_version
}