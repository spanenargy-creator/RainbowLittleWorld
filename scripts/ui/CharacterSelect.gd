extends Control

var chars=CharacterData.all_characters()

func _ready():
    $Back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/Main.tscn"))
    _refresh()

func _refresh():
    for child in $Characters.get_children():
        child.queue_free()
    for i in chars.size():
        var panel := VBoxContainer.new()
        panel.custom_minimum_size = Vector2(400, 330)

        if chars[i].portrait_path != "":
            var pic := TextureRect.new()
            pic.texture = load(chars[i].portrait_path)
            pic.custom_minimum_size = Vector2(400, 240)
            pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
            pic.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
            panel.add_child(pic)

        var b:=Button.new()
        b.custom_minimum_size=Vector2(400,80)
        b.text="👧  %s\n%s" % [chars[i].name_fa,chars[i].description]
        b.add_theme_font_size_override("font_size",24)
        b.modulate=Color.WHITE if i==GameState.selected_character else Color(0.78,0.78,0.78)
        b.pressed.connect(_choose.bind(i))
        panel.add_child(b)
        $Characters.add_child(panel)

func _choose(i:int):
    GameState.selected_character=i
    GameState.save_game()
    _refresh()
