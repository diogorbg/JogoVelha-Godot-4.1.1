extends VBoxContainer
class_name PanelPlayer

@onready var seta = %seta as Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func setSel(sel: bool):
	seta.visible = sel
