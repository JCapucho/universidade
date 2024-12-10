	.data
src: .asciiz "MAU"
dst: .asciiz "BOM DIA"
	.text
	.global main
main:
	# dst = strcat(dst, src);
	la $a0, dst
	la $a1, src
	jal strcat

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
strcopy_loop:
	# src[i]
	add $t1, $a1, $t0
	lb $t2, 0($t1)
	# while ( src[i] != '\0')
	beqz  $t2, strcopy_exit
	# dst[i] = src[i]
	add $t1, $a0, $t0
	sb $t2, 0($t1)
	# i++
	addi $t0, $t0, 1
	# repeat
	j strcopy_loop
strcopy_exit:
	# dst[i] = '\0'
	add $t1, $a0, $t0
	sb $zero, 0($t1)
	move $v0, $a0
	# return dst
	jr $ra

strcat:
	# aux = dst
	sw $a0, 0($sp)
	addi $sp, $sp, 4

strcat_loop:
	# *dst
	lb $t0, 0($a0)
	# while ( *dst != '\0')
	beqz  $t0, strcat_exit
	# dst++
	addi $a0, $a0, 1
	# Repeat
	j strcat_loop

strcat_exit:
	# strcopy (prologue) - Save $ra
	sw $ra, 0($sp)
	addi $sp, $sp, 4
	# strcopy(dst, src)
	jal strcopy
	# strcopy (epilogue) - Restore $ra
	subi $sp, $sp, 4
	lw $ra, 0($sp)
	# $v0 = aux
	subi $sp, $sp, 4
	lw $v0, 0($sp)

	jr $ra
