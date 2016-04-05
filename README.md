# obdi-helloworld-runscript

This Obdi plugin has a UI and runs a script on a worker.

## Screenshot

![](images/helloworld-endpoint.png?raw=true)

## What is it?
A starting point for writing an Obdi plugin that runs a script on a local
or remote Obdi worker.

* This plugin has a Web Interface.

   blah
 
* This plugin adds a REST endpoint.

    A REST endpoint, '/helloworld-full', is added that can be accessed by
    other tools or from othe command line, for example:

        # Set the host and port
        ipport="127.0.0.1:443"
        
        # Log in as the admin user
        guid=`curl -ks \
            -d '{"Login":"admin","Password":"admin"}' \
            https://$ipport/api/login | grep -o "[a-z0-9][^\"]*"`
        
        # Use the /hello endpoint
        curl -k "https://$ipport/api/admin/$guid/hello-endpoint"

* This plugin runs scripts on workers.

    A script is run on the configured worker. The script will output:
    
        hello from <hostname>
        
    Where '<hostname\>' is replaced with the host name the script is run on.

* This plugin does not use a private sqlite database.

Similar plugin: [obdi-core-systemjobs](https://github.com/mclarkson/obdi-core-systemjobs)

## Manually accessing the REST endpoint

```
$ ipport="127.0.0.1:443"

$ guid=`curl -ks -d '{"Login":"nomen.nescio","Password":"password"}' \
      https://$ipport/api/login | grep -o "[a-z0-9][^\"]*"`

$ curl -k "https://$ipport/api/nomen.nescio/$guid/helloworld-runscript/helloworld-runscript"
{ 
  "Error": "Plugin returned error. 'var_a' must be set"
}

$ curl -k "https://$ipport/api/nomen.nescio/$guid/helloworld-runscript/helloworld-runscript?env_id=1&var_a=blobbyblobbyblobby"
{"JobId":346,"Text":"","PluginReturn":0,"PluginError":""}
```
This is what 'Type: 2' output looks like:
```
$ curl -k "https://$ipport/api/nomen.nescio/$guid/outputlines?job_id=346"
[
  {
    "Id": 356,
    "JobId": 346,
    "Serial": 1,
    "Text": "\nHello from test.centos.org\n\n\n---------\nArguments\n---------\nblobbyblobbyblobby\n-----------\nEnvironment\n-----------\nPWD=/tmp\nSHLVL=1\nSYSSCRIPTDIR=/var/lib/obdi-worker/scripts\n_=/bin/env\n"
  }
]
```
This is what 'Type: 2' output looks like:
```
$ curl -k "https://$ipport/api/nomen.nescio/$guid/helloworld-runscript/helloworld-runscript?env_id=1&var_a=blobbyblobbyblobby"
{"JobId":347,"Text":"","PluginReturn":0,"PluginError":""}

$ curl -k "https://$ipport/api/nomen.nescio/$guid/outputlines?job_id=347"
[
  {
    "Id": 357,
    "JobId": 347,
    "Serial": 1,
    "Text": "\n"
  },
  {
    "Id": 358,
    "JobId": 347,
    "Serial": 2,
    "Text": "Hello from test.centos.org\n"
  },
  {
    "Id": 359,
    "JobId": 347,
    "Serial": 3,
    "Text": "\n"
  },
  {
    "Id": 360,
    "JobId": 347,
    "Serial": 4,
    "Text": "\n"
  },
  {
    "Id": 361,
    "JobId": 347,
    "Serial": 5,
    "Text": "---------\n"
  },
  {
    "Id": 362,
    "JobId": 347,
    "Serial": 6,
    "Text": "Arguments\n"
  },
  {
    "Id": 363,
    "JobId": 347,
    "Serial": 7,
    "Text": "---------\n"
  },
  {
    "Id": 364,
    "JobId": 347,
    "Serial": 8,
    "Text": "blobbyblobbyblobby\n"
  },
  {
    "Id": 365,
    "JobId": 347,
    "Serial": 9,
    "Text": "-----------\n"
  },
  {
    "Id": 366,
    "JobId": 347,
    "Serial": 10,
    "Text": "Environment\n"
  },
  {
    "Id": 367,
    "JobId": 347,
    "Serial": 11,
    "Text": "-----------\n"
  },
  {
    "Id": 368,
    "JobId": 347,
    "Serial": 12,
    "Text": "PWD=/tmp\n"
  },
  {
    "Id": 369,
    "JobId": 347,
    "Serial": 13,
    "Text": "SHLVL=1\n"
  },
  {
    "Id": 370,
    "JobId": 347,
    "Serial": 14,
    "Text": "SYSSCRIPTDIR=/var/lib/obdi-worker/scripts\n"
  },
  {
    "Id": 371,
    "JobId": 347,
    "Serial": 15,
    "Text": "_=/bin/env\n"
  },
  {
    "Id": 372,
    "JobId": 347,
    "Serial": 16,
    "Text": ""
  }
]
```

The job and its output can also be viewed using the System Jobs viewer.

See [obdi-dev-repository](https://github.com/mclarkson/obdi-dev-repository)
for more information about Dev plugins.
