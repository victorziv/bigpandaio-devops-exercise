# BigPanda DevOps Exercise Solution Doc

### Virtual host configuration

Vagrant + VirtualBox combination was used for the required services deployment and running.
OS: Ubuntu 14.04 ( *ubuntu/trusty64* VirtualBox image )
Ansible playbook **preset.yml** triggers the prerequisites provisioning during the virtual host start.

### Panda nano-services

2 basic Python + Flask applications ( services ) has been developed. All neccessary files are kept with the
appropriate Ansible roles.

#### Static Panda

The role can be found at *roles/static_panda/tasks/*.
The code - at *roles/static_panda/files/static-panda/*





#### Ready for action?
Great.  
Your project is simple, as a DevOps panda you need to have the ability to develop nanoservices and create a mechanism for deploying them.  
Below, you can find the description of your tasks.

###### NodeJS/Python services
Create two basic NodeJs/Python services, the first is static-panda which should serve static files from a directory called `resources`. The directory should contain two files, small.png and medium.png. You may use any image that you like, as long as there is a panda over there.  
The second service shall be called counting-panda, and should just maintain a counter of the amount of GET requests it served, and return it on every GET request it gets.
A sample NodeJS service named bamboo-app already exists  [here](roles/bamboo/files/bamboo-app)

###### Deployment
Create an ansible role for each of the services. The role should install the service, **run it** and make sure it's ready to be used in **production** (see [General Guidelines](#general-guidelines)). 
A sample role for bamboo-app already exists for your convenience.  (Please note: samples are not full, and do not contain all relevant the details, you're expected to improve them, and add missing tasks).
We understand there might be a short service downtime when re-deploying a service, that’s fine.

###### Wrapper
This part is a **BONUS** part, if you find this exercise simple and short, feel free to do it.  
Create a simple utility for deploying both services. Your utility should support deploying a single service, or all of them.  
Please make sure you have a decent `--help` in your script.

#### Deliverables
A GitHub Pull-Request to **YOUR DUPLICATED REPO**, containing:  

1. The code for both static-panda and counting-panda.
1. Ansible roles which takes care of provisioning both services.
1. Modified base.yml which install ONLY the newly written services on the base VM.
1. **BONUS** A wrapper script on top of ansible-playbook which deploys the latest version of those services.

The Pull-Request should contain a short description of the roles you created, and any other comment you’d like us to know of.

#### General Guidelines
Your code should be as simple as possible, yet well documented and robust.  
Spend some time on designing your solution. 
Think about operational use cases from the real world. Few examples:

1. Can you run the playbook multiple times without any problem?
1. What happens if a service crashes?
1. How much effort will it take to create a new service?
