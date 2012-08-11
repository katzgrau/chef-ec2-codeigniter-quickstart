#
# Cookbook Name:: webapp
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#

# Extra PHP modules

include_recipe "application"
include_recipe "php::module_memcache"
include_recipe "php::module_curl"
include_recipe "php::module_apc"
include_recipe "php::module_mysql"

cfg = data_bag_item('apps', 'webapp')


template "#{cfg['deploy_to']}/current/application/config/database.php" do
  source "database.php.erb"
  mode 0755
  variables(
    #:config_var => node[:configs][:config_var]
  )
end

template "#{cfg['deploy_to']}/current/application/config/config.php" do
  source "config.php.erb"
  mode 0755
  variables(
    #:config_var => node[:configs][:config_var]
  )
end

template "#{cfg['deploy_to']}/current/application/config/index.php" do
  source "index.php.erb"
  mode 0755
  variables(
    #:config_var => node[:configs][:config_var]
  )
end

#template "#{cfg['deploy_to']}/current/application/config/memcached.php" do
#  source "memcached.php.erb"
#  mode 0755
#  variables(
#  )
#end

# Kill default CI log path
directory "#{cfg['deploy_to']}/current/application/logs" do
  recursive true
  action :delete
end

# Set up logging dirs
%w{webapp}.each do |dir|
   directory "/home/webapp/logs/#{dir}" do
      mode "0775"
      owner "webapp"
      group "admin"
      action :create
      recursive true
   end
end

# ln -s /etc/passwd /tmp/passwd
link "#{cfg['deploy_to']}/current/application/logs" do
  to "/home/webapp/logs/webapp"
  #owner "webapp"
  #group "admin"
end

# Set some file permission
directory "#{cfg['deploy_to']}/current/application/logs" do
  mode "0775"
  owner "webapp"
  group "admin"
  action :create
  recursive true
end

# For production application nodes, install the SSL certs
if node.chef_environment == 'production'
  
end