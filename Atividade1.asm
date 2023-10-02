.data
x: .asciz "Entre com o valor de X: "
y: .asciz "Entre com o valor de Y: "
xy: .asciz "A soma de X e Y é: "

.text

	#ESCRITA DO X
	addi a7, zero, 4
	la a0, x
	ecall
	
	#LEITURA DO X
	addi a7, zero, 5
	ecall 
	add s0, zero, a0
	
	#ESCRITA DO Y
	addi a7, zero, 4
	la a0, y
	ecall
	
	#LEITURA DO Y
	addi a7, zero, 5
	ecall 
	add s1, zero, a0
	
	#SOMA
	add s2, s0, s1
	
	#ESCRITA DO XY
	addi a7, zero, 4
	la a0, xy
	ecall
	
	
	#LEITURA DA SOMA
	addi a7, zero, 1
	add a0, zero, s2
	ecall
	
	
	