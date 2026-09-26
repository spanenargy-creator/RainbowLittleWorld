class_name MaedeController
extends CharacterBody2D

signal action_finished(action_name:String)

@export var move_speed := 420.0
@export var jump_velocity := -850.0
@export var gravity := 1900.0

var facing := 1
var current_action := "idle"
var base_scale := Vector2.ONE
var anim_tween: Tween

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
    base_scale = scale
    set_process(true)
    play_idle()

func _physics_process(delta:float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta
    if abs(velocity.x) > 1.0:
        facing = 1 if velocity.x > 0 else -1
        sprite.flip_h = facing < 0
        current_action = "run"
    elif is_on_floor() and current_action not in ["happy","surprised","wave"]:
        current_action = "idle"
    move_and_slide()
    if is_on_floor() and current_action == "run":
        play_run()
    elif is_on_floor() and current_action == "idle":
        play_idle()

func move_horizontal(direction:float) -> void:
    velocity.x = direction * move_speed
    if direction != 0:
        facing = 1 if direction > 0 else -1
        sprite.flip_h = facing < 0

func stop_horizontal() -> void:
    velocity.x = move_toward(velocity.x,0,move_speed*0.35)

func jump() -> void:
    if is_on_floor():
        velocity.y = jump_velocity
        current_action = "jump"
        _animate_jump()

func happy() -> void:
    current_action = "happy"
    _cancel_anim()
    anim_tween = create_tween().set_loops(3)
    anim_tween.tween_property(self,"rotation",deg_to_rad(6),0.12)
    anim_tween.tween_property(self,"rotation",deg_to_rad(-6),0.12)
    anim_tween.tween_property(self,"rotation",0.0,0.12)
    anim_tween.finished.connect(func(): current_action="idle"; play_idle())

func surprised() -> void:
    current_action = "surprised"
    _cancel_anim()
    anim_tween=create_tween()
    anim_tween.tween_property(self,"scale",base_scale*1.12,0.12)
    anim_tween.tween_property(self,"scale",base_scale*0.94,0.10)
    anim_tween.tween_property(self,"scale",base_scale,0.12)
    anim_tween.finished.connect(func(): current_action="idle"; play_idle())

func wave() -> void:
    current_action="wave"
    _cancel_anim()
    anim_tween=create_tween().set_loops(4)
    anim_tween.tween_property(sprite,"rotation",deg_to_rad(8),0.12)
    anim_tween.tween_property(sprite,"rotation",deg_to_rad(-8),0.12)
    anim_tween.tween_property(sprite,"rotation",0.0,0.12)
    anim_tween.finished.connect(func(): current_action="idle"; play_idle())

func play_idle() -> void:
    if current_action in ["happy","surprised","wave"]: return
    current_action="idle"
    _cancel_anim()
    anim_tween=create_tween().set_loops()
    anim_tween.tween_property(sprite,"position:y",-8.0,0.65).set_trans(Tween.TRANS_SINE)
    anim_tween.tween_property(sprite,"position:y",0.0,0.65).set_trans(Tween.TRANS_SINE)

func play_run() -> void:
    if current_action=="run" and anim_tween and anim_tween.is_running(): return
    _cancel_anim()
    anim_tween=create_tween().set_loops()
    anim_tween.tween_property(sprite,"scale",base_scale*Vector2(1.03,0.97),0.12)
    anim_tween.tween_property(sprite,"scale",base_scale*Vector2(0.97,1.03),0.12)

func _animate_jump() -> void:
    _cancel_anim()
    anim_tween=create_tween()
    anim_tween.tween_property(sprite,"rotation",deg_to_rad(-4),0.10)
    anim_tween.tween_property(sprite,"rotation",deg_to_rad(4),0.12)
    anim_tween.tween_property(sprite,"rotation",0.0,0.10)

func _cancel_anim() -> void:
    if anim_tween:
        anim_tween.kill()
    sprite.rotation=0.0
    sprite.scale=base_scale
