extends Node

onready var main_menu = $MenuLayer/MainMenu
onready var game = $MarginContainer/MemoryCardGrid
onready var game_ui = $UILayer/GameUI
onready var score_label = $UILayer/GameUI/Score

var score = 0
var card_match_opt = CardMatchSelect.Option.NUMBER

func _ready():
	main_menu.show()
	game.hide()
	game_ui.hide()
	update_score()


func start_game():
	main_menu.hide()
	game_ui.show()
	
	var matcher = _create_card_matcher()
	if matcher:
		game.start_game(matcher)
	else:
		print("Cannot create matcher with setting: " + card_match_opt)


func _create_card_matcher() -> CardMatcher:
	match(card_match_opt):
		CardMatchSelect.Option.NUMBER:
			return NumberCardMatcher.new()
		CardMatchSelect.Option.NUMBER_AND_COLOR:
			return NumberColorCardMatcher.new()
	return null


func exit_game():
	get_tree().quit()


func toggle_menu():
	if main_menu.visible:
		main_menu.hide()
	else:
		main_menu.show()


func update_score():
	score_label.text = "Score: " + str(score)


func _on_MemoryCardGrid_cards_matched():
	score += 10
	update_score()


func _on_CardMatchSelect_item_selected(index):
	card_match_opt = index
