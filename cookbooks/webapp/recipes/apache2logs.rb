# Set up logging dirs
%w{apache php}.each do |dir|
   directory "/home/webapp/logs/#{dir}" do
      mode "0775"
      owner "webapp"
      group "admin"
      action :create
      recursive true
   end
end