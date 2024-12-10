	.data
prompt1: .asciiz "Introduza um numero\n"
result1: .asciiz "O factorial do número "
result2: .asciiz " é: "
	.text
	.global main
# b)
main:
	# print_str(prompt1)
	li $v0, 4
	la $a0, prompt1
	syscall

	# n = read_int();
	li $v0, 5
	syscall

	move $t1, $v0

	# f = factorial(n);
	move $a0, $t1
	jal factorial

	move $s0, $v0

	# print_str(result1)
	li $v0, 4
	la $a0, result1
	syscall

	# print_int10(n)
	li $v0, 1
	move $a0, $t1
	syscall

	# print_str(result2)
	li $v0, 4
	la $a0, result2
	syscall

	# print_int10(f)
	li $v0, 1
	move $a0, $s0
	syscall

	# exit()
	li $v0, 10
	syscall

# a)
factorial:
	# res = 1
	li $v0, 1
loop:
	# for (...; i>0; ...)
	blez $a0, loop_exit
	# res = res*i
	mul $v0, $v0, $a0
	# i--
	subi $a0, $a0, 1
	# repeat
	j loop
loop_exit:
	# return res
	jr $ra

