nasm -f bin -o firstos.bin firstos.asm
dd status=noxfer conv=notrunc if=firstos.bin of=firstos.flp
qemu-system-i386 -fda firstos.flp
