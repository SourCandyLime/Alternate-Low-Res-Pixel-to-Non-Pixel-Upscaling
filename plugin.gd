@tool
extends EditorPlugin

func _enter_tree():
	print("========================================")
	print("Pixelation Shaders Plugin Enabled!")
	print("========================================")
	print("Template scenes available at:")
	print("  res://addons/pixelation_shaders/templates/")
	print("")
	print("Usage:")
	print("  1. Drag hexel_root.tscn or triangel_root.tscn into your scene")
	print("  2. Add your game content as a child of the SubViewport node")
	print("  3. Adjust viewport_resolution in the inspector")
	print("")
	print("See README.md for full documentation")
	print("========================================")

func _exit_tree():
	print("Pixelation Shaders Plugin Disabled")
