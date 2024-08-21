extends Node


func switch_fullscreen(bool_value : bool):
	if bool_value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
		
func switch_vsync(bool_value : bool):
	if bool_value:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
