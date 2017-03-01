# Oraclize Example App

That's a sample application to demonstrate working with Oraclize in Ethereum Studio.

* Clone the project to your workspace.
* Select the project and start a sandbox. It will use Oraclize sandbox plugin with the following params (see ethereum.json):

```
"plugins": {
  "oraclize": {
    "networkID": 161,
    "loadRealData": true
  }
},
```

You will see requests and response in Oraclize Panel and contract logs in Ethereum Console.
