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

func set_card_characteristics(mushroom_name: String, mushroom_card: Object, json_data_dict: Dictionary):
	mushroom_card.name = mushroom_name.capitalize()
	
	mushroom_card.commonName = mushroom_name.capitalize()
	mushroom_card.scientificName = json_data_dict["scientific name"].capitalize()
	mushroom_card.mushroomDescription = json_data_dict["description"].capitalize()
	
	var mushroom_cap_type = json_data_dict["cap shape"].to_upper()
	# CAMPANULATE, CONCICAL, CONVEX, DEPRESSED, FLAT, INFUNDIBULIFORM, OFFSET, OVATE, UMBILLICATE, UMBONATE, NONE, NA}
	mushroom_card.capType = mushroom_card.CAP_TYPE.NA
	match mushroom_cap_type:
		"CAMPANULATE": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.CAMPANULATE
		"CONCICAL": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.CONCICAL
		"CONVEX": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.CONVEX
		"DEPRESSED": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.DEPRESSED
		"FLAT": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.FLAT
		"INFUNDIBULIFORM": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.INFUNDIBULIFORM
		"OFFSET": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.OFFSET
		"OVATE": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.OVATE
		"UMBILLICATE": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.UMBILLICATE
		"NONE": 
			mushroom_card.capType = mushroom_card.CAP_TYPE.NONE

	var mushroom_gill_type = json_data_dict["gill type"].to_upper()
	# ADNATE, ADNEXED, DECURRENT, EMARGINATE, FREE, SECEDING, SINUATE, SUBDECURRENT, NONE, NA
	mushroom_card.gillType = mushroom_card.GILL_TYPE.NA
	match mushroom_gill_type:
		"ADNATE": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.ADNATE
		"ADNEXED": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.ADNEXED
		"DECURRENT": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.DECURRENT
		"EMARGINATE": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.EMARGINATE
		"FREE": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.FREE
		"SECEDING": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.SECEDING
		"SINUATE": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.SINUATE
		"SUBDECURRENT": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.SUBDECURRENT
		"NONE": 
			mushroom_card.gillType = mushroom_card.GILL_TYPE.NONE

	var mushroom_ecological_type = json_data_dict["ecological type"].to_upper()
	# MYCORRHIZAL, SAPROTROPHIC, PARASITIC
	match mushroom_ecological_type:
		"MYCORRHIZAL": 
			mushroom_card.ecologicalType = mushroom_card.ECOLOGICAL_TYPE.MYCORRHIZAL
		"SAPROTROPHIC": 
			mushroom_card.ecologicalType = mushroom_card.ECOLOGICAL_TYPE.SAPROTROPHIC
		"PARASITIC": 
			mushroom_card.ecologicalType = mushroom_card.ECOLOGICAL_TYPE.PARASITIC

	var mushroom_hymenium_type = json_data_dict["hymenium type"].to_upper()
	# GILLS, GLEBA, PORES, RIDGES, SMOOTH, TEETH
	match mushroom_hymenium_type:
		"GILLS": 
			mushroom_card.hymeniumType = mushroom_card.HYMENIUM_TYPE.GILLS
		"GLEBA": 
			mushroom_card.hymeniumType = mushroom_card.HYMENIUM_TYPE.GLEBA
		"PORES": 
			mushroom_card.hymeniumType = mushroom_card.HYMENIUM_TYPE.PORES
		"RIDGES": 
			mushroom_card.hymeniumType = mushroom_card.HYMENIUM_TYPE.RIDGES
		"SMOOTH": 
			mushroom_card.hymeniumType = mushroom_card.HYMENIUM_TYPE.SMOOTH
		"TEETH": 
			mushroom_card.hymeniumType = mushroom_card.HYMENIUM_TYPE.TEETH

	var mushroom_edible_type = json_data_dict["edible"].to_upper()
	# POISONOUS, PSYCHOACTIVE, CHOICE, DEADLY, EDIBLE, ALLERGENIC, INEDIBLE, UNKNOWN
	match mushroom_edible_type:
		"POISONOUS": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.POISONOUS
		"PSYCHOACTIVE": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.PSYCHOACTIVE
		"CHOICE": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.CHOICE
		"DEADLY": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.DEADLY
		"EDIBLE": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.EDIBLE
		"ALLERGENIC": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.ALLERGENIC
		"INEDIBLE": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.INEDIBLE
		"UNKNOWN": 
			mushroom_card.edibleType = mushroom_card.EDIBLE_TYPE.UNKNOWN

	var mushroom_spore_color = json_data_dict["spore color"].to_upper()
	# WHITE, PURPLE, YELLOW, BROWN, PINK, BLACK, GREEN
	match mushroom_spore_color:
		"WHITE": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.WHITE
		"PURPLE": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.PURPLE
		"YELLOW": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.YELLOW
		"BROWN": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.BROWN
		"PINK": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.PINK
		"BLACK": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.BLACK
		"GREEN": 
			mushroom_card.sporeColor = mushroom_card.SPORE_COLOR.GREEN

	var mushroom_stipe_type = json_data_dict["stipe type"].to_upper()
	# BARE, CORTINA, RING, RING_VOLVA, VOLVA, NA
	mushroom_card.stipeType = mushroom_card.STIPE_TYPE.NA
	match mushroom_stipe_type:
		"BARE": 
			mushroom_card.stipeType = mushroom_card.STIPE_TYPE.BARE
		"CORTINA": 
			mushroom_card.stipeType = mushroom_card.STIPE_TYPE.CORTINA
		"RING": 
			mushroom_card.stipeType = mushroom_card.STIPE_TYPE.RING
		"RING_VOLVA": 
			mushroom_card.stipeType = mushroom_card.STIPE_TYPE.RING_VOLVA
		"VOLVA": 
			mushroom_card.stipeType = mushroom_card.STIPE_TYPE.VOLVA
