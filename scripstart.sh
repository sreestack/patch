#!/bin/python3
import requests,json,smtplib,sys,threading,uuid,random,uuid,re,ssl,socket,textwrap,argparse
from datetime import *
from requests.packages.urllib3.exceptions import InsecureRequestWarning
import time as t
from os import system

 

aid = sys.argv[1]
token = sys.argv[2]
box = sys.argv[3]

print (aid,token,box) 

def auth_token():
        url = "https://api.cloud.fmr.com/auth"
        headers = {'X-Auth-User':"aid",'X-Auth-Key':"token"}
        response = requests.request("GET",url,headers=headers,verify='FECA.cer')
        if response.status_code == 200:
                print('Auth Token obtained Successfully ')
                sys.stdout.flush()
                return(response.headers['X-Auth-Token'])
        else:
                print(response)
                sys.stdout.flush()
                sys.exit(0)

 

 


def get_vmid(vmname):
        url = "http://api.cloud.fmr.com/vms/vm_summary?hostname="+vmname
        headers = {'X-Auth-Token': auth_token()}
        response= requests.get(url, headers=headers,verify='FECA.cer')
        data = json.loads(response.text)
        print(data)
        #        print(vmname,'--> Not able to get VM Details')
        #        sys.stdout.flush()
        #        failed_list.append(vmname)
        #else:
        #        details=data['vm_id']
        #        print(details)

 


def patchvm(idnumber,name):
        headers = {'X-Auth-Token': auth_token()}
        url="https://api.cloud.fmr.com/vms/"+str(idnumber)+"/patch"
        response= requests.post(url, headers=headers,verify='FECA.cer')
        data = json.loads(response.text)
        if response.text != "null":
                print(data)
                sys.stdout.flush()
        else:
                server=server+name+","
                print(name)
        sys.stdout.flush()

 


def vmstart(idnumber,name):
        headers = {'X-Auth-Token': auth_token()}
        url="https://api.cloud.fmr.com/vms/"+str(idnumber)+"/start"
        response= requests.post(url, headers=headers,verify='FECA.cer')
        data = json.loads(response.text)
        if response.text != "null":
                print(data)
                sys.stdout.flush()
        else:
                server=server+name+","
                print(name)
        sys.stdout.flush()

 

get_vmid(box)
