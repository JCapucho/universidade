	.data
prompt1: .asciiz "123456"
	.text
	.global main
# e)
main:
	# n = strlen(prompt1);
	la $a0, prompt1
	jal strlen

	# print_int10(n)
	move $a0, $v0
	li $v0, 1
	syscall

	# exit()
	li $v0, 10
	syscall

# d)
strlen:
	# n=0
	move $v0, $zero
	# i=0
	move $t0, $zero
loop:
	# str[i++]
	add $t1, $a0, $t0
	lb $t2, 0($t1)
	# i++
	addi $t0, $t0, 1
	# while ( str[i++] != '\0')
	beqz  $t2, loop_exit
	# n++
	addi $v0, $v0, 1
	# repeat
	j loop
loop_exit:
	# return res
	jr $ra

