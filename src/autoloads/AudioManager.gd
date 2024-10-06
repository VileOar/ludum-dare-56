extends Node2D

# Dictionary to store each SoundPlayer nodes by its name
var _sound_player_by_name : Dictionary = {}

# Reference to the itself, ensuring only one exists
var instance : Node

func _ready():
	# Store itself to be avaiable in instance. this is used to call functions
	# of the script
	instance = self
	#add the sounds
	add_to_sound_player_dictionary("ButtonHover", $UI/ButtonHover)
	add_to_sound_player_dictionary("ButtonPress", $UI/ButtonPress)
	#creatures
	add_to_sound_player_dictionary("Dying", $Creatures/Dying)
	add_to_sound_player_dictionary("Infect", $Creatures/Infect)
	add_to_sound_player_dictionary("Multiply", $Creatures/Multiply)	
	add_to_sound_player_dictionary("Scream", $Creatures/Scream)	
	add_to_sound_player_dictionary("Trip", $Creatures/Trip)	
	add_to_sound_player_dictionary("Yippee", $Creatures/Yippee)	
	#Godzilla
	add_to_sound_player_dictionary("Demolition", $Godzilla/Demolition)	
	add_to_sound_player_dictionary("FireBreath", $Godzilla/FireBreath)
	add_to_sound_player_dictionary("GoodSoup", $Godzilla/GoodSoup)
	add_to_sound_player_dictionary("Roar", $Godzilla/Roar)			
	add_to_sound_player_dictionary("SoupSlurp", $Godzilla/SoupSlurp)
	add_to_sound_player_dictionary("Stomp", $Godzilla/Stomp)		
	add_to_sound_player_dictionary("Throw", $Godzilla/Throw)	
	add_to_sound_player_dictionary("Vomit", $Godzilla/Vomit)	
	#Music
	add_to_sound_player_dictionary("Music1", $Music/Music1)
	
	
func play_audio(audio_name):
	# Get the "audio_name" node if it exists and is an AudioStreamPlayer
	var audio_node = _sound_player_by_name.get(audio_name)
	audio_node.pitch_scale = randf_range(0.9,1.1)
	
	if audio_node != null:
			audio_node.play()


func stop_audio(audio_name):
	var audio_node = _sound_player_by_name.get(audio_name)
	if audio_node != null:
		audio_node.stop()


func play_audio_Restricted(audio_name):
# Get the "audio_name" node if it exists and is an AudioStreamPlayer
	var audio_node = _sound_player_by_name.get(audio_name)
	
	if audio_node != null:
		# If audio_node exists and is not playing already, play audio
		if !audio_node.is_playing():
			audio_node.play()

func add_to_sound_player_dictionary(node_name, node):
	# Add the node to the sound player dictionary
	# This works as a list with a name to each sound, so you can get it later
	_sound_player_by_name[node_name] = node
