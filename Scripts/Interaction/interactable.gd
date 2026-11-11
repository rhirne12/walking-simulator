@abstract  ## this script is abstract - can't be attached to a Node Directly
class_name Interactable
extends Area3D

@abstract 
func get_prompt() -> String

@abstract 
func can_interact() -> bool

@abstract 
func interact()
