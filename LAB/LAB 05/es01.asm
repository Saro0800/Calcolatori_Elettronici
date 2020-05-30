#Esercizio 1

	.data
num:	.word 3141592653
msg:	.asciiz "Numero inserito: "

	.text
	.globl main
	.ent main

main: 
	#devo prendere il numero ed eseguire ripetutamente
	#delle divisioni per 10 e salvare il resto nello stack.
	#successivamente devo leggere lo stack in maniera inversa.
	
	#lo stack va da indirizzi alti ad indirizzi bassi, quindi per salvare una
	#variabile occore diminuire lo stack pointer ($sp) di 4, e 
	#per leggerlo occore aumentarlo di 4
	
	li $t0, 10		#costante della divisione
	lw $t1, num		#carico il num
	li $s0, 0		#numero di cifre per la stampa
	
	#ciclo dei calcolo dei resti
cycle1:
	divu $t1, $t0	#divisione per 10
	mfhi $t2		#salvo il resto
	addi $sp,$sp,-4	#aggiorno sp
	sw $t2, ($sp)	#salvo nello stack
	mflo $t1		#aggiorno il valore del numero
	addi $s0,$s0,1	#aumento il contatore delle cifre
	beq $t1, 0, cycle2	#controllo che la divisione non abbia dato
						#0 come risultato (condizione di terminazione)
	j cycle1
	
	lw $a0, msg
	li $v0, 4
	syscall
	
	#ciclo di stampa
cycle2:
	lw $a0, ($sp)
	addi $a0, $a0, '0'	#è richiesto che vengano stampati come caratteri
	li $v0, 11
	syscall
	addi $sp,$sp,4
	addi $s0, $s0, -1
	beq $s0, 0, fine
	j cycle2
	
fine:
	li $v0, 10
	syscall
	.end main
	

	
	



