#Esercizio 5

	.data
Rig=3
Col=5
#DIM=(Rig+1)*(Col+1)*4-4
DIM=92
mMatrx:	.word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0
comma:	.asciiz " "
new_line:	.asciiz "\n"
	.text
	.globl main
	.ent main

main:
	li $t0, 0	#indirizzo della cella
	li $t1, 0	#contatore delle colonne per riga
	li $s0, 0	#accumulatore delle righe
		
	#calcolo delle righe
r_loop:
	lw $t2, mMatrx($t0)
	add $s0, $s0, $t2
	addi $t0, $t0, 4
	bgt $t0, DIM, exit1
	addi $t1, $t1, 1
	blt $t1, Col, r_loop
	sw $s0, mMatrx($t0)
	addi $t0, $t0, 4
	li $s0, 0
	li $t1, 0
	j r_loop
	
exit1:
	li $t0, 0	#indirizzo della cella
	li $t1, 0	#contatore delle righe per colonna
	li $s0, 0	#accumulatore delle colonne
	#calcolo dell'offset per spostarsi tra le colonne
	li $s1, Rig
	addi $s1, $s1, 1
	li $s2, Col
	addi $s2, $s2, 1
	mul $s1, $s1, $s2	#offset
	
	#calcolo l'offset per andare alla prossima colonna
	li $s4, Rig
	li $s5, Col
	addi $s5, $s5, 1
	mul $s4, $s4, $s5
	addi $s4, $s4, -1
	sll $s2, $s4, 2
	
c_loop:
	lw $t2, mMatrx($t0)
	add $s0, $s0, $t2
	add $t0, $t0, $s1
	bgt $t0, DIM, exit2
	addi $t1, $t1, 1
	blt $t1, Rig, c_loop
	sw $s0, mMatrx($t0)
	sub $t0, $t0, $s2
	li $s0, 0
	li $t1, 0
	j c_loop

exit2:
	li $t0, 0
	li $s0, 0
	li $s1, 0
	addi $t1, $0, Rig
	addi $t1, $t1, 1

	addi $t2, $0, Col
	addi $t2, $t2, 1

print_ext:
	j print_int
return:
	la $a0, new_line
	li $v0, 4
	syscall
	li $s1, 0
	addi $s0, $s0, 1
	blt $s0, $t1, print_ext
	j end

print_int:
	lw $a0, mMatrx($t0)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	addi $t0, $t0, 4
	addi $s1, $s1, 1
	blt $s1, $t2, print_int
	j return
	
end:

	li $v0, 10
	syscall
	
	.end main
	

	