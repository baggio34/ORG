.data
    prompt:    .asciiz "Digite a força em kN: "
    resultado: .asciiz "\nResultado final em kN (módulo da força, analisar sentido para valor exato): "

    f1: .word 0
    f2: .word 0
    f3: .word 0
    R1: .word 0

.text

  	# f1
 	li $v0, 4           # serviço de sistema 4 (imprimir string)
   	la $a0, prompt      # coloca o endereço do prompt em a0
  	syscall	        # executa a chamada de sistema

        li $v0, 5		# serviço de sistema 5 (ler inteiro)
	syscall		# executa a leitura
	sw $v0, f1		# salva o valor digitado em f1
    
        ## ====== o processo se repetirá para f2 e f3, não comentarei por ser desnecessário ====== ##

        # f2
	li $v0, 4
	la $a0, prompt
	syscall

        li $v0, 5
        syscall
        sw $v0, f2

        # f3
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall
        sw $v0, f3

        # calculando
        # salva em registradores temporários os valores de f1, f2 e f3
        lw $t0, f1
        lw $t1, f2
        lw $t2, f3

        add $t3, $t0, $t1 # t3 <- f1 + f2
        add $t4, $t3, $t2 # t4 <- t3(f1 + f2) + f3

        sw $t4, R1 # salva o valor de t4, que é o valor final da soma, na variável R1

        # mensagem
        li $v0, 4
        la $a0, resultado
        syscall

        # print do resultado
        lw $a0, R1
        li $v0, 1	# serviço 1: imprime inteiro
        syscall

        # ===== fim =====
        li $v0, 10
        syscall
