# Stores, saves and loads game Settings in an ini-style file
extends Node

const SAVE_PATH = "res://save.json"
var _settings = {}


func _ready():
	load_game()


func save_game():
	# Get all the save data from persistent nodes
	# Create a file
	# Serialize the data dictionary to JSON
	# Write the JSON to the file and save to disk
	pass

func load_game():
	# Try to load a saved file
	# Parse the file data if it exists
	# load the data into persistent nodes
	pass