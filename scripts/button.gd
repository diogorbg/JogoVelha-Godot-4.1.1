extends Button
class_name Botao

@onready var anim = %anim as AnimationPlayer
@onready var anim2 = %anim2 as AnimationPlayer
@onready var img = %img as TextureRect

# guarda o valor x: jogador1, o: jogador2, " ": espaço vazio
var peca: String = " "

# Sinal do clique do botão
func _on_pressed():
	disabled = true # não poderá mais ser clicado
	anim.play("click")
	self_modulate = Color(JogoVelha.getPanelPlayer().tema.corBg, 0.5)
	img.texture = JogoVelha.getPanelPlayer().tema.img
	peca = "X" if JogoVelha.isPlayer1 else "O"
	JogoVelha.nextTurn()

# Restaura valores iniciais para criar nova partida
func reset():
	peca = " "
	disabled = false
	anim.play("start")
	anim2.play("RESET")
	self_modulate = Color.WHITE

# Botões que não foram utilizados são desativados
func finalizar():
	if peca == " ":
		disabled = true
		self_modulate = Color(Color.WHITE, 0.1)

# Marca o botão como peças vencedoras
func marcar(delta:float):
	self_modulate = JogoVelha.getPanelPlayer().tema.corBg
	anim2.play("win")
	anim2.advance(delta)

# muda o tema do botão
func setTema(tema: Tema):
	if self_modulate.a < 0.55:
		self_modulate = Color(tema.corBg, 0.5)
	else:
		self_modulate = tema.corBg
	img.texture = tema.img

# conectar este sinal caso o clique não esteja funcionando no mobile
#func _on_gui_input(event: InputEvent) -> void:
#	elif event is InputEventScreenTouch:
#		if event.pressed: _on_pressed()
