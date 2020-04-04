extends Node2D

onready var MessageLogSize = 6
onready var MessageLogArray = ["1","2","3","4","5","6"]
onready var MessageLogVBC = get_node("NinePatchRect/MarginContainer/VBoxContainer")
onready var alpha_reduction = 128 / MessageLogSize

# this & other utility functions normally loaded in singleton
static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _ready():
	_resize(MessageLogSize)
	_updateLabels()
	_addLine("Welcome to my Roguelike!")
	_addLine("You feel uneasy about this place...")

func _resize(size):
	MessageLogArray.resize(size)
	alpha_reduction = 192 / size
	
	delete_children(MessageLogVBC)
	
	for i in range(0,size):
		var new_label = Label.new()
		new_label.text = str(i)
		MessageLogVBC.add_child(new_label)
		pass	

func _updateLabels():
	var size = MessageLogArray.size()
	
	for i in range(size - 1, -1, -1):
		var label = MessageLogVBC.get_child(size - 1 - i)
		# var label = get_node("NinePatchRect/MarginContainer/VBoxContainer/Label"+str(i+1))
		if label != null:
			label.text = MessageLogArray[i]
			label.self_modulate.a = (255 - (i * alpha_reduction)) / 255.0

func _addLine(message):
	MessageLogArray.push_front(message)
	MessageLogArray.pop_back()
	_updateLabels()
