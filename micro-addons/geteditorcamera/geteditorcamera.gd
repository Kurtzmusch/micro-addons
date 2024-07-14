@tool
extends EditorPlugin
class_name GetEditorCamera2


const NODE_3D_VIEWPORT_CLASS_NAME = "Node3DEditorViewport"

var editorInterface

var _editor_viewports = []
var editor_cameras = []

func _enter_tree():
	editorInterface = get_editor_interface()
	_find_viewports(editorInterface.get_base_control())
	for v in _editor_viewports:
		_find_cameras(v)


func _exit_tree():
	return


func _find_viewports(n : Node):
	if n.get_class() == NODE_3D_VIEWPORT_CLASS_NAME:
		_editor_viewports.append(n)
	
	for c in n.get_children():
		_find_viewports(c)

func getCamera():
	return editor_cameras[0]

func _find_cameras(n : Node):
	if n is Camera3D:
		editor_cameras.append(n)
		return
	
	for c in n.get_children():
		_find_cameras(c)
