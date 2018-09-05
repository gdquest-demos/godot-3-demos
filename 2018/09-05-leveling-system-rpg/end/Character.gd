extends Node

signal experience_gained(growth_data)

# CHARACTER STATS
export (int) var max_hp = 12
export (int) var strength = 8
export (int) var magic = 8

# LEVELING SYSTEM
export (int) var level = 1

var experience = 0
var experience_total = 0
var experience_required = get_required_experience(level + 1)

func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4)

func gain_experience(value):
	experience_total += value
	var experience_remaining = value
	var growth_data = []
	while experience_remaining >= experience_required - experience:
		experience_remaining -= experience_required - experience
		growth_data.append([experience_required, experience_required])
		level_up()
	experience += experience_remaining
	growth_data.append([experience, get_required_experience(level + 1)])
	emit_signal("experience_gained", growth_data)

func level_up():
	level += 1
	experience = 0
	experience_required = get_required_experience(level + 1)

	var stats = ['max_hp', 'strength', 'magic']
	var random_stat = stats[randi() % (stats.size() - 1)]
	set(random_stat, get(random_stat) + randi() % 4)
