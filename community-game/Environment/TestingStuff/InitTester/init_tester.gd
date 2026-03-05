@tool
extends Node3D

@export var TheMesh: MeshInstance3D

@export var Mat: Material

@export_tool_button("Set New Material") var Matcha = func():
	TheMesh.set_surface_override_material(0, Mat)
