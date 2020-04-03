extends Control

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _player_connected(id):
	print("Player connected to server!")
	#Game on!
	$globals.otherPlayerId = id
	var game = preload("res://World.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()

func _on_StartBT_pressed():
	
	print("Hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(57043, 4)
	if res != OK:
		print("Error creating server")
		return

	#$StartBT2.hide()
	#$StartBT.disabled = true
	get_tree().set_network_peer(host)
	
	get_tree().change_scene("res://World.tscn")

func _on_StartBT2_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1", 57043)
	get_tree().get_network_peer()
	#$StartBT.hide()
	#$StartBT2.disabled = true
	
	get_tree().change_scene("res://World.tscn")

func _on_QuitBT_pressed():
	get_tree().quit()

