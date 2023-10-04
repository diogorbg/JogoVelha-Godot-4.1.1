extends Button
class_name Botao

const img1 = preload("res://sprites/1.png")
const img2 = preload("res://sprites/4.png")

@onready var anim = %anim as AnimationPlayer
@onready var img = %img as TextureRect

@export var cor1: Color
@export var cor2: Color

var peca = " "

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_pressed():
	disabled = true # não poderá mais ser clicado
	anim.play("click")
	self_modulate = cor1 if JogoVelha.isPlayer1 else cor2
	img.texture = img1 if JogoVelha.isPlayer1 else img2
	JogoVelha.nextTurn()


func reset():
	peca = " "
	disabled = false
	anim.play("start")
	self_modulate = Color.WHITE


# conectar este sinal caso o clique não esteja funcionando no mobile
#func _on_gui_input(event: InputEvent) -> void:
#	elif event is InputEventScreenTouch:
#		if event.pressed: _on_pressed()
