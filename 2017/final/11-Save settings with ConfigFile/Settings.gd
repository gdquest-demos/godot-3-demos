# Stores, saves, and loads game settings in an ini-style file
# Feel free to use this file format instead of JSON in example 12-Save
# The advantage of this format is it can save and load builtin data types for you
# Like Vector2, Color...

# This script is registered as an AutoLoad singleton in the Project settings. It will load before every over node in the scene
extends Node


# Constants, codes to check and see if loading was successful or not
enum {LOAD_SUCCESS, LOAD_ERROR_COULDNT_OPEN}

const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
# All the data to save is stored in a dictionary. In the final file, it will look like
# [audio]
# mute=false
# [debug]
# vector_color=Color(1.0, 0.0, 1.0)
# area_color=Color(0.0, 0.0, 0.2, 0.5)
var _settings = {
	"audio": {
		"mute": Globals.get("Settings/mute")
	},
	"debug": {
		"vector_color": Color(1.0, 0.0, 1.0),
		"area_color": Color(0.0, 1.0, 0.4, 0.5)
	}
}



func _ready():
	save_settings()
	load_settings()


# The configFile has sections, and key-value pairs. The first loop retrieves the section name in the _settings dictionary
# The second loop goes one level deeper inside the dictionary and gives you the key (key) value (_settings[section][key]) pairs,
# e.g. key will first be "mute" and _settings[section][key] false
func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			# The ConfigFile object (_config_file is a ConfigFile) has all the methods you need to load, save, set and read values
			_config_file.set_value(section, key, _settings[section][key])

	_config_file.save(SAVE_PATH)



func load_settings():
	# If the file doesn't open correctly (doesn't exist or used by another process),
	# We can't load any data so we return outside the function
	# NB: You could check if the file exist with the File object (see example 13-Save)
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Error loading the settings. Error code: %s" % error)
		return LOAD_ERROR_COULDNT_OPEN

	for section in _settings.keys():
		for key in _settings[section].keys():
			# We store the settings in the dictionary. In this demo, it's up to the other nodes to retrieve the settings,
			# with get_setting and set_setting below.
			# Example 13-Save offers a slightly better, object oriented solution to build upon this example 
			# (delegating save and load to the other nodes, the Save.gd script being only responsible to save and load on/from the disk)
			var val = _config_file.get_value(section,key)
			_settings[section][key] = val
			# Printing the values for debug purposes
			print("%s: %s" % [key, val])
	return LOAD_SUCCESS


func get_setting(category, key):
	return _settings[category][key]


func set_setting(category, key, value):
	_settings[category][key] = value