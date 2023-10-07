extends Node

@onready var player = $".." as PanelPlayer

# Estes botões virão do JogoVelha
var botoes = null

# Este sinal é chamado após o timer de 1s
func _on_timeout():
	# verifica se a IA ainda está ativa e se ainda é seu turno
	if player.usarIA && JogoVelha.jogador == player:
		_jogarComIA()

# Facilita retornar um botão localizado dentro de um Array[Array[Botao]]
func getBotao(lin: int, col: int) -> Botao:
	return (botoes[lin] as Array[Botao])[col]

# Uma IA simples que faz alguns movimentos de ataque e defesa, mas no geral é aleatória
func _jogarComIA():
	botoes = JogoVelha.getBotoes()
	
	# 1. Verifica se existe uma jogada vitoriosa, onde se vence o jogo.
	# Por exemplo: [1, 1, 0] soma 2... e se pode vencer nesta linha
	# Mas no exemplo: [1, -1, 0] soma 0... e não se pode vencer
	if _IAverificaSomas(JogoVelha.jogador.id * 2):
		return
		
	# 2. Verifica se existe uma jogada de defesa, onde se impede o oponente.
	# Por exemplo: [-1, -1, 0] soma -2... e se deve defender
	# Mas no exemplo: [1, -1, 0] soma 0... e não faz diferença jogar aqui
	if _IAverificaSomas(-JogoVelha.jogador.id * 2):
		return
	
	# 3. Não restando opção a IA é forçada a criar uma jogada, mas esta é uma IA
	# simples e não é capaz disso. Nós vamos apenas fazer uma jogada aleatória.
	# Então vamos gerar um vetor das posições vazias e escolher uma:
	var vazios: Array = []
	for lin in botoes:
		for bot in lin:
			if (bot as Botao).id == 0:
				vazios.append(bot)
	var pos = randi_range(0, vazios.size() - 1)
	vazios[pos]._on_pressed()

# Verifiar a soma pode ser útil para saber onde se pode jogar ou defender
func _IAverificaSomas(soma: int):
	# Verifica a soma nas linhas
	for i in range(3):
		if _IAsomaBotoesEJoga(getBotao(i,0), getBotao(i,1), getBotao(i,2), soma):
			return true
	# Verifica a soma nas colunas
	for i in range(3):
		if _IAsomaBotoesEJoga(getBotao(0,i), getBotao(1,i), getBotao(2,i), soma):
			return true
	# Verifica a soma na diagonal principal
	if _IAsomaBotoesEJoga(getBotao(0,0), getBotao(1,1), getBotao(2,2), soma):
		return true
	# Verifica a soma na diagonal secundária
	if _IAsomaBotoesEJoga(getBotao(0,2), getBotao(1,1), getBotao(2,0), soma):
		return true
	return false

# Soma o id de 3 botões
func _IAsomaBotoesEJoga(b1: Botao, b2: Botao, b3: Botao, soma: int) -> bool:
	if b1.id + b2.id + b3.id == soma:
		_IAjogaPosicaoLivre(b1, b2, b3)
		return true
	return false

# IA joga na posição livre de um dos botões. É obrigatória que uma posição seja livre
func _IAjogaPosicaoLivre(b1: Botao, b2: Botao, b3: Botao):
	if b1.id == 0:
		b1._on_pressed()
	elif b2.id == 0:
		b2._on_pressed()
	else:
		b3._on_pressed()
