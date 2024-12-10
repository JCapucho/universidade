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
	
	# if((a & 1) == 0) par
	andi $t0, $v0, 1
	beqz $t0, par
	
	# else
	# print_string(strimp);
	li $v0, 4
	la $a0, strimp
	syscall
	
exit:
	# exit();
	li $v0, 10
	syscall
	
par:
	# print_string(strpar);
	li $v0, 4
	la $a0, strpar
	syscall
	j exit
	