.data
	fout: .asciiz "testout.txt" #nome do arquivo de saída
	buffer: .asciiz "Exemplo de texto sendo escrito no arquivo"
.text 

	# 1. Abrir um arquivo não existente para escrita
	li $v0, 13       # abre um novo arquivo
	la $a0, fout     # carrega o nome do arquivo que vai ser aberto
	li $a1, 1        # aberto para escrita, 0: read 1: write
	li $a2, 0        # modo ignorado
	syscall          # abre o arquivo 
	move $s6, $v0    # salva o descritor do arquivo para uso 
	
	
	# 2. Escreve no arquivo aberto
	li $v0, 15       # comando pra escrever no arquivo
	move $a0, $s6    # descritor do arquivo é passado
	la $a1, buffer   # endereço do buffer do qual será copiado o arquivo
	li $a2, 44       # tamanho do buffer hardcodado
	syscall          # Escreve no arquivo
	
	
	# 3. Fecha o arquivo depois de escrever
	li $v0, 16       # fechar o arquivo
	move $a0, $s6    # descritor do arquivo é passado
	syscall          # arquivo é fechado pelo SO 
	