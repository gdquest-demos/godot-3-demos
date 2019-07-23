extends Panel


onready var timer: Timer = $Timer


onready var label_input_stylebox: StyleBoxFlat = $LabelInput.get("custom_styles/normal")
onready var panel_player_stylebox: StyleBoxFlat = $PanelPlayer.get("custom_styles/panel")
onready var label_attacked_stylebox: StyleBoxFlat = $PanelPlayer/LabelAttacked.get("custom_styles/normal")
onready var label_on_attacked_stylebox: StyleBoxFlat = $PanelDummy/LabelOnAttacked.get("custom_styles/normal")
onready var label_damaged_stylebox: StyleBoxFlat = $PanelDummy/LabelDamaged.get("custom_styles/normal")
onready var label_on_damaged_stylebox: StyleBoxFlat = $PanelPlayerUI/LabelOnDamaged.get("custom_styles/normal")
onready var line_attacked: Line2D = $PanelPlayer/Line2DAttacked
onready var line_on_attacked: Line2D = $PanelDummy/Line2DOnAttacked
onready var line_damaged: Line2D = $PanelDummy/Line2DDamaged
onready var line_on_damaged: Line2D = $PanelPlayerUI/Line2DOnDamaged
onready var line_input_player: Line2D = $Line2DInputPlayer
onready var line_player_dummy: Line2D = $Line2DPlayerDummy
onready var line_dummy_player_ui: Line2D = $Line2DDummyPlayerUI


func _ready() -> void:
	Events.connect("player_attacked", self, "_on_Player_attacked")
	Events.connect("dummy_damaged", self, "_on_Dummy_damaged")
	timer.connect("timeout", self, "_on_Timer_timeout")


func _unhandled_input(event: InputEvent) -> void:
	var key := "active" if event.is_action_pressed("ui_accept") else "0"
	label_input_stylebox.bg_color = U.COLORS[key]
	panel_player_stylebox.bg_color = U.COLORS[key]
	line_input_player.default_color = U.COLORS[key]


func _on_Player_attacked(damage: int) -> void:
	var key := "active"
	label_attacked_stylebox.bg_color = U.COLORS[key]
	label_on_attacked_stylebox.bg_color = U.COLORS[key]
	line_attacked.default_color = U.COLORS[key]
	line_on_attacked.default_color = U.COLORS[key]
	line_player_dummy.default_color = U.COLORS[key]
	timer.start()

func _on_Dummy_damaged(damage: int) -> void:
	var key := "active"
	label_damaged_stylebox.bg_color = U.COLORS[key]
	label_on_damaged_stylebox.bg_color = U.COLORS[key]
	line_damaged.default_color = U.COLORS[key]
	line_on_damaged.default_color = U.COLORS[key]
	line_dummy_player_ui.default_color = U.COLORS[key]
	timer.start()


func _on_Timer_timeout() -> void:
	var key := "1"
	label_attacked_stylebox.bg_color = U.COLORS[key]
	label_on_attacked_stylebox.bg_color = U.COLORS[key]
	line_attacked.default_color = U.COLORS[key]
	line_on_attacked.default_color = U.COLORS[key]
	label_damaged_stylebox.bg_color = U.COLORS[key]
	label_on_damaged_stylebox.bg_color = U.COLORS[key]
	line_damaged.default_color = U.COLORS[key]
	line_on_damaged.default_color = U.COLORS[key]
	key = "0"
	line_player_dummy.default_color = U.COLORS[key]
	line_dummy_player_ui.default_color = U.COLORS[key]