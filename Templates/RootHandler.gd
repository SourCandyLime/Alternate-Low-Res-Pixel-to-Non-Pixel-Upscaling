@tool
extends Node
@export var resolution := Vector2i(160, 90):
	set(value):
		resolution = value
		_update_viewport_size()
@onready var subviewport : SubViewport = $Screen
@onready var  tex_rect : TextureRect = $Control/Shader
func _ready():
	_update_viewport_size()
	_setup_shader()
func _update_viewport_size():
	if subviewport:
		subviewport.size = resolution
func _setup_shader():
	if tex_rect and subviewport:
		tex_rect.texture = subviewport.get_texture()
func _unhandled_input(event):
	if Engine.is_editor_hint():
		return
	if event is InputEventMouse:
		var mouse_screen = event.position
		var screen_size = get_viewport().size
		var viewport_size = subviewport.size
		var mouse_viewport = mouse_screen * (Vector2(viewport_size) / Vector2(screen_size))
		var e = event.duplicate()
		e.position = mouse_viewport
		subviewport.push_input(e)
	else:
		subviewport.push_input(event)
