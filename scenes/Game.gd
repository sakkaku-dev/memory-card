extends Node

onready var main_menu = $MenuLayer/MainMenu
onready var game = $MarginContainer/MemoryCardGrid
onready var game_ui = $UILayer/GameUI
onready var score_label = $UILayer/GameUI/Score
onready var settings = $Settings
onready var card_match_select = $MenuLayer/MainMenu/CenterContainer/SettingsMenu/CardMatchSelect
onready var settings_menu = $MenuLayer/MainMenu/CenterContainer/SettingsMenu
onready var game_over = $MenuLayer/GameOver

var score = 0

func _ready():
	show_main_menu()

func show_main_menu():
	main_menu.show()
	game.hide()
	game_ui.hide()
	game_over.hide()
	score = 0
	update_score()


func start_game():
	main_menu.hide()
	game_ui.show()
	
	var matcher = _create_card_matcher()
	if matcher:
		game.start_game(matcher)
	else:
		print("Cannot create matcher with setting: " + _get_match_type())


func _create_card_matcher() -> CardMatcher:
	match(_get_match_type()):
		CardMatchSelect.Option.NUMBER:
			return NumberCardMatcher.new()
		CardMatchSelect.Option.NUMBER_AND_COLOR:
			return NumberColorCardMatcher.new()
	return null


func _get_match_type():
	return settings.settings["game"]["match_type"]


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


func _on_SettingsMenu_visibility_changed():
	if not settings_menu: return
	
	if settings_menu.visible:
		card_match_select.selected = _get_match_type()
	else:
		settings.settings["game"]["match_type"] = card_match_select.selected
		settings.save_settings()


func _on_MemoryCardGrid_game_finished():
	game.hide()
	game_over.show()
	game_over.grab_focus()


func _on_GameOver_back_to_menu():
	show_main_menu()
