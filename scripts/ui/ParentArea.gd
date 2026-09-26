extends Control

func _ready():
    $Back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/Main.tscn"))
    $Stats.text="پیشرفت بازی\n\n⭐ ستاره‌ها: %d\n💎 الماس‌ها: %d\n👗 لباس‌ها: %d\n\nاین بخش مخصوص والدین است." % [
        GameState.stars,GameState.gems,GameState.owned_costumes.size()
    ]
