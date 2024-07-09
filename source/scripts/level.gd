extends Node2D

var bullet:PackedScene = preload("res://source/scenes/bullet.tscn")

var enemy:PackedScene = preload("res://source/scenes/enemy.tscn")

func _ready():
	$player.connect("shootSignal", Callable(self, "playerShoot"))
	SignalBus.connect("bulletCollision", handle_bulletHit)
	$"enemy spawn timer".connect("timeout", Callable(self, "spawn_enemy"))
#	var enemy_instance = enemy.instantiate()
#	add_child(enemy_instance)

func spawn_enemy():
	var enemy_instance = enemy.instantiate()
	add_child(enemy_instance)

func playerShoot():
	spawnBullet()
	
func spawnBullet():
	var bulletInstance = bullet.instantiate()
	bulletInstance.global_transform.origin = $player.get_node("bulletSpawnMarker").global_transform.origin
	bulletInstance.rotation = $player.rotation
	
	$projectileContainer.add_child(bulletInstance)
	
func handle_bulletHit(body, bullet_damage):
	print("handle_bulletHit")
	if body.is_in_group("enemy"):
		SignalBus.damage_enemy.emit(body, bullet_damage)
