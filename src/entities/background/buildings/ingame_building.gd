extends Node3D

@onready var building: Node3D = %Building
@onready var rubble: Node3D = %Rubble


func ravage_building():
	building.visible = false
	rubble.visible = true
