		.data
prompt1:	.asciiz "Introduza um numero\n"
strpar:		.asciiz "O numero é par\n"
strimp:		.asciiz "O numero é impar\n"
	 	.text
	 	.globl main
main:
	# print_string(prompt1);
	li $v0, 4
	la $a0, prompt1
	syscall
	
	# a = read_int();
	li $v0, 5
	syscall
	
	# a & 1
	andi $t0, $v0, 1
	# Load print_string vector (optimize)
	li $v0, 4
	# if((a & 1) == 0) par
	beqz $t0, par
	
	# else
	# Load print_string str (optimize)
	la $a0, strimp
	
exit:
	# Issue print_string (optimize)
	syscall
	# exit();
	li $v0, 10
	syscall
	
par:
	# Load print_string str (optimize)
	la $a0, strpar
	j exit
	