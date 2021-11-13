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

