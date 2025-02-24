extends Node2D

const DEFAULT_ICON = preload("res://sprites/circle-48.png")
const CARD_FEATURES_ICON = "res://sprites/card_features/"

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
				item.get_child(0).texture = load(CARD_FEATURES_ICON + "capShape_" + CAP_TYPE.keys()[capType].to_lower() + ".png")
			"EcologicalType":
				item.texture = DEFAULT_ICON
				item.get_child(0).texture = load(CARD_FEATURES_ICON + "ecologicalType_" + ECOLOGICAL_TYPE.keys()[ecologicalType].to_lower() + ".png")
			"EdibleType":
				item.texture = DEFAULT_ICON
				item.get_child(0).texture = load(CARD_FEATURES_ICON + "edibleType_" + EDIBLE_TYPE.keys()[edibleType].to_lower() + ".png")
			"GillType":
				item.texture = DEFAULT_ICON
				item.get_child(0).texture = load(CARD_FEATURES_ICON + "gillType_" + GILL_TYPE.keys()[gillType].to_lower() + ".png")
			"HymeniumType":
				item.texture = DEFAULT_ICON
				item.get_child(0).texture = load(CARD_FEATURES_ICON + "hymeniumType_" + HYMENIUM_TYPE.keys()[hymeniumType].to_lower() + ".png")
			"SporeColor":
				item.texture = DEFAULT_ICON
				# WHITE, PURPLE, YELLOW, BROWN, PINK, BLACK, GREEN
				match sporeColor:
					SPORE_COLOR.WHITE:
						item.modulate = Color.WHITE
					SPORE_COLOR.PURPLE:
						item.modulate = Color.PURPLE
					SPORE_COLOR.YELLOW:
						item.modulate = Color.YELLOW
					SPORE_COLOR.BROWN:
						item.modulate = Color.BROWN
					SPORE_COLOR.PINK:
						item.modulate = Color.PINK
					SPORE_COLOR.BLACK:
						item.modulate = Color.BLACK
					SPORE_COLOR.GREEN:
						item.modulate = Color.GREEN
			"StipeType":
				item.texture = DEFAULT_ICON
				item.get_child(0).texture = load(CARD_FEATURES_ICON + "stipeType_" + STIPE_TYPE.keys()[stipeType].to_lower() + ".png")
