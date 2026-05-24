# After creating your GCP account, create or modify the following resources to enable Terraform to provision your infrastructure:

## A GCP Project: GCP organizes resources into projects. Create one now in the GCP console and make note of the project ID. You can see a list of your projects in the cloud resource manager.

## Google Compute Engine: Enable Google Compute Engine for your project in the GCP console. Make sure to select the project you are using to follow this tutorial and click the "Enable" button.

## A GCP service account key: Create a service account key to enable Terraform to access your GCP account. When creating the key, use the following settings:

* Select the project you created in the previous step.
* Click "Create Service Account".
* Give it any name you like and click "Create".
* For the Role, choose "Project -> Editor", then click "Continue".
* Skip granting additional users access, and click "Done".
* After you create your service account, download your service account key.

## Select your service account from the list.
  * Select the "Keys" tab.
  * In the drop down menu, select "Create new key".
  * Leave the "Key Type" as JSON.
  * Click "Create" to create the key and save the key file to your system.
