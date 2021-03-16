extends OptionButton

class_name CardMatchSelect

enum Option {
	NUMBER
	NUMBER_AND_COLOR,
}

func _ready():
	for opt in Option.keys():
		add_item(opt, Option[opt])
