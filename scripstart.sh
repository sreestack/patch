#!/opt/rh/rh-python36/root/usr/bin/python3.6
import requests,json,smtplib,sys,threading,uuid,random,uuid,re,ssl,socket,textwrap,argparse
from datetime import *
from requests.packages.urllib3.exceptions import InsecureRequestWarning
import time as t
from os import system
aid = sys.argv[1]
passwd = sys.argv[2]
vmname = sys.argv[3]
def auth_token():
        url = "https://api.cloud.fmr.com/auth"
        headers = {'X-Auth-User':"aid",'X-Auth-Key':"passwd"}
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
        url = "https://api.cloud.fmr.com/vms/vm_summary?hostname="+vmname
        headers = {'X-Auth-Token': auth_token()}
        response= requests.get(url, headers=headers,verify='FECA.cer')
        data = json.loads(response.text)
        if 'msg' in data:
                print(vmname,'--> Not able to get VM Details')
                sys.stdout.flush()
        else:
                #vmstop(data['vm_id'],vmname)
                vmstart(data['vm_id'],vmname)

 

def vmdata(idnumber,name):
        headers = {'X-Auth-Token': auth_token()}
        url="https://api.cloud.fmr.com/vms/"+str(idnumber)+"/index"
        response= requests.get(url, headers=headers,verify='FECA.cer')
        data = json.loads(response.text)
        if response.text != "null":
                print(data['primary_hostname']+'-->'+data['vmname']+'-->'+data['state'])
                sys.stdout.flush()
        else:
                server=server+name+","
                print(name)
        sys.stdout.flush()

 

 

def vmstop(idnumber,name):
        headers = {'X-Auth-Token': auth_token()}
        url="https://api.cloud.fmr.com/vms/"+str(idnumber)+"/stop"
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

 

 

get_vmid(vmname)

