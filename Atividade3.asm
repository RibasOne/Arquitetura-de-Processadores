.data
A: .word 0,0,0,0,0,0,0,0
entre: .asciz "Entre com A["
fecha: .asciz "] = "
saida: .asciz " A["

.text

addi t1, x0, 8
la s0, A

for: beq t0, t1, fim_for
	#ESCRITA
	addi a7, x0, 4
	la a0, entre
	ecall
	#ESCRITA INT
	addi a7, x0, 1
	add a0, x0, t0
	ecall
	#ESCREVER STRING
	addi a7, x0, 4
	la a0, fecha
	ecall
	#LER INTEIRO
	addi a7, x0, 5
	ecall
	#ARMAZENA
	slli t4, t0, 2 # 4 * i
	add t4, t4, s0 # base + i
	sw a0, 0(t4) # A[i] = A0
	addi t0, t0, 1
	jal x0, for 
fim_for:

	add t0, zero, zero # i = 0
	for2: beq t0, t1, fim_for2
		addi a7, x0, 4
		la a0, saida
		ecall
		addi a7, x0, 1
		add a0, x0, t0
		ecall
		addi a7, x0, 4
		la a0, fecha
		ecall
		#load
		slli t4, t0, 2
		add t4, t4, s0
		lw a0, 0(t4)
		addi a7, x0, 1
		ecall
		addi t0, t0, 1
		jal x0, for2
fim_for2:
