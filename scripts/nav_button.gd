extends Button
## Attach to any Button to make it navigate. In the Inspector set ONE of:
##   Target Scene  -> opens another page  (e.g. res://scenes/pages/Pottery.tscn)
##   External Url  -> opens a browser tab (e.g. writing.html, an itch.io link)
##   Download Url  -> downloads a file straight away, no new tab
## This is behaviour only — the button's look and text are set on the node.

@export_file("*.tscn") var target_scene: String = ""
@export var external_url: String = ""
@export var download_url: String = ""

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	if not download_url.is_empty():
		_download(download_url)
	elif not external_url.is_empty():
		OS.shell_open(external_url)
	elif not target_scene.is_empty():
		get_tree().change_scene_to_file(target_scene)

func _download(url: String) -> void:
	if OS.has_feature("web"):
		# A hidden <a download> click starts the download without leaving the page.
		JavaScriptBridge.eval("""
			const a = document.createElement('a');
			a.href = %s; a.download = ''; a.style.display = 'none';
			document.body.appendChild(a); a.click(); a.remove();
		""" % JSON.stringify(url))
	else:
		OS.shell_open(url)
