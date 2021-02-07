# Import-ScriptConfigFile
Function that is used to read in a configuration file for all your set parameters. This allows a script to be executed with a particular set of parameters that you would like to be set each time. 

In order for this to work, the configuration file needs to be in a json format. The function loads the content up and converts it from a json file type and then for each of the members of the file, we set the variables as a script scope so they can be used throughout the script.

# How To Use 

Use the following sample code within your script:

```
$configPath = "{0}\{1}.json" -f (Split-Path -Parent $MyInvocation.MyCommand.Path), (Split-Path -Leaf $MyInvocation.MyCommand.Path)

if (Test-Path $configPath) {
    Import-ScriptConfigFile -ScriptConfigFileLocation $configPath 
}

```

Here is how you can setup your .json file.

```
{
  "EnableEmailNotification": false,
  "SMTPSender": "david@adt.local",
  "EventID": 2024,
  "MDBFailureItemTags": [
    38,
    39
  ],
  "ExtraTraceConfigFileContent": [
    "TraceLevelsDebug,Warning,Error,Fatal,Info,Performance,Function,Pfd",
    "ManagedStore.MapiDispRpcBuffer,RpcOperation,RpcDetail,RpcContextPool",
    "ManagedStore.MapiRpcGeneral,RpcOperation,FaultInjection",
    "MapiNettagCxhPool,tagLocation",
    "ManagedStore.RpcProxyProxyAdmin",
    "FilteredTracingNo",
    "InMemoryTracingNo"
  ]
}
```