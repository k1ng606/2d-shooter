extends Area2D

var speed = 750
var bullet_damage:int = 20

func _ready():
	$".".body_entered.connect(handle_body_entered)
	$".".area_entered.connect(handle_body_entered)
	$projectileDespawnTimer.connect("timeout", Callable($".", "despawnBullet"))

func _physics_process(delta):
	position += transform.x * speed * delta

func handle_body_entered(body):
	SignalBus.bulletCollision.emit(body, bullet_damage)
	despawnBullet()

func despawnBullet():
	queue_free()
