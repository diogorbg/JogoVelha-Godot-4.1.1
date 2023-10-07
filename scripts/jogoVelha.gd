extends Control
class_name JogoVelha

@onready var panelPlayer1 = %panelPlayer1 as PanelPlayer
@onready var panelPlayer2 = %panelPlayer2 as PanelPlayer

@onready var but1 = $tabuleiro/HBox1/but1 as Botao
@onready var but2 = $tabuleiro/HBox1/but2 as Botao
@onready var but3 = $tabuleiro/HBox1/but3 as Botao
@onready var but4 = $tabuleiro/HBox2/but4 as Botao
@onready var but5 = $tabuleiro/HBox2/but5 as Botao
@onready var but6 = $tabuleiro/HBox2/but6 as Botao
@onready var but7 = $tabuleiro/HBox3/but7 as Botao
@onready var but8 = $tabuleiro/HBox3/but8 as Botao
@onready var but9 = $tabuleiro/HBox3/but9 as Botao
@onready var botoes = [[but1, but2, but3], [but4, but5, but6], [but7, but8, but9]]

# Este é o jogador atual: turno atual
static var jogador: PanelPlayer = null
# Este é o jogador oponente: próximo turno
static var oponente: PanelPlayer = null

# singleton é uma técnica muito útil para criar objetos gerenciadores
static var _singleton: JogoVelha = null

func _ready():
	_singleton = self
	panelPlayer1.oponente = panelPlayer2
	panelPlayer2.oponente = panelPlayer1
	novoJogo()

# Restaura todos os valores para iniciar uma nova partida
func novoJogo():
	for lin in botoes:
		for bot in lin:
			(bot as Botao).reset()
	JogoVelha.nextTurn()

static func setTema(player: PanelPlayer):
	var peca = "X" if player.id == 1 else "O"
	for lin in _singleton.botoes:
		for bot in lin:
			if (bot as Botao).peca == peca:
				(bot as Botao).setTema(player.tema)

# Sempre retorna o PanelPlayer do jogador atual
static func getPanelPlayer() -> PanelPlayer:
	return _singleton.panelPlayer1 if isPlayer1 else _singleton.panelPlayer2

# Remove a seleção de jogador e desativa todos os botões não utilizados
func finalizar():
	panelPlayer1.setSel(false)
	panelPlayer2.setSel(false)
	for lin in botoes:
		for bot in lin:
			(bot as Botao).finalizar()

# Chama o próximo turno
# Verificações de vitória são feitas neste momento
static func nextTurn():
	if _singleton.verificaVencedor():
		_singleton.finalizar()
		jogador.showVitoria()
		print(jogador.getNome() + " venceu")
	elif _singleton.verificarEmpate():
		_singleton.finalizar()
		_singleton.panelPlayer1.showDerrota()
		_singleton.panelPlayer2.showDerrota()
		print("Jogo empatado")
	else:
		if jogador == _singleton.panelPlayer1:
			jogador = _singleton.panelPlayer2
			oponente = _singleton.panelPlayer1
		else:
			jogador = _singleton.panelPlayer1
			oponente = _singleton.panelPlayer2
		jogador.setSel(true)
		oponente.setSel(false)

# Facilita retornar um botão localizado dentro de um Array[Array[Botao]]
func getBotao(lin: int, col: int) -> Botao:
	return (botoes[lin] as Array[Botao])[col]

# Compara 3 botões e os marca, caso detecte vitória
func compare(b1: Botao, b2: Botao, b3: Botao) -> bool:
	if b1.id == b2.id && b2.id == b3.id && b3.id != 0:
		b1.marcar(.3)
		b2.marcar(.2)
		b3.marcar(.1)
		return true
	return false

# Função principal de verificação do vencedor
func verificaVencedor() -> bool:
	# Verifica se um jogador ganhou em uma linha
	for i in range(3):
		if compare(getBotao(i,0), getBotao(i,1), getBotao(i,2)):
			return true

	# Verifica se um jogador ganhou em uma coluna
	for i in range(3):
		if compare(getBotao(0,i), getBotao(1,i), getBotao(2,i)):
			return true

	# Verifica se um jogador ganhou na diagonal principal
	if compare(getBotao(0,0), getBotao(1,1), getBotao(2,2)):
		return true

	# Verifica se um jogador ganhou na diagonal secundária
	if compare(getBotao(0,2), getBotao(1,1), getBotao(2,0)):
		return true

	return false

# Se não encontrar um botão com id 0, então não existem mais jogadas
func verificarEmpate() -> bool:
	for lin in botoes:
		for bot in lin:
			if (bot as Botao).id == 0:
				return false
	return true
