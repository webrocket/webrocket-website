---
title: Getting familiar with WebRocket Admin tool
kind:  article
group: docs
---

### Concept

WebRocket is a distributed, fault tollerant system which should be reconfigured
without need of restarting the server. That's why `webrocket-admin` tool has to
be introduced to manage nodes, vhosts and its configurations.

### Basic usage

Current implementation of `webrocket-admin` tool is yet very simple but 
totally enough for all the needs. It allows to **manage vhosts**, **manage
channels**, **regenerate access tokens**, and get information about
**connected backend workers**. Admin tool can be used as following:

    $ webrocket-admin [options] command [args...]

Here's few examples...

#### Managing vhosts

    $ webrocket-admin add_vhost /moon
    /moon
    b444aa042e176fe65be600a92fc71f926ee71ee6
    
Successfull operation displays created vhost's name and its **access token**.
Access token shall be used to configure backend clients and workers. 

Vhosts can be listed (`list_vhosts`), deleted (`delete_vhost`) or displayed
with its information (`show_vhost`) too. It is also possible to delete all
the vhosts at one time (`clear_vhosts`).
    
#### Managing channels

    $ webrocket-admin add_channel /moon greetings
    
No output is displayed on success.

Similar to vhosts, channels can be listed (`list_channels`), deleted
(`delete_channel`) or deleted all (`clear_channels`).
    
#### Regenerating vhost token

    $ webrocket-admin regenerate_vhost_token /moon
    dd564f9355fe5ed09b716109469b0cedf2d40d22
    
New access token is displayed on success.

#### Workers listing

    $ webrocket-admin list_workers /moon
    
This command will list all the backend workers connected to the vhost.

### Advanced usage

To get more information about possible options of `webrocket-admin` tool 
check its documentation, help screen (`webrocket-admin -help`) or manual
pages (`man webrocket-admin`).
