extends VBoxContainer
class_name PanelPlayer

@onready var seta = %seta as Sprite2D
@onready var txtVitorias = %txtVitorias as Label
@onready var anim2 = %anim2 as AnimationPlayer

# Exibe uma enumeração na interface que permite escolher entre 'Jogador 1' e 'Jogador 2'
# No final teremos a variável id que recebe o valor 1 ou -1 (-1 irá nos ajudar a verificar o tabeleiro)
@export_enum("Jogador 1:1", "Jogador 2:-1") var id: int = 1
@export_color_no_alpha var corBg: Color

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
