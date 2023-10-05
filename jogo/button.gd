extends Button
class_name Botao

const img1 = preload("res://sprites/1.png")
const img2 = preload("res://sprites/4.png")

@onready var anim = %anim as AnimationPlayer
@onready var anim2 = %anim2 as AnimationPlayer
@onready var img = %img as TextureRect

@export var cor1: Color
@export var winCor1: Color
@export var cor2: Color
@export var winCor2: Color

var peca: String = " "

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_pressed():
	disabled = true # não poderá mais ser clicado
	anim.play("click")
	self_modulate = cor1 if JogoVelha.isPlayer1 else cor2
	img.texture = img1 if JogoVelha.isPlayer1 else img2
	peca = "X" if JogoVelha.isPlayer1 else "O"
	JogoVelha.nextTurn()


func reset():
	peca = " "
	flat = false
	disabled = false
	anim.play("start")
	anim2.play("RESET")
	self_modulate = Color.WHITE


func finalizar():
	if peca == " ":
		disabled = true
		flat = true


func marcar():
	self_modulate = winCor1 if JogoVelha.isPlayer1 else winCor2
	anim2.play("win")


# conectar este sinal caso o clique não esteja funcionando no mobile
#func _on_gui_input(event: InputEvent) -> void:
#	elif event is InputEventScreenTouch:
#		if event.pressed: _on_pressed()
