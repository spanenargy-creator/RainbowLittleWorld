extends Node2D

@onready var maede: MaedeController = $Maede
var target_color := Color("#ff79b7")
var score := 0
var time_left := 45.0
var playing := true

func _ready() -> void:
    $HUD/Message.text = "مائده! گل‌های صورتی را پیدا کن 🌸"
    $HUD/Score.text = "⭐ 0 / 5"
    $HUD/Timer.text = "⏱ 45"
    $HUD/Left.button_down.connect(func(): maede.move_horizontal(-1))
    $HUD/Left.button_up.connect(func(): maede.stop_horizontal())
    $HUD/Right.button_down.connect(func(): maede.move_horizontal(1))
    $HUD/Right.button_up.connect(func(): maede.stop_horizontal())
    $HUD/Jump.pressed.connect(func(): maede.jump())
    $HUD/Wave.pressed.connect(func(): maede.wave())
    _spawn_flowers()

func _process(delta:float) -> void:
    if not playing: return
    time_left -= delta
    $HUD/Timer.text = "⏱ %d" % max(0,ceil(time_left))
    if time_left <= 0:
        _finish(false)

func _spawn_flowers() -> void:
    var positions=[Vector2(420,1180),Vector2(820,1030),Vector2(1240,1240),Vector2(1660,980),Vector2(2050,1160)]
    for i in positions.size():
        var flower=Area2D.new()
        flower.name="PinkFlower%d"%i
        flower.position=positions[i]
        var visual=Label.new()
        visual.text="🌸"
        visual.add_theme_font_size_override("font_size",90)
        visual.position=Vector2(-45,-65)
        flower.add_child(visual)
        var shape=CollisionShape2D.new()
        var circle=CircleShape2D.new()
        circle.radius=70
        shape.shape=circle
        flower.add_child(shape)
        flower.body_entered.connect(_flower_entered.bind(flower))
        add_child(flower)

func _flower_entered(body:Node, flower:Area2D) -> void:
    if body != maede or not is_instance_valid(flower): return
    score += 1
    $HUD/Score.text="⭐ %d / 5"%score
    maede.happy()
    flower.queue_free()
    if score >= 5:
        _finish(true)

func _finish(success:bool) -> void:
    if not playing: return
    playing=false
    if success:
        GameState.complete_level(0,1)
        $HUD/Message.text="آفرین مائده! همه گل‌ها را پیدا کردی! 🎉"
        $HUD/Continue.visible=true
        maede.happy()
    else:
        $HUD/Message.text="اشکالی نداره! دوباره امتحان کنیم 💗"
        $HUD/Retry.visible=true
        maede.surprised()

func _on_continue_pressed():
    get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")

func _on_retry_pressed():
    get_tree().reload_current_scene()
