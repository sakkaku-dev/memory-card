extends Control

signal cards_matched

const POKER_CARD_SCENE = preload("res://assets/poker-cards/PokerCard.tscn")

export var match_count = 4

onready var grid := $GridContainer
onready var revealed_timer := $RevealedTimer

var revealed_cards = []

func _ready():
	var cards = create_card_scenes()
	cards.shuffle()
	for card in cards:
		grid.add_child(card)


func create_card_scenes() -> Array:
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
	if _max_revealed_cards():
		return
	
	card.show_back = false
	revealed_cards.append(card)
	
	if _max_revealed_cards():
		revealed_timer.start()


func _max_revealed_cards() -> bool:
	return revealed_cards.size() >= match_count


func _revealed_cards_matching() -> bool:
	var value = revealed_cards.front().value
	
	var card_match = 0
	for card in revealed_cards:
		if card.value == value:
			card_match += 1
	
	return card_match == match_count


func _on_RevealedTimer_timeout():
	if _revealed_cards_matching():
		emit_signal("cards_matched")
	else:
		for c in revealed_cards:
			c.show_back = true
	revealed_cards = []
