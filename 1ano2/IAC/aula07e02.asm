		.data
prompt1:	.asciiz "Introduza um numero\n"
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
	# move $t0, $v0
	or $t0, $zero, $v0
		
loop:
	bge $t1, $t0, exit
	addi $t1, $t1, 1
	# print_char('-')
	li $v0, 11
	li $a0, '-'
	syscall
	j loop
	
exit:
	# exit();
	li $v0, 10
	syscall