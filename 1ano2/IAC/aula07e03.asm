		.data
prompt1:	.asciiz "Introduza um numero\n"
result:		.asciiz "O fatorial do numero inserido é: "
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
	
	# f = 1
	ori $t0, $t0, 1
			
loop:
	# i > 0
	blez $v0, exit
	# f = f * i
	mul $t0, $t0, $v0
	# i--
	addi $v0, $v0, -1
	j loop
	
exit:
	# print_string(result);
	li $v0, 4
	la $a0, result
	syscall
	
	# print_int10(f);
	li $v0, 1
	or $a0, $zero, $t0
	syscall
	
	# exit();
	li $v0, 10
	syscall