template "/etc/hosts" do
  source "hosts.erb"
  mode 0755
  variables(
    #:config_var => node[:configs][:config_var]
  )
end