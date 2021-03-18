extends Control

signal cards_matched
signal game_finished

const POKER_CARD_SCENE = preload("res://assets/poker-cards/PokerCard.tscn")

onready var grid := $GridContainer
onready var revealed_timer := $RevealedTimer
onready var match_sound = $MatchSound

var revealed_cards = []
var card_matcher: CardMatcher

func start_game(matcher: CardMatcher):
	for child in grid.get_children():
		grid.remove_child(child)
		

	show()
	card_matcher = matcher

	var cards = _create_card_scenes()
	cards.shuffle()
	
	var first = null
	for card in cards:
		grid.add_child(card)
		if first == null:
			first = card
	
	if first != null:
		first.grab_focus()


func _create_card_scenes() -> Array:
	var dir = Directory.new()
	var result = []
	
	if dir.open(PokerCard.CARDS_FOLDER) == OK:
		dir.list_dir_begin(true, true)
		
		var file_name = dir.get_next()
		while file_name != "":
			if PokerCard.valid_file(file_name):
				var card_scene = POKER_CARD_SCENE.instance()
				card_scene.set_from_file_name(file_name)
				if card_scene.value != null && card_scene.suit != null:
					card_scene.connect("pressed", self, "_on_card_click", [card_scene])
					result.append(card_scene)
			file_name = dir.get_next()
		
		dir.list_dir_end()
	else:
		print("Failed to open cards folder")
	
	return result


func _on_card_click(card: PokerCard):
	if _max_revealed_cards() or not card.show_back:
		return
	
	card.show_back = false
	revealed_cards.append(card)
	
	if _max_revealed_cards():
		revealed_timer.start()


func _max_revealed_cards() -> bool:
	return card_matcher.is_max_revealed_cards(revealed_cards)


func _all_cards_revealed() -> bool:
	for card in grid.get_children():
		if card.show_back:
			return false
	return true


func _on_RevealedTimer_timeout():
	if card_matcher.match_cards(revealed_cards):
		match_sound.play()
		emit_signal("cards_matched")
	else:
		for c in revealed_cards:
			c.show_back = true
	revealed_cards = []
	
	if _all_cards_revealed():
		emit_signal("game_finished")
