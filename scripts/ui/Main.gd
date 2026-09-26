extends Control

var characters = CharacterData.all_characters()
var worlds = WorldData.all_worlds()

func _ready() -> void:
    $Title.text = "دنیای رنگین‌کمان کوچولو"
    $Subtitle.text = "یک ماجراجویی شاد برای کوچولوها"
    $StartButton.pressed.connect(_on_start)
    $CharactersButton.pressed.connect(_on_characters)
    $ParentButton.pressed.connect(_on_parent)

func _on_start() -> void:
    get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")

func _on_characters() -> void:
    get_tree().change_scene_to_file("res://scenes/CharacterSelect.tscn")

func _on_parent() -> void:
    get_tree().change_scene_to_file("res://scenes/ParentArea.tscn")
