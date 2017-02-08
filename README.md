# ansible
Ansible files for provisioning linux servers, for software development.


# FYI: To run playbooks locally (the current user must have sudo rights)
$ ansible-playbook plays/name-of-playbook.yml -l name-of-local-machine --connection=local


# Bare minimum setup
Make sure your hosts file has the correct values.
Run the playbooks as a user that has sudo rights (without password).


# Provisioning a server:
1. Ensure the server has a user with passwordless sudo rights, and that ansible is installed.
Refer to the ansible-setup.sh file.
2. Create the ansible.cfg file (refer to ansible.cfg.dist file),
make sure that the "remote_user" variable is set to a user that has passwordless sudo rights.
3. If you want to also create user accounts, then create users.json file in vars directory (refer to vars/users.json.dist).
4. Run the dev-server-setup playbook
$ ansible-playbook plays/dev-server-setup.yml -l hostname --connection=local



# Running playbooks for remote server
1. Ensure that the remote server has a user with passwordless sudo rights, and that ansible is installed.
Refer to the ansible-setup.sh file.
2. Ensure that the "remote_user" variable matches the user from step #1.
3. Run the dev-server-setup playbook
$ ansible-playbook plays/dev-server-setup.yml -l hostname
