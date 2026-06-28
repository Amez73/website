@tool
extends PanelContainer
## A reusable card component. The LAYOUT lives in MediaCard.tscn (image on top,
## text below) — open that scene to rearrange it. This script only feeds the
## per-instance content you type into the Inspector into the existing nodes, and
## shows it live in the editor (@tool). It builds no layout itself.
##
## Leave Title/Description/External Url empty -> it's a plain image tile.
## Fill them in -> it becomes a project card with a button.

@export var image_texture: Texture2D: set = _set_image
@export var title_text: String = "": set = _set_title
@export_multiline var description: String = "": set = _set_desc
@export var link_text: String = "Open": set = _set_link_text
@export var external_url: String = "": set = _set_url

@onready var _image: TextureRect = $VBox/Image
@onready var _text: MarginContainer = $VBox/Text
@onready var _title: Label = $VBox/Text/TextBox/Title
@onready var _desc: Label = $VBox/Text/TextBox/Desc
@onready var _link: Button = $VBox/Text/TextBox/Link

func _ready() -> void:
	_apply()
	if not Engine.is_editor_hint():
		_link.pressed.connect(_open_link)

func _open_link() -> void:
	if not external_url.is_empty():
		OS.shell_open(external_url)

func _apply() -> void:
	if not is_node_ready():
		return
	_image.texture = image_texture
	_image.visible = image_texture != null
	_title.text = title_text
	_title.visible = not title_text.is_empty()
	_desc.text = description
	_desc.visible = not description.is_empty()
	_link.text = link_text
	_link.visible = not external_url.is_empty()
	_text.visible = not (title_text.is_empty() and description.is_empty() and external_url.is_empty())

func _set_image(v: Texture2D) -> void:
	image_texture = v
	_apply()

func _set_title(v: String) -> void:
	title_text = v
	_apply()

func _set_desc(v: String) -> void:
	description = v
	_apply()

func _set_link_text(v: String) -> void:
	link_text = v
	_apply()

func _set_url(v: String) -> void:
	external_url = v
	_apply()
