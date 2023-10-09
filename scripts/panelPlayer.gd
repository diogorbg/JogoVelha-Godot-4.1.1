extends VBoxContainer
class_name PanelPlayer

# Todas as possibilidades temáticas dos jogadores
const _temas = [
	preload("res://temas/tema1.tres"),
	preload("res://temas/tema2.tres"),
	preload("res://temas/tema3.tres"),
	preload("res://temas/tema4.tres"),
	preload("res://temas/tema5.tres"),
	preload("res://temas/tema6.tres")
];

var iconHuman = preload("res://sprites/human.png")
var iconRobot = preload("res://sprites/robot.png")

@onready var seta = %seta as Sprite2D
@onready var txtVitorias = %txtVitorias as Label
@onready var anim2 = %anim2 as AnimationPlayer
@onready var butAvatar = %butAvatar as Button
@onready var imgBad = %imgBad as Sprite2D
@onready var butJogador = $butJogador as Button
@onready var timerIA = $timerIA as Timer

# Exibe uma enumeração na interface que permite escolher entre 'Jogador 1' e 'Jogador 2'
# No final teremos a variável id que recebe o valor 1 ou -1 (-1 irá nos ajudar a verificar o tabeleiro)
@export_enum("Jogador 1:1", "Jogador 2:-1") var id: int = 1
@export var idTema: int = 0
@export var usarIA: bool = false

var vitorias: int  = 0
var tema = null
var oponente: PanelPlayer = null

func _ready():
	setTema()
	anim2.get_parent().visible = false
	butJogador.icon = iconRobot if usarIA else iconHuman
	butJogador.text = getNome()

# Volta um tema, mas evita que seja igual ao oponente
func voltarTema():
	idTema = (idTema + 6 - 1) % 6
	if oponente.idTema == idTema: voltarTema()
	else: setTema()

# Avança para o próximo tema, mas evita que seja igual ao oponente
func proxTema():
	idTema = (idTema + 1) % 6
	if oponente.idTema == idTema: proxTema()
	else: setTema()

# Aplica as cores e texturas para todas as partes customizáveis
func setTema():
	tema = _temas[idTema]
	seta.self_modulate = tema.cor
	butAvatar.icon = tema.img
	imgBad.self_modulate = tema.cor
	Botao.setTemaAll(get_tree(), self)

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


func _on_butAvatar_guiInput(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_RIGHT:
			voltarTema()

# Permite jogar com IA simples
func ativarDesativarIA():
	usarIA = !usarIA
	butJogador.icon = iconRobot if usarIA else iconHuman
	butJogador.text = getNome()

