#Esercizio 2: realizzazione di uno switch

	.data
opa: .word 2043
opb: .word 5
res: .space 4
tab: .word sum, sott, molt, divis

	.text
	.globl main
	.ent main

main:
	lw $t1, opa
	lw $t2, opb
	li $v0, 5
	syscall
	
	move $t0, $v0
	sll $t0, $t0, 2
	lw $t0, tab($t0)
	jr $t0
	
sum: 
	add $t3, $t1, $t2
	j fine

sott:
	sub $t3, $t1, $t2
	j fine
	
molt:
	mul $t3, $t1, $t2
	j fine
	
divis:
	div $t3, $t1, $t2
	j fine
	
fine:
	sw $t3, res
	
	li $v0, 10
	syscall
	
	.end main


	
















