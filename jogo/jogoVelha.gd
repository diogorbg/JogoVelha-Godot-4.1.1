extends Control
class_name JogoVelha

@onready var panelPlayer1 = %panelPlayer1 as PanelPlayer
@onready var panelPlayer2 = %panelPlayer2 as PanelPlayer

@onready var but1 = $tabuleiro/HBox1/but1 as Botao
@onready var but2 = $tabuleiro/HBox1/but2 as Botao
@onready var but3 = $tabuleiro/HBox1/but3 as Botao
@onready var but4 = $tabuleiro/HBox2/but4 as Botao
@onready var but5 = $tabuleiro/HBox2/but5 as Botao
@onready var but6 = $tabuleiro/HBox2/but6 as Botao
@onready var but7 = $tabuleiro/HBox3/but7 as Botao
@onready var but8 = $tabuleiro/HBox3/but8 as Botao
@onready var but9 = $tabuleiro/HBox3/but9 as Botao
@onready var botoes = [[but1, but2, but3], [but4, but5, but6], [but7, but8, but9]]

static var isPlayer1: bool = false
static var _singleton: JogoVelha

static  func nextTurn():
	isPlayer1 = !isPlayer1
	_singleton.panelPlayer1.setSel(isPlayer1)
	_singleton.panelPlayer2.setSel(!isPlayer1)


# Called when the node enters the scene tree for the first time.
func _ready():
	_singleton = self


func novoJogo():
	for lin in botoes:
		for bot in lin:
			(bot as Botao).reset()
	isPlayer1 = false
	nextTurn()
