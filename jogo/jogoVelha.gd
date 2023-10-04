extends Control
class_name JogoVelha

@onready var panelPlayer1 = %panelPlayer1 as PanelPlayer
@onready var panelPlayer2 = %panelPlayer2 as PanelPlayer

static var isPlayer1: bool = false
static var _singleton: JogoVelha

static  func nextTurn():
	isPlayer1 = !isPlayer1
	_singleton.panelPlayer1.setSel(isPlayer1)
	_singleton.panelPlayer2.setSel(!isPlayer1)


# Called when the node enters the scene tree for the first time.
func _ready():
	_singleton = self
	nextTurn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
