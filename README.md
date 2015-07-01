# Vagrant skeleton

## Preface
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
- Which Linux version is running on the server?
- What and which versions of the software it requires to be installed?
- What third-party services it depends on?

2. Copy all the configuration files from production server to .setup folder keeping the same
tree structure. Those files will overwrite default ones.

3. Choose the appropriate vagrant box http://www.vagrantbox.es/ and modify box name (config.vm.box) and url (config.vm.box_url) in Vagrantfile


```
.
├── .setup
│   └── etc 									<- Customized settings for software
│       ├── hosts								   to be installed
│       ├── httpd
│       │   ├── conf
│       │   │   ├── httpd.conf
│       │   └── conf.d
│       │       ├── example.01.com.conf
│       │       ├── ...
│       │       └── example.NN.com.conf
│       ├── my.cnf
│       ├── php.d
│       │   ├── bcmath.ini
│       │   ├── ...
│       │   └── zip.ini
│       ├── php.ini
│       ├── pki
│       │   └── rpm-gpg
│       │       ├── RPM-GPG-KEY-CentOS-6
│       │       ├── ...
│       │       └── RPM-GPG-KEY-webtatic-andy
│       ├── rc.local
│       └── yum.repos.d
│           ├── CentOS-Base.repo
│           ├── ...
│           └── webtatic.repo
├── README.md
├── Vagrantfile									<- Main vagrant configuration file
└── src
    └── PROJECT_CODE 							<- Reference to project's code repository
        ├── ...									   (git submodule)
        ├── ...
        └── ...
```