extends VBoxContainer
class_name PanelPlayer

# Todas as possibilidades temáticas dos jogadores
const _temas: Array[Tema]  = [
	preload("res://temas/tema1.tres"),
	preload("res://temas/tema2.tres"),
	preload("res://temas/tema3.tres"),
	preload("res://temas/tema4.tres"),
	preload("res://temas/tema5.tres"),
	preload("res://temas/tema6.tres")
];

@onready var seta = %seta as Sprite2D
@onready var txtVitorias = %txtVitorias as Label
@onready var anim2 = %anim2 as AnimationPlayer
@onready var butAvatar = %butAvatar as Button
@onready var imgBad = %imgBad as Sprite2D

@export var idTema: int = 0

var vitorias: int  = 0
var tema: Tema = null
var oponente: PanelPlayer = null

func _ready():
	setTema()
	anim2.get_parent().visible = false

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
	JogoVelha.setTema(self)

# Mostra qual jogador está ativo
func setSel(sel: bool):
	seta.visible = sel
	anim2.get_parent().visible = false

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
