extends Button
class_name Botao

const grupo = "botoes"

@onready var anim = %anim as AnimationPlayer
@onready var anim2 = %anim2 as AnimationPlayer
@onready var img = %img as TextureRect

# guarda o id do jogador 1: jogador1, -1: jogador2, 0: espaço vazio
var id: int = 0

func _ready():
	add_to_group(grupo)

# Sinal do clique do botão
func _on_pressed():
	disabled = true # não poderá mais ser clicado
	anim.play("click")
	self_modulate = Color(JogoVelha.jogador.tema.corBg, 0.5)
	img.texture = JogoVelha.jogador.tema.img
	id = JogoVelha.jogador.id
	JogoVelha.proximoTurno()

# Restaura valores iniciais para criar nova partida
func reset():
	id = 0
	disabled = false
	anim.play("start")
	anim2.play("RESET")
	self_modulate = Color.WHITE

# Botões que não foram utilizados são ativados/desativados
func setAtivo(ativo: bool):
	if id == 0:
		disabled = !ativo
		self_modulate = Color(Color.WHITE, 1.0 if ativo else 0.1)

# Marca o botão como peças vencedoras
func marcar(delta:float):
	self_modulate = JogoVelha.jogador.tema.corBg
	anim2.play("win")
	anim2.advance(delta)

# Esta funcao static fornece uma boa prática para chamar call_group(), mas cria acoplamento
# Permite trocar o tema de todos os botões sem depender do JogoVelha._singleton
# Mas pode não ter efeito se chamada antes que os botões existam
static func setTemaAll(tree: SceneTree, player: PanelPlayer):
	tree.call_group(grupo, "_setTema", player)

# muda o tema do botão, caso: player.id == id
func _setTema(player: PanelPlayer):
	# Verifica se possui o mesmo id, para então trocar o tema
	if player.id != id: return
	
	if self_modulate.a < 0.55:
		self_modulate = Color(player.tema.corBg, 0.5)
	else:
		self_modulate = player.tema.corBg
	img.texture = player.tema.img

# conectar este sinal caso o clique não esteja funcionando no mobile
#func _on_gui_input(event: InputEvent) -> void:
#	elif event is InputEventScreenTouch:
#		if event.pressed: _on_pressed()
