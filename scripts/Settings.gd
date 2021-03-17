extends Node

class_name Settings

const SETTINGS_PATH = "user://settings.cfg"

var _config_file = ConfigFile.new()
var settings = {
	"game": {
		"match_type": CardMatchSelect.Option.NUMBER
	}
}


func _ready():
	load_settings()


func save_settings():
	for section in settings.keys():
		for key in settings[section]:
			_config_file.set_value(section, key, settings[section][key])
	_config_file.save(SETTINGS_PATH)


func load_settings():
	var error = _config_file.load(SETTINGS_PATH)
	if error != OK:
		print("Failed to load settings. Error %s" % error)
		return
	
	for section in settings.keys():
		for key in settings[section]:
			settings[section][key] = _config_file.get_value(section, key, null)
