extends Control

func _ready():
    $Back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/WorldMap.tscn"))
    for i in range(1,6):
        var b:=Button.new()
        b.custom_minimum_size=Vector2(650,120)
        b.text="مرحله %d  %s" % [i, "🌸" if i==1 else "🔒"]
        b.add_theme_font_size_override("font_size",28)
        b.disabled=(i!=1)
        if i==1:
            b.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/FirstGarden.tscn"))
        $LevelList.add_child(b)
