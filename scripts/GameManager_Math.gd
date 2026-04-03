extends Node2D
#Soundplayer2D wird inintalisiert
@onready var match_sound_player = $MatchSoundPlayer
var card_face
var card_back
var init
var number_of_matches
var default_image

# Timer-Variablen
var game_timer: float = 0.0
var timer_started: bool = false
var attempts_count: int = 0

# Jetzt 24 Bild-Variablen für 24 einzigartige Bilder
var image1_a 
var image1_b 
var image2_a 
var image2_b 
var image3_a 
var image3_b 
var image4_a 
var image4_b 
var image5_a 
var image5_b 
var image6_a 
var image6_b 
var image7_a 
var image7_b 
var image8_a 
var image8_b 
var image9_a 
var image9_b 
var image10_a 
var image10_b 
var image11_a 
var image11_b 
var image12_a 
var image12_b 

# Die Namen für die Paare
var name_pair_1 = "Paar 1"
var name_pair_2 = "Paar 2"
var name_pair_3 = "Paar 3"
var name_pair_4 = "Paar 4"
var name_pair_5 = "Paar 5"
var name_pair_6 = "Paar 6"
var name_pair_7 = "Paar 7"
var name_pair_8 = "Paar 8"
var name_pair_9 = "Paar 9"
var name_pair_10 = "Paar 10"
var name_pair_11 = "Paar 11"
var name_pair_12 = "Paar 12"

var last_try_was_pair
var card_one_checked_if_pairing
var card_two_checked_if_pairing
var card_one_str
var card_two_str
var all_remaining_cards = []
var random_card
var card_number

func _ready():
	number_of_matches = 0
	card_one_str = "Karte 1"
	card_two_str = "Karte 2"
	last_try_was_pair = false
	default_image = preload("res://sprites/math/background-mathe.png") # die Kartenrückseite

	# Lade 24 einzigartige Bilder
	image1_a = preload("res://sprites/math/karte1.png") 
	image1_b = preload("res://sprites/math/karte1-1.png") 
	image2_a = preload("res://sprites/math/karte2.png")
	image2_b = preload("res://sprites/math/karte2-2.png")
	image3_a = preload("res://sprites/math/karte3.png")
	image3_b = preload("res://sprites/math/karte3-3.png")
	image4_a = preload("res://sprites/math/karte4.png")
	image4_b = preload("res://sprites/math/karte4-4.png")
	image5_a = preload("res://sprites/math/karte5.png")
	image5_b = preload("res://sprites/math/karte5-5.png")
	image6_a = preload("res://sprites/math/karte6.png")
	image6_b = preload("res://sprites/math/karte6-6.png")
	image7_a = preload("res://sprites/math/karte7.png")
	image7_b = preload("res://sprites/math/karte7-7.png")
	image8_a = preload("res://sprites/math/karte8.png")
	image8_b = preload("res://sprites/math/karte8-8.png")
	image9_a = preload("res://sprites/math/karte9.png")
	image9_b = preload("res://sprites/math/karte9-9.png")
	image10_a = preload("res://sprites/math/karte10.png")
	image10_b = preload("res://sprites/math/karte10-10.png")
	image11_a = preload("res://sprites/math/karte11.png")
	image11_b = preload("res://sprites/math/karte11-11.png")
	image12_a = preload("res://sprites/math/karte12.png")
	image12_b = preload("res://sprites/math/karte12-12.png")

	randomize()
	init = false

func _process(_delta):
	if !init:
		_shuffle_cards()
	
	# Timer aktualisieren wenn gestartet
	if timer_started:
		game_timer += _delta
		# Timer-Anzeige aktualisieren
		get_node("TimerLabel").text = "Zeit: " + str(int(game_timer)) + " Sekunden"
		# Versuchs-Anzeige aktualisieren  
		get_node("AttemptsLabel").text = "Versuche: " + str(attempts_count)

func _shuffle_cards():
	all_remaining_cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]

	# Generiere zufällige Positionen für die 12 Paare (24 Karten)
	var card_pos_pair_1_a = _get_random_card_position()
	var card_pos_pair_1_b = _get_random_card_position()
	
	var card_pos_pair_2_a = _get_random_card_position()
	var card_pos_pair_2_b = _get_random_card_position()

	var card_pos_pair_3_a = _get_random_card_position()
	var card_pos_pair_3_b = _get_random_card_position()

	var card_pos_pair_4_a = _get_random_card_position()
	var card_pos_pair_4_b = _get_random_card_position()
	
	var card_pos_pair_5_a = _get_random_card_position()
	var card_pos_pair_5_b = _get_random_card_position()
	
	var card_pos_pair_6_a = _get_random_card_position()
	var card_pos_pair_6_b = _get_random_card_position()
	
	var card_pos_pair_7_a = _get_random_card_position()
	var card_pos_pair_7_b = _get_random_card_position()
	
	var card_pos_pair_8_a = _get_random_card_position()
	var card_pos_pair_8_b = _get_random_card_position()
	
	var card_pos_pair_9_a = _get_random_card_position()
	var card_pos_pair_9_b = _get_random_card_position()
	
	var card_pos_pair_10_a = _get_random_card_position()
	var card_pos_pair_10_b = _get_random_card_position()
	
	var card_pos_pair_11_a = _get_random_card_position()
	var card_pos_pair_11_b = _get_random_card_position()
	
	var card_pos_pair_12_a = _get_random_card_position()
	var card_pos_pair_12_b = _get_random_card_position()


	get_node("Card" + str(card_pos_pair_1_a)).card_face = image1_a
	get_node("Card" + str(card_pos_pair_1_a)).card_name = name_pair_1
	get_node("Card" + str(card_pos_pair_1_b)).card_face = image1_b
	get_node("Card" + str(card_pos_pair_1_b)).card_name = name_pair_1
	
	get_node("Card" + str(card_pos_pair_2_a)).card_face = image2_a
	get_node("Card" + str(card_pos_pair_2_a)).card_name = name_pair_2
	get_node("Card" + str(card_pos_pair_2_b)).card_face = image2_b
	get_node("Card" + str(card_pos_pair_2_b)).card_name = name_pair_2
	
	get_node("Card" + str(card_pos_pair_3_a)).card_face = image3_a
	get_node("Card" + str(card_pos_pair_3_a)).card_name = name_pair_3
	get_node("Card" + str(card_pos_pair_3_b)).card_face = image3_b
	get_node("Card" + str(card_pos_pair_3_b)).card_name = name_pair_3
	
	get_node("Card" + str(card_pos_pair_4_a)).card_face = image4_a
	get_node("Card" + str(card_pos_pair_4_a)).card_name = name_pair_4
	get_node("Card" + str(card_pos_pair_4_b)).card_face = image4_b
	get_node("Card" + str(card_pos_pair_4_b)).card_name = name_pair_4
	
	get_node("Card" + str(card_pos_pair_5_a)).card_face = image5_a
	get_node("Card" + str(card_pos_pair_5_a)).card_name = name_pair_5
	get_node("Card" + str(card_pos_pair_5_b)).card_face = image5_b
	get_node("Card" + str(card_pos_pair_5_b)).card_name = name_pair_5
	
	get_node("Card" + str(card_pos_pair_6_a)).card_face = image6_a
	get_node("Card" + str(card_pos_pair_6_a)).card_name = name_pair_6
	get_node("Card" + str(card_pos_pair_6_b)).card_face = image6_b
	get_node("Card" + str(card_pos_pair_6_b)).card_name = name_pair_6
	
	get_node("Card" + str(card_pos_pair_7_a)).card_face = image7_a
	get_node("Card" + str(card_pos_pair_7_a)).card_name = name_pair_7
	get_node("Card" + str(card_pos_pair_7_b)).card_face = image7_b
	get_node("Card" + str(card_pos_pair_7_b)).card_name = name_pair_7
	
	get_node("Card" + str(card_pos_pair_8_a)).card_face = image8_a
	get_node("Card" + str(card_pos_pair_8_a)).card_name = name_pair_8
	get_node("Card" + str(card_pos_pair_8_b)).card_face = image8_b
	get_node("Card" + str(card_pos_pair_8_b)).card_name = name_pair_8
	
	get_node("Card" + str(card_pos_pair_9_a)).card_face = image9_a
	get_node("Card" + str(card_pos_pair_9_a)).card_name = name_pair_9
	get_node("Card" + str(card_pos_pair_9_b)).card_face = image9_b
	get_node("Card" + str(card_pos_pair_9_b)).card_name = name_pair_9
	
	get_node("Card" + str(card_pos_pair_10_a)).card_face = image10_a
	get_node("Card" + str(card_pos_pair_10_a)).card_name = name_pair_10
	get_node("Card" + str(card_pos_pair_10_b)).card_face = image10_b
	get_node("Card" + str(card_pos_pair_10_b)).card_name = name_pair_10
	
	get_node("Card" + str(card_pos_pair_11_a)).card_face = image11_a
	get_node("Card" + str(card_pos_pair_11_a)).card_name = name_pair_11
	get_node("Card" + str(card_pos_pair_11_b)).card_face = image11_b
	get_node("Card" + str(card_pos_pair_11_b)).card_name = name_pair_11
	
	get_node("Card" + str(card_pos_pair_12_a)).card_face = image12_a
	get_node("Card" + str(card_pos_pair_12_a)).card_name = name_pair_12
	get_node("Card" + str(card_pos_pair_12_b)).card_face = image12_b
	get_node("Card" + str(card_pos_pair_12_b)).card_name = name_pair_12
	
	init = true

# Hilfsfunktion, um eine zufällige, unbenutzte Kartenposition zu erhalten
func _get_random_card_position():
	random_card = randi() % all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	return card_number

func _check_if_pair():
	if get_node("CardOneName").text == get_node("CardTwoName").text:
		get_node("CheckBox").text = "="
		last_try_was_pair = true
		number_of_matches += 1
		get_node("NumberOfMatches").text = "Anzahl der Übereinstimmungen: " + str(number_of_matches)
		#Sound wird bei richtigen Paaren abgespielt
		match_sound_player.play()
		
		# Prüfen ob Spiel gewonnen (alle 12 Paare gefunden)
		if number_of_matches >= 12:
			timer_started = false
			print("Spiel gewonnen! Zeit: " + str(game_timer) + " Sekunden, Versuche: " + str(attempts_count))
	
	if get_node("CardOneName").text != "Karte 1" and get_node("CardTwoName").text != "Karte 2":
		if get_node("CardOneName").text != get_node("CardTwoName").text:
			_disable_all_cards_clicks()
			get_node("CheckBox").text = "!="
			var waiting_timer = Timer.new()
			waiting_timer.set_wait_time(2)
			waiting_timer.set_one_shot(true)
			self.add_child(waiting_timer)
			waiting_timer.start()
			await(waiting_timer.timeout)
			_reset_card_name_strings_and_check_box()
			_turn_around_cards()
			_enable_all_cards_clicks()
			
	if number_of_matches == 12:
			# Zeige Ergebnisse im Spiel an statt nur in Konsole
			get_node("GameOverLabel").text = "🎉Glückwunsch🎉\n 
			Geschafft in " + str(int(game_timer)) + " Sekunden\n
			mit " + str(attempts_count) + " Versuchen!"
			get_node("GameOverLabel").visible = true
			get_node("CongratePanel").visible = true
			_on_game_won()

func _on_game_won():
	# Alle Karten ausblenden
	for i in range(1, 25):
		var card_node = get_node("Card" + str(i))
		card_node.visible = false

func _reset_card_name_strings_and_check_box():
	get_node("CardOneName").text = card_one_str
	get_node("CardTwoName").text = card_two_str
	get_node("CheckBox").text = "?"

func _turn_around_cards():
	get_node(str(card_one_checked_if_pairing)).get_node("Sprite").texture = default_image
	get_node(str(card_two_checked_if_pairing)).get_node("Sprite").texture = default_image

func _disable_all_cards_clicks():
	get_node("Card1").click_enabled = false
	get_node("Card2").click_enabled = false
	get_node("Card3").click_enabled = false
	get_node("Card4").click_enabled = false
	get_node("Card5").click_enabled = false
	get_node("Card6").click_enabled = false
	get_node("Card7").click_enabled = false
	get_node("Card8").click_enabled = false
	get_node("Card9").click_enabled = false
	get_node("Card10").click_enabled = false
	get_node("Card11").click_enabled = false
	get_node("Card12").click_enabled = false
	get_node("Card13").click_enabled = false
	get_node("Card14").click_enabled = false
	get_node("Card15").click_enabled = false
	get_node("Card16").click_enabled = false
	get_node("Card17").click_enabled = false
	get_node("Card18").click_enabled = false
	get_node("Card19").click_enabled = false
	get_node("Card20").click_enabled = false
	get_node("Card21").click_enabled = false
	get_node("Card22").click_enabled = false
	get_node("Card23").click_enabled = false
	get_node("Card24").click_enabled = false

func _enable_all_cards_clicks():
	if get_node("Card1").get_node("Sprite").texture == default_image:
		get_node("Card1").click_enabled = true
	if get_node("Card2").get_node("Sprite").texture == default_image:
		get_node("Card2").click_enabled = true
	if get_node("Card3").get_node("Sprite").texture == default_image:
		get_node("Card3").click_enabled = true
	if get_node("Card4").get_node("Sprite").texture == default_image:
		get_node("Card4").click_enabled = true
	if get_node("Card5").get_node("Sprite").texture == default_image:
		get_node("Card5").click_enabled = true
	if get_node("Card6").get_node("Sprite").texture == default_image:
		get_node("Card6").click_enabled = true
	if get_node("Card7").get_node("Sprite").texture == default_image:
		get_node("Card7").click_enabled = true
	if get_node("Card8").get_node("Sprite").texture == default_image:
		get_node("Card8").click_enabled = true
	if get_node("Card9").get_node("Sprite").texture == default_image:
		get_node("Card9").click_enabled = true
	if get_node("Card10").get_node("Sprite").texture == default_image:
		get_node("Card10").click_enabled = true
	if get_node("Card11").get_node("Sprite").texture == default_image:
		get_node("Card11").click_enabled = true
	if get_node("Card12").get_node("Sprite").texture == default_image:
		get_node("Card12").click_enabled = true
	if get_node("Card13").get_node("Sprite").texture == default_image:
		get_node("Card13").click_enabled = true
	if get_node("Card14").get_node("Sprite").texture == default_image:
		get_node("Card14").click_enabled = true
	if get_node("Card15").get_node("Sprite").texture == default_image:
		get_node("Card15").click_enabled = true
	if get_node("Card16").get_node("Sprite").texture == default_image:
		get_node("Card16").click_enabled = true
	if get_node("Card17").get_node("Sprite").texture == default_image:
		get_node("Card17").click_enabled = true
	if get_node("Card18").get_node("Sprite").texture == default_image:
		get_node("Card18").click_enabled = true
	if get_node("Card19").get_node("Sprite").texture == default_image:
		get_node("Card19").click_enabled = true
	if get_node("Card20").get_node("Sprite").texture == default_image:
		get_node("Card20").click_enabled = true
	if get_node("Card21").get_node("Sprite").texture == default_image:
		get_node("Card21").click_enabled = true
	if get_node("Card22").get_node("Sprite").texture == default_image:
		get_node("Card22").click_enabled = true
	if get_node("Card23").get_node("Sprite").texture == default_image:
		get_node("Card23").click_enabled = true
	if get_node("Card24").get_node("Sprite").texture == default_image:
		get_node("Card24").click_enabled = true

func _on_back_button_button_down() -> void:
		get_tree().change_scene_to_file("res://scenes/themes.tscn")

func _on_back_to_menu_button_button_down() -> void:
		get_tree().change_scene_to_file("res://scenes/MenuScene.tscn")
