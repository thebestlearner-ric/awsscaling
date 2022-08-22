# awsscaling
Description: 

## Common Git Error 
Read "how to use git.md"

## Working with AWS
Change permission of keypair (generated from AWS)
'''
chmod 600 keypair_name.pem
'''

## Working with Ansible
In order to ansible to access EC2 instance, there are a 4 ways to do it
1. Add a local ansible.cfg and in it add the code below:
'''
[defaults]
host_key_checking = False
'''
2. Change the default /etc/ansible.cfg and add the code below:
'''
[defaults]
host_key_checking = False
'''
3. Set an ansible environment on the terminal
'''
export ANSIBLE_HOST_KEY_CHECKING=False 
''' 
4. Add it as additional parameters to the ansible-playbook command
'''
ansible-playbook play.yml --ssh-common-args='-o StrictHostKeyChecking=no'
'''