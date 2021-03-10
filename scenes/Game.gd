extends Node

onready var main_menu = $MenuLayer/MainMenu
onready var game = $MarginContainer/MemoryCardGrid
onready var game_ui = $UILayer/GameUI
onready var score_label = $UILayer/GameUI/Score

var score = 0

func _ready():
	main_menu.show()
	game.hide()
	game_ui.hide()
	update_score()

func start_game():
	main_menu.hide()
	game_ui.show()
	game.show()
	game.fill_board()
	

func exit_game():
	get_tree().quit()


func update_score():
	score_label.text = "Score: " + str(score)


func _on_MemoryCardGrid_cards_matched():
	score += 10
	update_score()
