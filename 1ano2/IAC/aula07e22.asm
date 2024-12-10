     .data
   prompt1:		.asciiz "Introduza um numero: "
   result:		.asciiz "\n O numero em hexadecimal é: "
     .text
     .globl main
   main:
     # print_string(prompt1);
     li $v0, 4
     la $a0, prompt1
     syscall
     # num = read_int();
     li $v0, 5
     syscall
     ori $t0, $v0, 0
     # print_string(result);
     li $v0, 4
     la $a0, result
     syscall
     # n = 0
     or $t1, $zero, $zero
     li $t2, 32
     li $t3, 0x80000000
   loop:
     # n < 32
     bge $t1, $t2 exit

     # num & 0x80000000
     and $t4, $t0, $t3
     # (num & 0x80000000) >> 31
     srl $a0, $t4, 31
     # print_int10((num & 0x80000000) >> 31);
     li $v0, 1
     syscall

     # num = num << 1;
     sll $t0, $t0, 1
     
     # n++
     addi $t1, $t1, 1
     j loop

   exit:
     # exit();
     li $v0, 10
     syscall
