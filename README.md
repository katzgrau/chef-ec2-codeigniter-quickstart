# Opscode Chef / AWS EC2 / CodeIgniter Quickstart

A generic quickstart chef configuration with instructions. Originally presented at CIConf San Francisco 2012.

Original slides in presentation-katzgrau.pdf

## Instructions (Work in progress)

Email katzgrau@gmail.com with any issues.

### Get opscode account

* Sign up for free trial
* Login @ https://manage.opscode.com/
* Go to: https://manage.opscode.com/organizations
* Go to your organization, click "Regenerate validation key" -> Download [organization]-validator.pem, place in .chef/
* Open .chef/knife.rb and make sure 'validation_key' is pointing at that file
* Go to: https://www.opscode.com/account/password click "Get a new key"
* Save the key in .chef/
* Open .chef/knife.rb and make sure 'client_key' is pointing at that file
* Open .chef/knife.rb and fill in [organization-name] and [username]
    
### Install Chef and Git

http://wiki.opscode.com/display/chef/Fast+Start+Guide#FastStartGuide-Step2%253AInstallChefandGit

### Install EC2 plugin 

http://wiki.opscode.com/display/chef/EC2+Bootstrap+Fast+Start+Guide#EC2BootstrapFastStartGuide-Step1%253AInstalltheKnifeEC2Plugin

### Get an AWS account
* Open IAM service
* Create a new user, click "Download Credentials", or copy access key and secret key
* Give new user admin privs
* Open .chef/knife.rb, and set 'aws_access_key_id' and 'aws_secret_access_key'
* Open the EC2 Service
* On the left side, click 'Security groups'. Edit the default security group, opening ports 22 and 80
* On the left side, click 'Key Pairs'. Create one named for your organization. Save the resulting .pem file as [organization]-key.pem
* Run $ chmod 400 ~/.ssh/[organization]-key.pem
* Run $ ssh-add .chef/[organization]-key.pem
* Run $ knife node list
* If it spits out a blank line, it worked

### Copy in your SSH public key (.ssh/id_rsa.pub) 

Copy it to cookbooks/accounts/files/default/users/admin/ssh/authorized_keys

### Go to .chef directory

* Run $ ssh-keygen -t rsa
* When prompted for the filename, type webapp-aws
* Accept defaults for the rest
      
### Run $ 
* knife cookbook upload -a
* knife environment from file environments/development.json
* knife environment from file environments/staging.json
* knife environment from file environments/production.json
* knife data bag create apps
* knife data bag from file apps data_bags/apps/webapp.json
* knife role from file roles/base.json
* knife role from file roles/webapp.json

### $ source .shortcuts

### Run $ new-webapp-production

### Get public host name, log in as admin (your passwordess login will work)

### Customize

