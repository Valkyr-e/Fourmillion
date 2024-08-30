extends HBoxContainer

var active_tab : VBoxContainer 

@onready var active_sections_focus : Control = $Sections/Graphics 


enum TAB_NAMES {GRAPHICS , CONTROL , SOUND}

@onready var tab_dict = {\
	TAB_NAMES.GRAPHICS : {\
		"node" : $GraphicsTab,\
		"auto_focus" : $GraphicsTab/Fullscreen/FullScreen\
	},\
	TAB_NAMES.CONTROL : {\
		"node" : $ControlsTab,\
		"auto_focus" : null\
	},\
	TAB_NAMES.SOUND : {\
		"node" : $SoundTab,\
		"auto_focus" : $SoundTab/Volumes/MainVolumeSlider\
	}\
}

func _ready():
	active_sections_focus.grab_focus()

func change_active_tab(target : VBoxContainer):
	if  active_tab and active_tab != target:
		active_tab.hide()
	active_tab = target
	active_tab.show()

	


#region Signals for Tab Change 
func _on_graphics_pressed():
	change_active_tab(tab_dict[TAB_NAMES.GRAPHICS]["node"])
	if tab_dict[TAB_NAMES.GRAPHICS]["auto_focus"]:
		tab_dict[TAB_NAMES.GRAPHICS]["auto_focus"].grab_focus()

func _on_controls_pressed():
	change_active_tab(tab_dict[TAB_NAMES.CONTROL]["node"])

func _on_sound_pressed():
	change_active_tab(tab_dict[TAB_NAMES.SOUND]["node"])

func _on_quit_pressed():
	get_tree().quit()
#endregion




func _on_main_volume_slider_value_changed(_value):
	pass # Replace with function body.


func _on_music_volume_slider_value_changed(_value):
	pass # Replace with function body.


func _on_full_screen_toggled(toggled_on):
	GlobalSettings.switch_fullscreen(toggled_on)


func _on_v_sync_toggled(_toggled_on):
	pass # Replace with function body.
