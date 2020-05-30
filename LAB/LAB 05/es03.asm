#Esercizio 3
#Algoritmo per il riconoscimento delle soluzioni di una equazione
#di secondo grado
#Attenzione: i coefficienti vengono inseriti dall'utente

	.data
msgA:	.asciiz "Inserisci il coefficiente a: "
msgB:	.asciiz "Inserisci il coefficiente b: "
msgC:	.asciiz "Inserisci il coefficiente c: "
msgR:	.asciiz "L'equazione inserita ha soluzioni reali \n\n"
msgCmp:	.asciiz "L'equazione inserita ha soluzioni complesse \n\n"
msgEnd:	.asciiz "Fine esecuzione"

	.text
	.globl main
	.ent main
	
main:	

	#Coefficiente A
	la $a0, msgA
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0		# $s1: a
	
	#Coefficiente B
	la $a0, msgB
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s2, $v0		# $s2: b
	
	#Coefficiente C
	la $a0, msgC
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s3, $v0		# $s3: c
	
	#calcolo il delta
	mul $t0, $s2, $s2	#b^2
	mul $t1, $s1, $s3	#a*c
	sll $t1, $t1, 2		#4ac
	sub $t0, $t0, $t1	#b^2 - 4ac
	
	slt $t1, $0, $t0	#controllo se delta<0
	beq $t1, 0, complex
	
real:	
	la $a0, msgR
	li $v0, 4
	syscall
	li $t0, 1
	beq $t0, 1, end

complex:
	la $a0, msgCmp
	li $v0, 4
	syscall
	
end:	
	la $a0, msgEnd
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	.end main



	