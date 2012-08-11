# Cookbook Name:: route53
# Provider:: record
#
# Copyright::
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

def name
  @name ||= new_resource.name + "."
end

def value
  @value ||= new_resource.value
end

def type
  @type ||= new_resource.type
end

def ttl
  @ttl ||= new_resource.ttl
end

action :create do
  require "rubygems"
  require "fog"
  require "nokogiri"
  
  def zone
    @zone ||= Fog::DNS.new({ :provider => "aws",
                             :aws_access_key_id => new_resource.aws_access_key_id,
                             :aws_secret_access_key => new_resource.aws_secret_access_key }
                           ).zones.get( new_resource.zone_id )
  end
  
  def create
    begin
      zone.records.create({ :name => name,
                            :value => value,
                            :type => type,
                            :ttl => ttl })
    rescue Excon::Errors::BadRequest => e
      Chef::Log.info Nokogiri::XML( e.response.body ).xpath( "//xmlns:Message" ).text
    end
  end

  record = zone.records.all.select do |record|
    record.name == name
  end.first

  if record.nil?
    create
    Chef::Log.info "Record created: #{name}"
  elsif value != record.value.first
    record.destroy
    create
    Chef::Log.info "Record modified: #{name}"
  end
end

action :destroy do
  require "fog"
  require "nokogiri"
  def zone
    @zone ||= Fog::DNS.new({ :provider => "aws",
                             :aws_access_key_id => new_resource.aws_access_key_id,
                             :aws_secret_access_key => new_resource.aws_secret_access_key }
                           ).zones.get( new_resource.zone_id )
  end
  
  record = zone.records.all.select do |record|
    record.name == name
  end.first

  if record.nil?
    Chef::Log.info "Record #{name} DONT exist"
  elsif value != record.value.first
    record.destroy
    Chef::Log.info "Record deleted: #{name}"
  end
end
