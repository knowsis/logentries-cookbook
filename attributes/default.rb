default[:logentries][:user_key] = nil
default[:logentries][:port_number] = 20000
default[:logentries][:host_name] = "my_host"
default[:logentries][:log_name] = "my_log"

# The number of times to retry the sending of failed messages (defaults to unlimited)
default[:logentries][:resume_retry_count] = -1

# The maximum disk space allowed for queues (default to 100M)
default[:logentries][:queue_disk_space] = '100M'

# The maximum number of events to queue (default to 100000)
default[:logentries][:queue_size] = 100000

# The name of the disk queue (relative file name)
default[:logentries][:queue_file_name] = 'rsyslog_queue_main'

# Where to store ssl cert file.
default[:logentries][:ssl_cert_location] = "/opt/ssl"


default[:logentries][:syslog_selector] = "*.*"