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
var image1_a # Apfel Bild 1 (eine Hälfte des Paares)
var image1_b # Apfel Bild 2 (die andere Hälfte des Paares)
var image2_a # Banane Bild 1
var image2_b # Banane Bild 2
var image3_a # Bett Bild 1
var image3_b # Bett Bild 2
var image4_a # Elefant Bild 1
var image4_b # Elefant Bild 2
var image5_a # Erdbeere Bild 1
var image5_b # Erdbeere Bild 2
var image6_a # Hemd Bild 1
var image6_b # Hemd Bild 2
var image7_a # Hund Bild 1
var image7_b # Hund Bild 2
var image8_a # Jeans Bild 1
var image8_b # Jeans Bild 2
var image9_a # Katze Bild 1
var image9_b # Katze Bild 2
var image10_a # Mütze Bild 1
var image10_b # Mütze Bild 2
var image11_a # Stuhl Bild 1
var image11_b # Stuhl Bild 2
var image12_a # Tisch Bild 1
var image12_b # Tisch Bild 2

# Die Namen für die Paare
var name_pair_1 = "Apfel"
var name_pair_2 = "Banane"
var name_pair_3 = "Bett"
var name_pair_4 = "Elefant"
var name_pair_5 = "Erdbeere"
var name_pair_6 = "Hemd"
var name_pair_7 = "Hund"
var name_pair_8 = "Jeans"
var name_pair_9 = "Katze"
var name_pair_10 = "Mütze"
var name_pair_11 = "Stuhl"
var name_pair_12 = "Tisch"

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
	default_image = preload("res://sprites/german/background-deutsch.png") # die Kartenrückseite

	# Lade 24 einzigartige Bilder
	image1_a = preload("res://sprites/german/apfel_a.png") 
	image1_b = preload("res://sprites/german/apfel_b.png") 
	image2_a = preload("res://sprites/german/banane_a.png")
	image2_b = preload("res://sprites/german/banane_b.png")
	image3_a = preload("res://sprites/german/bett_a.png")
	image3_b = preload("res://sprites/german/bett_b.png")
	image4_a = preload("res://sprites/german/elefant_a.png")
	image4_b = preload("res://sprites/german/elefant_b.png")
	image5_a = preload("res://sprites/german/erdbeere_a.png")
	image5_b = preload("res://sprites/german/erdbeere_b.png")
	image6_a = preload("res://sprites/german/hemd_a.png")
	image6_b = preload("res://sprites/german/hemd_b.png")
	image7_a = preload("res://sprites/german/hund_a.png")
	image7_b = preload("res://sprites/german/hund_b.png")
	image8_a = preload("res://sprites/german/jeans_a.png")
	image8_b = preload("res://sprites/german/jeans_b.png")
	image9_a = preload("res://sprites/german/katze_a.png")
	image9_b = preload("res://sprites/german/katze_b.png")
	image10_a = preload("res://sprites/german/muetze_a.png")
	image10_b = preload("res://sprites/german/muetze_b.png")
	image11_a = preload("res://sprites/german/stuhl_a.png")
	image11_b = preload("res://sprites/german/stuhl_b.png")
	image12_a = preload("res://sprites/german/tisch_a.png")
	image12_b = preload("res://sprites/german/tisch_b.png")

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

func _on_BackToMenuButton_button_down():
		get_tree().change_scene_to_file("res://scenes/MenuScene.tscn")

func _on_back_button_button_down() -> void:
		get_tree().change_scene_to_file("res://scenes/themes.tscn")
