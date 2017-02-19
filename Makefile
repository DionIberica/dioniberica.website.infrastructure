container = dioniberica

submodules:
	git submodule init
	git submodule update

container:
	sudo lxc-create -t download -n $(container)
	sudo lxc-start -n $(container)
	echo "Container created! Add a reference in /etc/hosts"

setup:
	sudo lxc-attach -n $(container) -- apt install openssh-server python2.7
	sudo lxc-attach -n $(container) -- passwd ubuntu
	sudo ssh-copy-id -i ~/.ssh/id_rsa.pub ubuntu@local.$(container).com

dev:
	ansible-playbook development.yml -i hosts --ask-sudo-pass -e 'ansible_python_interpreter=/usr/bin/python2.7' --ask-vault-pass

pro:
	ansible-playbook production.yml -i hosts --ask-sudo-pass -e 'ansible_python_interpreter=/usr/bin/python2.7'  --ask-vault-pass
