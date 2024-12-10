		.data
prompt:		.asciiz "Introduza um numero: "
result:		.asciiz "A soma dos cinco números é: "
	 	.text
	 	.globl main
main:
	ori $t1, $zero, 5
loop:
	# i > 0
	blez $t1, exit
	
	# print_string(prompt);
	li $v0, 4
	la $a0, prompt
	syscall
	# a = read_int();
	li $v0, 5
	syscall
	# soma += a
	add $t0, $t0, $v0
	
	# i--
	addi $t1, $t1, -1
	j loop
	
exit:
	# print_string(result);
	li $v0, 4
	la $a0, result
	syscall
	
	# print_int10(soma);
	li $v0, 1
	or $a0, $zero, $t0
	syscall
	
	# exit();
	li $v0, 10
	syscall

# void main(void)
# {
# 	int i, r, soma;
# 	char prompt[] = "Introduza um numero: ";
# 	char result[] = "A soma dos cinco números é: ";
# 
# 	for (i = 5; i>0; i--)
# 	{
# 		print_str(prompt);
# 		r = read_int();
# 		soma += r;
# 	}
# 
# 	print_str(result);
# 	print_int10(soma);
# 	exit(); //system call 10
# }