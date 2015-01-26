default[:logentries][:user_key] = ""
default[:logentries][:host_name] = "myhost"
default[:logentries][:log_name] = "mylog"

# The number of times to retry the sending of failed messages (defaults to unlimited)
default[:logentries][:resume_retry_count] = -1

default[:logentries][:ssl_cert_location] = "/opt/ssl/logentries.all.crt"
