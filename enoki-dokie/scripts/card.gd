extends Node2D

const DEFAULT_ICON = preload("res://sprites/circle-48.png")

enum CAP_TYPE{CAMPANULATE, CONCICAL, CONVEX, DEPRESSED, FLAT, INFUNDIBULIFORM, OFFSET, OVATE, UMBILLICATE, UMBONATE, NONE, NA}
enum GILL_TYPE{ADNATE, ADNEXED, DECURRENT, EMARGINATE, FREE, SECEDING, SINUATE, SUBDECURRENT, NONE, NA}
enum HYMENIUM_TYPE{GILLS, GLEBA, PORES, RIDGES, SMOOTH, TEETH}
enum STIPE_TYPE{BARE, CORTINA, RING, RING_VOLVA, VOLVA, NA}
enum SPORE_COLOR{WHITE, PURPLE, YELLOW, BROWN, PINK, BLACK, GREEN}
enum ECOLOGICAL_TYPE{MYCORRHIZAL, SAPROTROPHIC, PARASITIC}
enum EDIBLE_TYPE{POISONOUS, PSYCHOACTIVE, CHOICE, DEADLY, EDIBLE, ALLERGENIC, INEDIBLE, UNKNOWN}

@export var commonName: String = "Common Name"
@export var scientificName: String = "Scientific Name"
@export var mushroomDescription: String = "Placeholder Description Text"

@export var capType: CAP_TYPE
@export var ecologicalType: ECOLOGICAL_TYPE
@export var edibleType: EDIBLE_TYPE
@export var gillType: GILL_TYPE
@export var hymeniumType: HYMENIUM_TYPE
@export var sporeColor: SPORE_COLOR
@export var stipeType: STIPE_TYPE

@onready var mushroom_items: GridContainer = %MushroomItems
@onready var common_name: RichTextLabel = %CommonName
@onready var science_name: RichTextLabel = %ScienceName
@onready var description: RichTextLabel = %Description

func _ready() -> void:
	common_name.text = "[b]" + commonName + "[/b]"
	science_name.text = "[i]" + scientificName + "[/i]"
	description.text = "[center][i]" + mushroomDescription + "[/i][/center]"

	# set mushroom features
	for item in mushroom_items.get_children():
		match item.name:
			"CapType": 
				item.texture = DEFAULT_ICON
				item.modulate = Color.CORAL
			"EcologicalType":
				item.texture = DEFAULT_ICON
				item.modulate = Color.AQUA
			"EdibleType":
				item.texture = DEFAULT_ICON
				item.modulate = Color.GREEN
			"GillType":
				item.texture = DEFAULT_ICON
				item.modulate = Color.PURPLE
			"HymeniumType":
				item.texture = DEFAULT_ICON
				item.modulate = Color.BLUE
			"SporeColor":
				item.texture = DEFAULT_ICON
				item.modulate = Color.ORANGE
			"StipeType":
				item.texture = DEFAULT_ICON
				item.modulate = Color.YELLOW
