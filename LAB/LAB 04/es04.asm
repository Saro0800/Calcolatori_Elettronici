#Esercizio 4: moltiplicazione tra vettori (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
	.data
	
NumElem=10
DimVett=NumElem*4
DIM=NumElem*NumElem*4
wVett1:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
wVett2:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
mRes:	.space DIM

	.text
	.globl main
	.ent main
	
main:
	li $s0, 0	#indice delle righe
	li $s1, 0	#indice delle colonne
	li $s2, 0	#indice della matrice linearizzata
	
loop_ext:
	lw $t0, wVett1($s0)
	j loop_int
return:
	li $s1, 0
	addi $s0, $s0, 4
	blt $s0, DimVett, loop_ext
	j end

loop_int:
	lw $t1, wVett2($s1)
	mul $t2, $t1, $t0
	sw $t2, mRes($s2)
	addi $s2, $s2, 4
	addi $s1, $s1, 4
	blt $s1, DimVett, loop_int
	j return
	
end:
	li $v0, 10
	syscall
	
	.end main
