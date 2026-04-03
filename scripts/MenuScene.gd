extends Node2D

var game_manager_scene: PackedScene = preload("res://scenes/GameManager.tscn")
var game_manager_instance: Node

# --- CORRECTED POSITION FOR @onready var background_node ---
@onready var background_node = $Background 

func _ready():
	game_manager_instance = game_manager_scene.instantiate()
	add_to_group("menu_scene_group") 

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://scenes/themes.tscn")
	var ui_elements = [
		"StartButton", "QuitButton", "GameName", "Credits", "ClickColors",
		"Logo", "Icon"
	]
		
	for name in ui_elements:
		# Check if the node exists before trying to access it to prevent errors
		if has_node(name):
			get_node(name).visible = false
		else:
			print("Warning: UI element '", name, "' not found in MainScene.")


	add_child(game_manager_instance)

func _on_QuitButton_button_down():
	get_tree().quit()

func _on_german_theme_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/GameManager.tscn")

func _on_math_theme_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/GameManager2.tscn")

func _on_english_theme_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/GameManager3.tscn")
		
func _on_back_to_menu_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/MenuScene.tscn")

func _on_tutorial_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")
