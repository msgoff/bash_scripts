new_install:
	@sudo apt update -y
	@sudo apt install ansible -y
	ansible-galaxy collection install community.general
	ansible-playbook apt.yml

