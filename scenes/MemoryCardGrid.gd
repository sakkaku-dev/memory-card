extends GridContainer

const POKER_CARD_SCENE = preload("res://assets/poker-cards/PokerCard.tscn")

func _ready():
	var cards = create_card_scenes()
	cards.shuffle()
	for card in cards:
		add_child(card)


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
	card.show_back = false
