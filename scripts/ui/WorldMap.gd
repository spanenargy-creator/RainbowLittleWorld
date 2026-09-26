extends Control

var worlds = WorldData.all_worlds()

func _ready() -> void:
    $Back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/Main.tscn"))
    _build_map()

func _build_map() -> void:
    for i in worlds.size():
        var b := Button.new()
        b.custom_minimum_size = Vector2(300,150)
        b.text = "%s  %s" % [worlds[i].emoji, worlds[i].title]
        b.disabled = not GameState.unlocked_worlds[i]
        b.add_theme_font_size_override("font_size", 28)
        b.pressed.connect(_open_world.bind(i))
        $WorldList.add_child(b)

func _open_world(index:int) -> void:
    GlobalWorld.selected_world = index
    get_tree().change_scene_to_file("res://scenes/LevelSelect.tscn")
