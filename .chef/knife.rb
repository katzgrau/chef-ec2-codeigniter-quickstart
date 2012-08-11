current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT

# quickstart-todo: Enter the name of your OpsCode organization name where [organization] appears, 
# and your username where [username] appears
node_name                "[organization]"
client_key               "#{current_dir}/[username].pem"
validation_client_name   "[organization]-validator"
validation_key           "#{current_dir}/[organization]-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/[organization]"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

# quickstart-todo: Enter these creds
knife[:aws_ssh_key_id]        = ""
knife[:aws_access_key_id]     = ""
knife[:aws_secret_access_key] = ""
