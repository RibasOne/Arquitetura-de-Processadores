.text
add a0, zero, zero  #i = 0
addi t1, zero, 10   #x = 10
for: beq a0, t1, fim
	#ESCRITA
	addi a7, x0, 1
	ecall
	addi a0, a0, 1 # i++
	jal x0, for
fim:
	addi a7, x0, 10
	ecall