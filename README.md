# Vagrant skeleton

## Preface
This is not a real project, it's just a learning purpose project to inspire you to automate creation of virtual machine for your development or experimental needs. Although it lets you create and configure VM with example LAMP project out of the box (just go through steps 6 and 7, don't forget the Prerequisites section).

Let's pretend one day you have been given a web project to be responsible for and only you have is just an access to production server.
- What you would NOT want to do is to screw the project until you're confident enough with it.
- What you would like to do is to isolate your work from production as much as it is possible.

The best way to achieve these goals is to replicate production server's environment and do all your development on that instance.
Here I'll show you how to replicate your production server as close as possible and run it locally on your VM. "As close as possible" means your VM won't be that much powerful as production as your local machine won't have that many CPUs, RAM, IO as production server but no worries your VM won't see that much traffic to withstand to either.

## Prerequisites
1. Install Oracle VirtualBox https://www.virtualbox.org/
2. Install vagrant https://www.vagrantup.com/

## What you need to do
1. First examine your project as much as you can:
  * Which Linux version is running on the server?
  * What and which versions of the software it requires to be installed?
  * What third-party services it depends on? You may need to switch your project talking to their sandboxes.

2. Copy all the configuration files from production server to ```.setup``` folder keeping the same
tree structure. Those files will overwrite default ones.

3. Choose the appropriate vagrant box http://www.vagrantbox.es/ and modify box name (```config.vm.box```) and url (```config.vm.box_url```) in Vagrantfile

4. Configure the memory and number of CPUs you give away to your VM in ```config.vm.provider``` section.

5. Configure the section ```config.vm.provision``` for your project's needs.

6. Spin up the VM ```vagrant up```

7. Now add all the virtual hosts such as ```example.com.local``` and ```phpmyadmin.example.com.local along with VM's IP address to your host machine's hosts file (```/etc/hosts``` for Linux/Mac and ```C:\Windows\System32\Drivers\etc\hosts``` for Windows).

Example:
```
192.168.33.100 example.com.local www.example.com.local
192.168.33.100 phpmyadmin.local
```

That's it - your VM is running, configured and ready for the development. 

Visit ```http://example.com.local``` or ```http://phpmyadmin.local``` in your browser.

## Files layout

```
.
├── .setup
│   ├── etc 									<- Customized settings for software
│   │   ├── hosts                                  to be installed
│   │   ├── httpd
│   │   │   ├── conf
│   │   │   │   ├── httpd.conf
│   │   │   └── conf.d
│   │   │       └── example.com.conf
│   │   ├── my.cnf
│   │   ├── php.d
│   │   │   ├── bcmath.ini
│   │   │   ├── ...
│   │   │   └── zip.ini
│   │   ├── php.ini
│   │   ├── pki
│   │   │   └── rpm-gpg
│   │   │       ├── RPM-GPG-KEY-CentOS-6
│   │   │       └── ...
│   │   ├── rc.local
│   │   └── yum.repos.d
│   │       ├── CentOS-Base.repo
│   │       └── ...
│   └── root
│       └── db
│           └── import.sh                       <- Script to import seed data
├── README.md
├── Vagrantfile                                 <- Main vagrant configuration file
└── src
    └── PROJECT_CODE                            <- Reference to project's code
        ├── public                                 repository (git submodule)
        │   └── ...
        └── seed                                <- Seed data (sql dump)
            └── ...
```

## Other useful vagrant commands
- Destroy the VM:
```vagrant destroy -f```
- Suspend the VM:
```vagrant suspend```
- Resume the VM:
```vagrant resume``` 