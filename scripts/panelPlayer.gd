extends VBoxContainer
class_name PanelPlayer

@onready var seta = %seta as Sprite2D
@onready var trofeu = %trofeu as Control
@onready var txtVitorias = %txtVitorias as Label

var vitorias: int  = 0

func _ready():
	trofeu.visible = false

# Mostra qual jogador está ativo
func setSel(sel: bool):
	seta.visible = sel
	trofeu.visible = false

# Mostra o trofeu e soma uma vitória
func showTrofeu():
	trofeu.visible = true
	vitorias += 1
	txtVitorias.text = "Vitórias: " + str(vitorias)
