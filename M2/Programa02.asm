# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 03 – Programação de Procedimentos
# Grupo: - Cauã Ribas
#	     - Nilson Andrade
#	     - Haran Souza
# 
.data # Dados
	vetor: .word
	min_tam: .word 2
	max_tam: .word 100
	texto_input: .asciz "\nInforme até qual posição o vetor será somado(2-100): "
	texto_resultado: .asciz "\nResultado da soma dos elementos do vetor: "
	
.text # Codigo
	jal zero, main # Executa o main antes das funções
	
loop_define_tam_vetor:
	# Imprime: String texto_input, ate que o usuario defina um valor valido para o tamanho do vetor
	addi a7, zero, 4 # Adiciona o valor 4 ao registrador de serviço a7 (PrintString)
	la a0, texto_input # Carrega o texto texto_input ao registrador a0
	ecall # Chama o syscall
	
	# Solicita: Int tamanho do vetor
	addi a7, zero, 5 # Adiciona o valor 5 ao registrador de serviço a7 (ReadInt)
	ecall # Chama o syscall
	add s0, zero, a0 # Input do usuario (registrador a0), é salvo no registrador s0
	
	blt s0, t0, loop_define_tam_vetor # Verifica se a0 é menor que o tamanho mínimo
	bgt s0, t1, loop_define_tam_vetor # Verifica se a0 é maior que o tamanho máximo
	
inicializar_vetor: # Dinamicamente preenche o vetor ate a posicao informada
	# Salvando os Registradores na Pilha - Push
	addi sp, sp, -12
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw ra, 8(sp)
	
	add s0, zero, a0 # Inicializando s0 com o endereço base do vetor
	add s1, zero, a1 # Inicializando s1 com o numero de posições do vetor
	
	li t0, 0 # Inicializando variavel i com 0
	j inicializar_loop_vetor # Inicia o loop
	
inicializar_loop_vetor:
	bge t0, s1, inicializar_vetor_fim # Verificando se o numero de posições do vetor foi alcançado(se t0 >= s1 termina o loop)
	
	slli t1, t0, 2 # Move 2 bits para a esquerda: 4 * i
	add t2, s0, t1 # Calcula a posicao no vetor desde o seu comeco: comeco do vetor + (4 * i)
	
	sw t0, 0(t2) # Guarda o valor informado pelo usuario no t0, com um offset de 0 bits, no vetor (a0)
	
	addi t0, t0, 1 # Incremento do contador: i = i + 1
	
	j inicializar_loop_vetor # "Reinicia o loop"
	
inicializar_vetor_fim:
	# Retirando os Registradores da Pilha - Pop
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw ra, 8(sp)
	addi sp, sp, 12
	
	jalr ra # Retorna ao chamador
	
soma_vetor_rec:
	# Salvando Registradores na Pilha - Push
	addi sp, sp, -16 # Armazena 4 registradores na pilha
	sw ra, 0(sp) # Armazena o registrador de retorno
	sw a0, 4(sp) # Armazena o registrador contendo o endereco base do vetor
	
	beqz a1, return_zero
	
	addi a1, a1, -1 # Decrementa posição (a1) em 1
	sw a1, 8(sp) # Armazena valor de a1 na pilha
	
	jal soma_vetor_rec # Chamada recursiva de soma_vetor_rec, ate que seja retornado 0
	
	# Depois de todas as chamadas recursivas, inicia-se os retornos com os calculos das posicoes
	sw a0, 12(sp)
	lw t0, 4(sp)
	lw t1, 8(sp)
	
	# Pega o elemento na posição atual do vetor
	slli t1, t1, 2 # Move 2 bits para a esquerda: 4*i
	add t0, t0, t1 # Calcula a posicao no vetor desde o seu comeco: comeco do vetor + (4 * i)
	lw t2, 0(t0) # Valor do vetor na posicao i
	
	lw t3, 12(sp) 
	add a0, t3, t2 # soma(vet, pos - 1) + vet[i]
	j return_soma_vetor_rec 
	
return_zero:
	add a0, zero, zero # Retorna 0
	jalr ra, 0 # Retorna ao chamador
	
return_soma_vetor_rec:
	add a0, a0, zero # Copia o valor de retorno da funcao atual para a0
	lw ra, 0(sp) # Carrega o registrador de retorno
	addi sp, sp, 16 # Remove o espaco na pilha usado pelos 4 registradores
	jalr ra, 0 # Retorna para o chamador
	
main:
	lw t0, min_tam
	lw t1, max_tam	
	
	jal ra, loop_define_tam_vetor # Chama a funcao para solicitar o tamanho do vetor
	add s0, zero, a0 # Input do usuario (registrador a0), é salvo no registrador s0 
	
	# Imprime: String texto_resultado
	addi a7, zero, 4 # Adiciona o valor 4 ao registrador de serviço a7 (PrintString)
	la a0, texto_resultado # Carrega o texto texto_resultado ao registrador a0
	ecall # Chama o syscall
	
	# Argumentos:
	# a0 - Registrador de endereço base do vetor
	# a1 - Registrador do tamanho do vetor (numero de posições)
	la a0, vetor # Carrega o endereco de memoria do vetor em a0
	add a1, zero, s0 # Define o tamanho do vetor e a posição
	jal ra, inicializar_vetor
	
	# Argumentos: 
	# a0 - Registrador de endereço base do vetor
	# a1 - Registrador do tamanho do vetor (numero de posições)
	jal ra, soma_vetor_rec
	
	# Imprime: Int resultado da soma
	addi a7, zero, 1 # Adiciona o valor 1 (PrintInt) ao registrador de serviço a7
	ecall # Chama a syscall
	
	# Return 0
	addi a7, zero, 10 # Adiciona o valor 10 (Exit(0)) ao registrador de serviço a7
	ecall # Chama a syscall
	
