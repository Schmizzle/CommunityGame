extends Node3D

@export var Mat: Material:
	set(value):
		Mat = value
		TheMesh.set_surface_override_material(0, value)
		return value

@export var TheMesh: MeshInstance3D
