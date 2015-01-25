require "json"
require "open-uri"
require "net/http"
require "net/https"

module Knowsis
    module Logging
        module LogEntries
           
            def get_hosts()
                uri = "https://pull.logentries.com/#{ node[:knowsis][:log_entries][:user_key] }/hosts/"
                response = JSON.parse(open(uri).read)
                hosts = response["list"].select {|item| item["object"] == "host"}
                hosts
            end                    

            def create_host(hostname)
                params = {
                    "request" => "register",
                    "user_key" => node[:knowsis][:log_entries][:user_key],
                    "name" => hostname,
                    "hostname" => hostname        
                }
                
                uri = URI.parse("https://api.logentries.com/")
                    
                https = Net::HTTP.new(uri.host,uri.port)
                https.use_ssl = true
                
                req = Net::HTTP::Post.new(uri.path)
                
                req.set_form_data(params)
                res = https.request(req)

                host = JSON.parse(res.body)
                host
            end

            def get_logs(host_key)
                uri = "https://pull.logentries.com/#{ node[:knowsis][:log_entries][:user_key] }/hosts/#{host_key}/"
                
                response = JSON.parse(open(uri).read)
                hosts = response["list"].select {|item| item["object"] == "log"}
                hosts
            end 

            def get_log_key(logname, host_key)
                
                log = get_logs(host_key).find { |log| log["name"] == logname}
                
                if log.nil? || log.empty?
                    log = create_log(logname, host_key)
                    lof = log["log"]
                end

                log["key"]
               
            end


            def create_log(logname, host_key)
                params = {
                    "request" => "new_log",
                    "user_key" => node[:knowsis][:log_entries][:user_key],
                    "host_key" => host_key,
                    "name" => logname,
                    "retrntion" => -1,
                    "source" => "token"
                }
                
                uri = URI.parse("https://api.logentries.com/")
                    
                https = Net::HTTP.new(uri.host,uri.port)
                https.use_ssl = true
                
                req = Net::HTTP::Post.new(uri.path)
                
                req.set_form_data(params)
                res = https.request(req)

                log_obj = JSON.parse(res.body)
                log_obj
            end


            def get_host_key(hostname)
                
                host = get_hosts.find { |host| host["name"] == hostname}
                if host.nil? || host.empty?
                    host = create_host(hostname)
                    host = host["host"]
                end

                host["key"]                
            end

        end
    end
end

