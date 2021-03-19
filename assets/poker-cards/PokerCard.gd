extends FocusTextureButton

class_name PokerCard

const CARD_BACK_PATH = "res://assets/poker-cards/card_back.png"
const CARDS_FOLDER = "res://assets/poker-cards/cards"

const CLUB = "clubs"
const DIAMOND = "diamonds"
const HEART = "hearts"
const SPADE = "spades"

export var value: String setget set_value
export var suit: String setget set_suit
export var show_back = true setget set_show_back

onready var turn_sound = $TurnSound

func _ready():
	update_card()


func set_value(v: String) -> void:
	if value != v:
		value = v
		update_card()
	

func set_suit(v: String) -> void:
	if suit != v:
		suit = v
		update_card()


func set_show_back(v: bool) -> void:
	if show_back != v:
		show_back = v
		if not show_back:
			turn_sound.play()
		update_card()


func update_card():
	if not is_visible_in_tree(): return

	var card_path = CARD_BACK_PATH if show_back else _create_card_path()
	texture_normal = load(card_path)


func _create_card_path() -> String:
	if suit == "" or value == "":
		return CARD_BACK_PATH
	return CARDS_FOLDER + "/card_" + suit + "_" + value + ".png"

func set_from_file_name(file_name: String):
	var card_name = file_name.split(".")[0] as String
	var values = card_name.split("_") as Array
	if values.size() == 3:
		suit = values[1]
		value = values[2]

# When exporting only .import files will be kept
static func valid_file(file_name: String):
	return file_name.begins_with("card_") and file_name.ends_with(".png.import") and file_name.count("_") == 2
