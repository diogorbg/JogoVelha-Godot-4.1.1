extends VBoxContainer
class_name PanelPlayer

var iconHuman = preload("res://sprites/human.png")
var iconRobot = preload("res://sprites/robot.png")

@onready var seta = %seta as Sprite2D
@onready var txtVitorias = %txtVitorias as Label
@onready var anim2 = %anim2 as AnimationPlayer
@onready var butAvatar = %butAvatar as Button
@onready var butJogador = $butJogador as Button
@onready var timerIA = $timerIA as Timer

# Exibe uma enumeração na interface que permite escolher entre 'Jogador 1' e 'Jogador 2'
# No final teremos a variável id que recebe o valor 1 ou -1 (-1 irá nos ajudar a verificar o tabeleiro)
@export_enum("Jogador 1:1", "Jogador 2:-1") var id: int = 1
@export var usarIA: bool = false
@export_color_no_alpha var corBg: Color

var vitorias: int  = 0

func _ready():
	anim2.get_parent().visible = false
	butJogador.icon = iconRobot if usarIA else iconHuman
	butJogador.text = getNome()

# retorna a textura do jogador... a mesma que está no botão
func getImg(): return butAvatar.icon

# Retorna o nome do jogador
func getNome() -> String:
	if usarIA:
		return "IA 1" if id == 1 else "IA 2"
	else:
		return "Jogador 1" if id == 1 else "Jogador 2"

# Mostra qual jogador está ativo
func setSel(sel: bool):
	seta.visible = sel
	anim2.get_parent().visible = false
	if sel && !usarIA:
		JogoVelha.setBotesAtivo(true)
	elif sel && usarIA:
		JogoVelha.setBotesAtivo(false)
		# Se a IA estiver ativa, será executada após o timer
		timerIA.start()

# Mostra o trofeu e soma uma vitória
func showVitoria():
	anim2.get_parent().visible = true
	anim2.play("vitoria")
	vitorias += 1
	txtVitorias.text = "Vitórias: " + str(vitorias)

# Mostra a derrota
func showDerrota():
	anim2.get_parent().visible = true
	anim2.play("derrota")

# Permite jogar com IA simples
func ativarDesativarIA():
	usarIA = !usarIA
	butJogador.icon = iconRobot if usarIA else iconHuman
	butJogador.text = getNome()
