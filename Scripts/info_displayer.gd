class_name InfoDisplayer
extends CanvasLayer

@onready var info_label : Label = $InfoLabel
@onready var timer : Timer = $Timer

func _ready() -> void:
	info_label.visible = false

func display (info : String):
	info_label.visible = true
	info_label.text = info
	timer.start()

func _on_timer_timeout() -> void:
	info_label.visible = false
