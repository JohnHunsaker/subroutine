#MIPS Assembly Programming Practice Exercise - Subroutine
#Written by John Hunsaker

.data

intro1: .asciiz "This program solves the equation: 5u^2 - 12uv + 6v^2.\n"
intro2: .asciiz "Enter values for U and V, however if you want the program to end, enter '0' for both."
enteru: .asciiz "Enter Integer Value for U, then press enter: "
enterv: .asciiz "Enter Integer Value for V, then press enter: "
result: .asciiz "The result is: "
goodbye: .asciiz "End of program. Goodbye."
newline: .asciiz "\n\n"

.text
.globl main

main:

loop:

#Print Intro
la $a0, intro1
addi $v0, $zero, 4
syscall
la $a0, intro2
addi $v0, $zero, 4
syscall

#Print Newline
la $a0, newline
addi $v0, $zero, 4
syscall

#Call subroutine to get solution
jal Subroutine
nop

Subroutine:   

   #Print U Info
   la $a0, enteru
   addi $v0, $zero, 4
   syscall

   #Read U Info
   addi $v0, $zero, 5
   syscall
   move $s0, $v0

   #Print Newline
   la $a0, newline
   addi $v0, $zero, 4
   syscall

   #Print V Info
   la $a0, enterv
   addi $v0, $zero, 4
   syscall

   #Read V Info
   addi $v0, $zero, 5
   syscall
   move $s1, $v0

   #Print Newline
   la $a0, newline
   addi $v0, $zero, 4
   syscall

   #Quit loop if two 0's entered.
   li $t6, 0
   add $t7, $s0, $s1
   beq  $t7, $t6, brk

   #Solve for 5u^2
   li $t2, 5
   mul $t3, $s0, $s0
   mul $t3, $t3, $t2
   
   #Solve for 12uv
   li $t2, 12
   mul $t4, $s0, $s1
   mul $t4, $t4, $t2

   #Solve for 6v^2
   li $t2, 6
   mul $t5, $s1, $s1
   mul $t5, $t5, $t2

   #Solve for 5u^2 - 12uv + 6v^2
   sub $t2, $t3, $t4
   add $t2, $t2, $t5

   #Print Result String
   la $a0 result
   addi $v0 $zero 4
   syscall

   #Print Result Number
   move $a0 $t2
   addi $v0 $zero 1
   syscall

   #Print newline.
   la $a0, newline
   addi $v0, $zero, 4
   syscall

   #Print newline.
   la $a0, newline
   addi $v0, $zero, 4
   syscall

   #Print newline.
   la $a0, newline
   addi $v0, $zero, 4
   syscall

   j loop
   nop

brk:
   la $a0, goodbye
   addi $v0, $zero, 4
   syscall
   li $v0, 10
   syscall
