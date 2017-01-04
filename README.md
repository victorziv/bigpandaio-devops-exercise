# BigPanda DevOps Exercise Solution Doc

### Virtual host configuration

Vagrant + VirtualBox combination was used for the required services deployment and running.
OS: Ubuntu 14.04 ( *ubuntu/trusty64* VirtualBox image )
Ansible playbook **preset.yml** triggers the prerequisites provisioning during the virtual host start.

### Panda nano-services

2 basic Python + Flask applications ( services ) has been developed. All neccessary files are kept with the
appropriate Ansible roles.
Both application run as Python daemons and not in debug mode. The daemons are managed by *supervisor* service control
system.

For the sake of simplicity the following improvements were NOT done:

1. Putting the services behind a proxy web server ( like Nginx ). The request should be sent straight to the application
   listening port.
1. Managing supervisord-driven application as a full-blown service.  Simple command line procedures are used to stop /
   start / restart the service.
1. Logging is not provided.

#### Static Panda

* The role is placed under *roles/static_panda/tasks/*.
* The code is in *roles/static_panda/files/static-panda/*
* Listening to the port *9191*
* Base URL is *http://localhost:9191*
* The URL *http://localhost:9191/small-panda* should serve a small png image from *resources* directory.
* The URL *http://localhost:9191/medium-panda* should serve a medium png image from *resources* directory.

#### Counting Panda

* The role can be found in *roles/counting_panda/tasks/*.
* The code - in *roles/counting_panda/files/counting-panda/*
* Listening to the port *9292*
* Base URL is *http://localhost:9292*

The app accepts any GET request and returns the total number of requests arrived starting from the last deployment.
To preserve the counter between service restarts and in case of crashing and restore, some form of persistency had to be
introduced. 
In order to keep things primitive the counter is saved into *counter.txt* file placed in the application root directory.

### Deployment
As was mentioned before 2 separate roles has been created: *static_panda* and *counting_panda*.
The latest code version is fetched by simple pulling from the GIT repository.
The new service versions are deployed onto **base** virtual host.
Then, the services are started / restarted. Very small downtime is encountered while the service is restarted.

### Deployment Wrapper
Again, very simpe Bash deployment script has been thrown in to make Ansible roles applience more convenient.
The script is named *deploy_panda_services.sh* and can be found in the root directory.
It accepts a single *-s \<service\>* command line argument where service can be *static-panda*, *counting-panda* or
*all* - for deployment both. If no argument is provided *all* is accepted as a default value.
If the provided service name is not on the list - the run is aborted.
The correspondent playbooks to be run are *static-panda.yml*, *counting-panda.yml' and *all.yml*
Besides *-h* flag provides some usage description message.


