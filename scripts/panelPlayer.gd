extends VBoxContainer
class_name PanelPlayer

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
