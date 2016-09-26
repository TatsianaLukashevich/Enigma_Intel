CC=gcc
ASMBIN=nasm

all : asm cc link
asm : 
	$(ASMBIN) -o kodowanie.o -f elf -l kodowanie.lst kodowanie.asm
cc :
	$(CC) -m32 -c -g -O0 main.cc &> errors.txt
link :
	$(CC) -m32 -o test main.o kodowanie.o
clean :
	rm *.o
	rm test
	rm errors.txt	
	rm kodowanie.lst
