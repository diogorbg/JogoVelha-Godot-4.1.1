extends VBoxContainer
class_name PanelPlayer

# Todas as possibilidades temáticas dos jogadores
const temasJogador = [{
	cor = Color(0.277344, 0.542969, 0.746094, 1),
	corBg = Color(0, 0.453333, 0.8, 1),
	img = preload("res://sprites/1.png")
}, {
	cor = Color(0.480469, 0.277344, 0.746094, 1),
	corBg = Color(0.346667, 0, 0.8, 1),
	img = preload("res://sprites/2.png")
}, {
	cor = Color(0.746094, 0.277344, 0.542969, 1),
	corBg = Color(0.8, 0, 0.453333, 1),
	img = preload("res://sprites/3.png")
}, {
	cor = Color(0.746094, 0.480469, 0.277344, 1),
	corBg = Color(0.8, 0.346667, 0, 1),
	img = preload("res://sprites/4.png")
}, {
	cor = Color(0.542969, 0.746094, 0.277344, 1),
	corBg = Color(0.453333, 0.8, 0, 1),
	img = preload("res://sprites/5.png")
}, {
	cor = Color(0.277344, 0.746094, 0.480469, 1),
	corBg = Color(0, 0.8, 0.346667, 1),
	img = preload("res://sprites/6.png")
}]

@onready var seta = %seta as Sprite2D
@onready var txtVitorias = %txtVitorias as Label
@onready var anim2 = %anim2 as AnimationPlayer

var vitorias: int  = 0

func _ready():
	anim2.get_parent().visible = false

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
