extends Node
## Persistent child-safe game state. No network access.
const SAVE_PATH := "user://rainbow_little_world.save"

var stars: int = 0
var gems: int = 0
var selected_character: int = 0
var unlocked_worlds: Array[bool] = [true, false, false, false, false, false, false, false, false, false]
var completed_levels: Dictionary = {}
var owned_costumes: Array[String] = ["default"]
var sound_enabled := true
var music_enabled := true

func _ready() -> void:
    load_game()

func complete_level(world: int, level: int) -> void:
    completed_levels["%d_%d" % [world, level]] = true
    stars += 3
    gems += 1
    if level >= 5 and world < unlocked_worlds.size() - 1:
        unlocked_worlds[world + 1] = true
    save_game()

func is_completed(world: int, level: int) -> bool:
    return completed_levels.get("%d_%d" % [world, level], false)

func save_game() -> void:
    var data := {
        "stars": stars, "gems": gems,
        "selected_character": selected_character,
        "unlocked_worlds": unlocked_worlds,
        "completed_levels": completed_levels,
        "owned_costumes": owned_costumes,
        "sound_enabled": sound_enabled,
        "music_enabled": music_enabled
    }
    var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if f:
        f.store_string(JSON.stringify(data))

func load_game() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return
    var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if not f: return
    var parsed = JSON.parse_string(f.get_as_text())
    if typeof(parsed) != TYPE_DICTIONARY: return
    stars = int(parsed.get("stars", 0))
    gems = int(parsed.get("gems", 0))
    selected_character = int(parsed.get("selected_character", 0))
    unlocked_worlds.assign(parsed.get("unlocked_worlds", unlocked_worlds))
    completed_levels = parsed.get("completed_levels", {})
    owned_costumes.assign(parsed.get("owned_costumes", ["default"]))
    sound_enabled = bool(parsed.get("sound_enabled", true))
    music_enabled = bool(parsed.get("music_enabled", true))
