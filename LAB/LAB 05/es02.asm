#Esercizio 2
#Scrivere un programma che verifichi se 
#la stringa introdotta dall'utente e' palindroma

	.data
msg:	.asciiz "Inserisci la stringa: "
msg1:	.asciiz "La stringa e' palindroma"
msg2:	.asciiz "La stringa non e' palindroma"

	.text
	.globl main
	.ent main
main:
	
	#la lettura della stringa viene fatta carattere
	#per carattere e usando lo stack come accumulatore dei caratteri
	
	li $t0, 0			#contatore dei caratteri
	addi $sp,$sp,-4	#calcolo l'indirizzo del primo carattere
	move $s0, $sp		#memorizzo l'indirizzo iniziale dello stack pointer
	#and $s0, $sp, $0
	
	la $a0, msg
	li $v0, 4
	syscall
	
read:
	li $v0, 12
	syscall				#leggo il carattere
	beq $v0, '\n', check
	sw $v0, ($sp)
	addi $sp, $sp, -4	#aggiorno lo stack pointer
	addi $t0, $t0, 1
	j read
	
check:
	move $s1, $sp		#memorizzo l'indirizzo finale dello stack pointer
	addi $s1, $s1, 4
	srl $t0, $t0, 1		#divido per 2 per calcolare il numero 
						#di controlli da effettuare
						
cycle:
	beq $t0, 0, pal
	ori $sp, $s0, 0	#indirizzo del primo carattere da confrontare
	addi $s0, $s0, -4	#punto al successivo
	lw $t1, ($sp)		#carico il carattere
	ori $sp, $s1, 0	#indirizzo del secondo carattere da confrontare
	addi $s1, $s1, 4	#punto al precedente
	lw $t2, ($sp)		#carico il carattere
	bne $t1, $t2, nopal	#se almeno un carattere non soddisfa la condizione 
						#allora la stringa non e' palindroma
	addi $t0, $t0, -1	#aggiorno il contatore del ciclo
	j cycle
	
pal:
	la $a0, msg1
	li $v0, 4
	syscall
	j fine
	
nopal:
	la $a0, msg2
	li $v0, 4
	syscall
	
fine:

	li $v0, 10
	syscall
	.end main






