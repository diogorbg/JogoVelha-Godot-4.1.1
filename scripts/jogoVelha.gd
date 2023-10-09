extends Control
class_name JogoVelha

@onready var panelPlayer1 = %panelPlayer1 as PanelPlayer
@onready var panelPlayer2 = %panelPlayer2 as PanelPlayer

# Todos os botões organizados em forma de lista
@onready var lista: Array[Botao] = [
	$tabuleiro/HBox1/but1,
	$tabuleiro/HBox1/but2,
	$tabuleiro/HBox1/but3,
	$tabuleiro/HBox2/but4,
	$tabuleiro/HBox2/but5,
	$tabuleiro/HBox2/but6,
	$tabuleiro/HBox3/but7,
	$tabuleiro/HBox3/but8,
	$tabuleiro/HBox3/but9,
]
# Todos os botões organizados em forma de tabela
@onready var botoes = [
	[lista[0], lista[1], lista[2]],
	[lista[3], lista[4], lista[5]],
	[lista[6], lista[7], lista[8]],
]

# Este é o jogador atual: turno atual
static var jogador: PanelPlayer = null
# Este é o jogador oponente: próximo turno
static var oponente: PanelPlayer = null

# Singleton é uma técnica muito útil para criar objetos gerenciadores
# É uma forma de acessar a instancia do JogoVelha de uma função static
static var _singleton: JogoVelha = null

func _ready():
	_singleton = self
	novoJogo()

# Restaura todos os valores para iniciar uma nova partida
func novoJogo():
	for bot in lista:
		bot.reset()
	_proximoTurno()

# Remove a seleção de jogador e desativa todos os botões não utilizados
func finalizar():
	panelPlayer1.setSel(false)
	panelPlayer2.setSel(false)
	for bot in lista:
		bot.finalizar()

# Uma função static permite ser chamada diretamente por outro script: JogoVelha.proximoTurno()
static func proximoTurno(): _singleton._proximoTurno()

# Chama o próximo turno
# Verificações de vitória são feitas neste momento
func _proximoTurno():
	if verificaVencedor():
		finalizar()
		jogador.showVitoria()
		print(jogador.getNome() + " venceu")
	elif verificarEmpate():
		finalizar()
		panelPlayer1.showDerrota()
		panelPlayer2.showDerrota()
		print("Jogo empatado")
	else:
		if jogador == panelPlayer1:
			jogador = panelPlayer2
			oponente = panelPlayer1
		else:
			jogador = panelPlayer1
			oponente = panelPlayer2
		jogador.setSel(true)
		oponente.setSel(false)

# Retorna a matriz de botões para outro script
static  func getBotoes(): return _singleton.botoes;

# Facilita retornar um botão localizado dentro de um Array[Array[Botao]]
func getBotao(lin: int, col: int) -> Botao:
	return (botoes[lin] as Array[Botao])[col]

# Compara 3 botões e os marca, caso detecte vitória
func compare(b1: Botao, b2: Botao, b3: Botao) -> bool:
	if b1.id == b2.id && b2.id == b3.id && b3.id != 0:
		b1.marcar(0.3)
		b2.marcar(0.2)
		b3.marcar(0.1)
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
	for bot in lista:
		if bot.id == 0:
			return false
	return true
