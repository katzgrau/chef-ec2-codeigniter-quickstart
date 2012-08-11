include_attribute "apache2"

default[:apache2][:force_https] = false
default[:webapp][:memcache_port] = 11211
default[:webapp][:memcache_host] = '127.0.0.1'
