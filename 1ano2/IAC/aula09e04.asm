	.data
prompt1: .asciiz "\nInsira a frase1: "
prompt2: .asciiz "\nInsira a frase2: "
result1: .asciiz "\n O numero de caracteres da frase1 é: "
result2: .asciiz "\nA frase concatenada é: "
frase1: .space 20
frase2: .space 20
frase3: .space 40
	.text
	.global main
main:
	# print_str(prompt1)
	li $v0, 4
	la $a0, prompt1
	syscall

	# read_string(frase1, 20)
	li $v0, 8
	la $a0, frase1
	li $a1, 20
	syscall

	# print_str(prompt2)
	li $v0, 4
	la $a0, prompt2
	syscall

	# read_string(frase2, 20)
	li $v0, 8
	la $a0, frase2
	li $a1, 20
	syscall

	# print_str(result1)
	li $v0, 4
	la $a0, result1
	syscall

	# n = strlen( frase1 )
	la $a0, frase1
	jal strlen
	# print_int10(n)
	move $a0, $v0
	li $v0, 1
	syscall

	# str_copy( frase3,frase1 )
	la $a0, frase3
	la $a1, frase1
	jal strcopy

	# str_cat( frase3,frase2 )
	la $a0, frase3
	la $a1, frase2
	jal strcat

	# print_str(result2)
	li $v0, 4
	la $a0, result2
	syscall

	# print_str(frase)
	li $v0, 4
	la $a0, frase3
	syscall

	# exit()
	li $v0, 10
	syscall


strlen:
	# n=0
	move $v0, $zero
	# i=0
	move $t0, $zero
strlen_loop:
	# str[i++]
	add $t1, $a0, $t0
	lb $t2, 0($t1)
	# i++
	addi $t0, $t0, 1
	# while ( str[i++] != '\0')
	beqz  $t2, strlen_exit
	# n++
	addi $v0, $v0, 1
	# repeat
	j strlen_loop
strlen_exit:
	# return res
	jr $ra


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
