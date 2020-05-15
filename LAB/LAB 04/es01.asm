#esercizio 1: primi 20 numeri della serie di fibonacci

	.data
wVett:	.word 20
DIM=20

	.text
	.globl main
	.ent main
	
main:
	la $t0, wVett		#indirizzo del vettore
	li $t1, 0			#contatore
	
	#primo elemento
	addi $s1, $0, 1		#buffer per la somma
	sw $s1, 0($t0)		#salvo in memoria
	sll $t0, $t0, 2		#avanzo l'indirizzo
	addi $t1, $t1, 1	#incremento il contatore
	
	#secondo elemento
	addi $s1, $0, 1
	sw $s1, 0($t0)
	sll $t0, $t0, 2
	addi $t1, $t1, 1
	
loop:
	move $s1, $t0		#salvo l'indirizzo del vettore
	addi $s2, $s1, -4	#calcolo l'indirizzo di v[i-1]
	addi $s3, $s1, -8	#calcolo l'indirizzo di v[i-2]
	lw $t4, 0($s2)		#carico il valore v[i-1]
	lw $t5, 0($s3)		#carico il valore v[i-2]
	add $s1, $t4, $t5	#calcolo il valore da caricare
	sw $s1, 0($t0)		#salvo in memoria
	sll $t0, $t0, 2		#avanzo l'indirizzo
	addi $t1, $t1, 1	#incremento il contatore
	blt $t1, DIM, loop
	
	li $v0, 10
	syscall 
	
	.end main
	
	
	
	




















