sudo qemu-system-x86_64 \
	-m 8G \
	-boot d  -cdrom "$1" \
	-hda "$2" \
	#-drive format=raw,file=/dev/sda \
	#-drive format=raw,file=/dev/sdb \
	-net nic,model=virtio \
	-net user,hostfwd=tcp::2222-:22
	-enable-kvm
