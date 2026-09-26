extends Node
## Central audio service. Replace placeholder streams with licensed assets later.
var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready() -> void:
    music_player = AudioStreamPlayer.new()
    sfx_player = AudioStreamPlayer.new()
    add_child(music_player)
    add_child(sfx_player)

func play_tap() -> void:
    if GameState.sound_enabled:
        # Audio assets are intentionally external to this architecture package.
        pass

func play_success() -> void:
    if GameState.sound_enabled:
        pass

func set_music(enabled: bool) -> void:
    GameState.music_enabled = enabled
    GameState.save_game()
