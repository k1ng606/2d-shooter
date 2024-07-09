extends CharacterBody2D

var enemy_health:int = 40
var enemy_speed:float = 30
var player


func _ready():
	SignalBus.connect("damage_enemy", handle_damage_enemy)
	
	player = get_node("../player")
	
func _process(delta):
	move_towards_player(delta)
	

func move_towards_player(delta):
	var dir = player.position - global_position
	velocity = dir * enemy_speed * delta
	move_and_slide()
#	look_at(player.position)

func handle_damage_enemy(body, damage:int = 10):
	enemy_health = enemy_health - damage
	if enemy_health == 0:
		body.queue_free()
	print("handle_damage_enemy")
