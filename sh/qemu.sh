sudo qemu-system-x86_64 \
	-m 8G \
	-hda "$1" \
	-smp 4 \
	-net nic,model=virtio \
	-net user,hostfwd=tcp::2222-:22
	--enable-kvm
