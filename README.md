# obdi-helloworld-runscript

This Obdi plugin has a UI and runs a script on a worker.

## Screenshot

![](images/helloworld-endpoint.png?raw=true)

## What is it?
A starting point for writing an Obdi plugin that runs a script on a local
or remote Obdi worker.

* This plugin has a Web Interface.
* This plugin adds a REST endpoint.

    A REST endpoint, '/helloworld-runscript', is added that can be accessed by
    other tools or from othe command line.

* This plugin runs a script on workers.
* This plugin does not use a private sqlite database.

Similar plugin: [obdi-saltkeymanager](https://github.com/mclarkson/obdi-saltkeymanager)

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
Type 1 output was used in the example Go code. Type 1 output can have multiple
records with multiple lines in each record. Type 2 output will only ever have
one record that may contain many lines.

The job and its output can also be viewed using the System Jobs viewer.

See [obdi-dev-repository](https://github.com/mclarkson/obdi-dev-repository)
for more information about Dev plugins.
