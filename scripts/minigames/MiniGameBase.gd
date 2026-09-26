class_name MiniGameBase
extends Control

@export var world_id:int = 0
@export var level_id:int = 1
var progress:=0
var required:=3

func _ready():
    _add_player_avatar()

func _add_player_avatar():
    var chars = CharacterData.all_characters()
    if GameState.selected_character >= chars.size():
        return
    var path = chars[GameState.selected_character].portrait_path
    if path == "":
        return
    var avatar := TextureRect.new()
    avatar.name = "PlayerCharacter"
    avatar.texture = load(path)
    avatar.position = Vector2(20, 20)
    avatar.size = Vector2(230, 300)
    avatar.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    avatar.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    add_child(avatar)

func finish():
    GameState.complete_level(world_id,level_id)
    get_tree().change_scene_to_file("res://scenes/Reward.tscn")

func register_success():
    progress+=1
    if progress>=required:
        finish()
