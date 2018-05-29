# Table of Contents
1. [Introduction](#Introduction) 
2. [Librarys](#Librarys)
    1. [RTTP](#RTTP)
         1. [Functions](#RTTP-Library-Functions)
         2. [Example](#RTTP-Examples)
<a name="Introduction"/>
## Introduction 

This source tree is SKPKP Server automation and monitoring system.

Thus, this is not used **officially** and **real world product**

STATUS : **UNDER PROGRESS**
 <a name="Librarys"/>
## Librarys

Following sections is description of Librarys which is needed for development

The status of development

|Name   |       Status   |
|:-----:|:-----------------:|
| RTTP  | **Under Prograss**|

<a name="RTTP"/>

### RTTP

This section is description of RTTP Library.

RTTP is abbreviation of "Rednet Text Transfer Protocol" 

The ComputerCraft support **rednet API** functions that work like minimal **Socket**. So that make a lot of repetitive codes for networking via **rednet API**. For that reason, I decide to develop **RTTP Library**

RTTP works like minimal **HTTP**, So RTTP provides you the simple-text-transfer way.
<a name="RTTP-Library-Functions"/>
#### RTTP Library Functions 
|Function           |   Description        |                Arguments              |                      Returns    |
|:-----------------:|:--------------------:|:-------------------------------------:|:-------------------------------:|
| open(side)            |Open the network side | side : The side of network line connection |                                 |
| close(side)           | Close the network side| side : The side of network line connection |                                 |
| run(hostname, targets)|  Rttp server hosting at **hostname** | hostname: Identifire for addressing<br>targets : API Call table    |  |
| get(address, location, data, timeout)| Reqeust to the server  | Address: the hostname you want to request <br> location : api name<br> data: Text data which want to send<br>timeout:Request timeout | response_code, response_data|                           

<a name="RTTP-Examples"/>

#### RTTP Examples  

###### Server Example

```lua
os.loadAPI("rttp")

target = {}

target["/test"] = function(data)
    print(data)
    return rttp.receive(200, "OK")
end

rttp.open("right")
rttp.run("Test", target)
```

###### Client Example
```lua
os.loadAPI("rttp")

rttp.open("left")
code, response = rttp.get("Test", "/test", "HI")

print(code)
print(response)
```
