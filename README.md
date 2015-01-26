# logentries-cookbook


## DESCRIPTION:
Cookbook to connect syslogging to [LogEntries](https://logentries.com/).

- Configures rsyslog to send messages to LogEntries API via TCP
- Creates hosts and logs if they dont already exist
- Sends logs via SSL



## REQUIREMENTS:

 * [rsyslog cookbook](http://community.opscode.com/cookbooks/rsyslog)


## ATTRIBUTES:


```ruby
node[:logentries][:user_key]            -   The user key provided via the LogEntries UI

node[:logentries][:host_name]           -   The name of the host

node[:logentries][:log_name]            -   The name of the log

node[:logentries]['cert_file']          -   Where to store cert bundle. Defaults to '/opt/ssl/logentries.all.crt'

node[:logentries]['resume_retry_count'] -   Number of times to retry sending failed messages. Defaults to unlimited.

node[:logentries]['queue_disk_space']   -   Maximum disk space for queues. Defaults to 100M.

node[:logentries]['queue_size']         -   Maximum events to queue. Defaults to 100000.

node[:logentries]['queue_file_name']    -   Name of the disk queue. Defaults to 'rsyslog_queue_main'.]

```



    
## USAGE:

Include the default recipe in your chef run list.
    

