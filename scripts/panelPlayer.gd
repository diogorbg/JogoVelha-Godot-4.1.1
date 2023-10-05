extends VBoxContainer
class_name PanelPlayer

@onready var seta = %seta as Sprite2D
@onready var trofeu = %trofeu as Control
@onready var txtVitorias = %txtVitorias as Label

var vitorias: int  = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	trofeu.visible = false


func setSel(sel: bool):
	seta.visible = sel
	trofeu.visible = false


func showTrofeu():
	trofeu.visible = true
	vitorias += 1
	txtVitorias.text = "Vitórias: " + str(vitorias)
