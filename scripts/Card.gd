extends Area2D

var card_name: String = "Empty"
var card_face: Texture2D
var card_back: Texture2D
var click_enabled: bool = true

func _ready():
	card_face = preload("res://sprites/german/background-deutsch.png")
	card_back = preload("res://sprites/german/background-deutsch.png")
	$Sprite.texture = card_back

func _input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		on_click()

func on_click():
	if not click_enabled:
		return

	var parent = get_parent()
	if parent.last_try_was_pair:
		parent.last_try_was_pair = false
		parent._reset_card_name_strings_and_check_box()

	# Timer beim ersten Klick starten
	if not parent.timer_started:
		parent.timer_started = true
		print("Timer gestartet!")

	click_enabled = false
	$Sprite.texture = card_face

	if parent.get_node("CardOneName").text == "Karte 1":
		parent.get_node("CardOneName").text = card_name
		parent.card_one_checked_if_pairing = name
	elif parent.get_node("CardTwoName").text == "Karte 2":
		parent.get_node("CardTwoName").text = card_name
		parent.card_two_checked_if_pairing = name
		parent.attempts_count += 1
		parent._check_if_pair()
