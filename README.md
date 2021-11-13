# GKE cluster implementation
In this repository, I use modules that have a source from another repository. This is a VPC native creation module for creating a network with a specific block, as well as various other resources that will be described below. Also, some additions, descriptions and explanations can be found in the code itself.


## Prerequisites
If you want to follow along and create your own GKE Cluster in Terraform, follow these steps.

- Create Google Cloud Account and login
- Create a project in your Google Cloud Account Cloud Console 
- There is generally a default project created, which you can use, or click on the ```My First Project``` dropdown next to the Google Cloud Platform logo and create a new project. 
- Once the project is created and you have it selected in the dropdown, on the left hand side find 
```Kubernetes Engine → Configuration``` and enable the Kubernetes Engine API as shown below.
Install the following
terraform ( v 12 ) 
gcloud cli ( make sure to gcloud login )
kubectl ( v1.15.11 )
