	.data
src: .asciiz "MAU"
dst: .asciiz "BOM DIA"
	.text
	.global main
main:
	# dst = strcopy(dst, src);
	la $a0, dst
	la $a1, src
	jal strcopy

	# print_str(dst)
	move $a0, $v0
	li $v0, 4
	syscall

	# exit()
	li $v0, 10
	syscall

strcopy:
	# i=0
	move $t0, $zero
loop:
	# src[i]
	add $t1, $a1, $t0
	lb $t2, 0($t1)
	# while ( src[i] != '\0')
	beqz  $t2, loop_exit
	# dst[i] = src[i]
	add $t1, $a0, $t0
	sb $t2, 0($t1)
	# i++
	addi $t0, $t0, 1
	# repeat
	j loop
loop_exit:
	# dst[i] = '\0'
	add $t1, $a0, $t0
	sb $zero, 0($t1)
	move $v0, $a0
	# return dst
	jr $ra

