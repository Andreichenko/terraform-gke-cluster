# GKE cluster implementation
In this repository, I use modules that have a source from another repository. This is a VPC native creation module for creating a network with a specific block, as well as various other resources that will be described below. Also, some additions, descriptions and explanations can be found in the code itself.


## Prerequisites
If you want to follow along and create your own GKE Cluster in Terraform, follow these steps.

- Create [Google Cloud Account](https://console.cloud.google.com/getting-started) and login
- Create a project in your Google Cloud Account Cloud Console 

![GCP My First Project screenshot](https://user-images.githubusercontent.com/20015341/141650206-eeb75370-91f7-44d9-bc05-b293288b8300.png)


- There is generally a default project created, which you can use, or click on the ```My First Project``` dropdown next to the Google Cloud Platform logo and create a new project. 

![GCP Kubernetes Engine API Enable Screenshot](https://user-images.githubusercontent.com/20015341/141650223-5fb27741-2e35-4309-b101-8865d750fbca.png)

- Once the project is created and you have it selected in the dropdown, on the left hand side find 
```Kubernetes Engine → Configuration``` and enable the Kubernetes Engine API as shown below.
Install the following
- [terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) ( v 13 ) 
- [gcloud cli](http://cloud.google.com/sdk/docs#install_the_latest_cloud_tools_version_cloudsdk_current_version) ( make sure to gcloud login )
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/%C2%A0%C2%A0) ( v1.15.11 )


Download the appropriate Terraform binary package for the provided lab server VM (Linux 64-bit) using the wget command:

```wget -c https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip```

Unzip the downloaded file:

```unzip terraform_0.13.4_linux_amd64.zip```

You will need a file with the credentials that Terraform needs to interact with the Google Cloud API to create the cluster and related networking components. Head to the IAM & Admin section of the Google Cloud Console’s navigation sidebar, and selectService Accounts.Once there, create a service account

Once you have created the service account, you will be prompted to select a role for it. For the purposes of this exercise, you can selectProject: Ownerfrom the Role dropdown menu.

On the next page, click on CREATE KEY and select a JSON key type. Next, clone the repo.

Once created, the file will be downloaded to your computer. Move the provider file to the Terraform project directory.
Fill in the the project name with the ID of the project you created in the GCP Console, and fill in the credentials filename with the name of the service account key file that you just downloaded and moved to the project folder.

```
provider "google" {
    credentials = file("./credentials.json")
    project = "playground-s-21-67f210a5" 
    region = var.region-common
    version     = "~> 3.5.0"
}
```

Run terraform init, plan and apply.

