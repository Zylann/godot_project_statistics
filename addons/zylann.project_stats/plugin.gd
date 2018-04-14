tool
extends EditorPlugin

const Analyzer = preload("analyzer.gd")
var Window = load("res://addons/zylann.project_stats/window.tscn")

const MENU_SHOW = 0

var _analyzer = null
var _window = null


func _enter_tree():
	print("EditorPlugin enter tree")
	
	_window = Window.instance()
	get_editor_interface().get_base_control().add_child(_window)
	
	_analyzer = Analyzer.new()
	_window.call_deferred("set_analyzer", _analyzer)
	add_child(_analyzer)
	
	# TODO Need Godot version including this merge https://github.com/godotengine/godot/pull/17576
#	var menu = PopupMenu.new()
#	menu.add_item("Show", MENU_SHOW)
#	menu.connect("id_pressed", self, "_on_menu_id_pressed")
#	add_tool_submenu_item("Project statistics", menu)
	var menu_button = MenuButton.new()
	menu_button.text = "Project statistics"
	menu_button.get_popup().add_item("Show", MENU_SHOW)
	menu_button.get_popup().connect("id_pressed", self, "_on_menu_id_pressed")
	add_control_to_container(CONTAINER_TOOLBAR, menu_button)
	
	#_analyzer.run()


func _on_menu_id_pressed(id):
	if id == MENU_SHOW:
		_window.popup_centered_minsize()

