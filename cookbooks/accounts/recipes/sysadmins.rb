#
# Cookbook Name:: accounts
# Recipe:: sysadmins
#
# Copyright 2009, Alexander van Zoest
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Here you can put account definitions for each account you want installed when someone includes
# include_recipe "accounts::sysadmins"

#account "sysadmin1" do
#  uid "801"
#  account_type "user"
#  comment "System Administrator #1"
#  password "somepass"
#  ssh true
#  sudo true
#end

agroup "deploy" do
  gid 2000
end

# quickstart-todo: Fill in your account here
agroup "admin" do
  gid 2004
end

# quickstart-todo: Fill in your account here
account "admin" do
  uid "2004"
  group "admin"
  account_type "user"
  ssh true
  sudo true
end

agroup "webapp" do
  gid 2008
end

account "webapp" do
  uid "2008"
  group "webapp"
  account_type "user"
  ssh true
  sudo true
end

# quickstart-todo: Fill in your account here
group "admin" do
  gid 999
  members ['admin', 'webapp']
end
