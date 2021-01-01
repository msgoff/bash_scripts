sudo qemu-system-x86_64 \
	-m 2000M \
	-boot d  -cdrom /mnt/ramdisk/acronis.iso \
	-drive format=raw,file=/dev/sda \
	-drive format=raw,file=/dev/sdb \
	-enable-kvm
