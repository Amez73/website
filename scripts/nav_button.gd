extends Button
## Attach to any Button to make it navigate. In the Inspector set ONE of:
##   Target Scene  -> opens another page  (e.g. res://scenes/pages/Pottery.tscn)
##   External Url  -> opens a browser tab (e.g. writing.html, an itch.io link)
## This is behaviour only — the button's look and text are set on the node.

@export_file("*.tscn") var target_scene: String = ""
@export var external_url: String = ""

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	if not external_url.is_empty():
		OS.shell_open(external_url)
	elif not target_scene.is_empty():
		get_tree().change_scene_to_file(target_scene)
