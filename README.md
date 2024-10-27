# HSA AWS S3 setup

<h3>Task</h3>

- Create bucket where objects can’t be modified and all requests are logged

<h3>Description</h3>

Prerequisites
1. Configure aws access via [AWS CLI](https://aws.amazon.com/cli/)
2. Setup [Terraform CLI](https://developer.hashicorp.com/terraform/cli)

Apply changes:
```
cd terraform
terraform init
terraform apply
terraform destroy
```

Upload several object versions, download and delete object from s3:
```
aws s3api put-object --bucket smith-hsa-ledger --key file.txt --body file.txt
aws s3api get-object --bucket smith-hsa-ledger --key file.txt output.txt
aws s3api delete-object --bucket smith-hsa-ledger --key file.txt
```

Object versioning enabled (not allows override current object):

<img src="./images/object_versioning.png" width="600">

Object locking enabled (not allows delete object versions during specified retention period):

<img src="images/object_deletion.png" width="600">

Bucket access logs enabled:

<img src="images/bucket_access_logs.png" width="600">