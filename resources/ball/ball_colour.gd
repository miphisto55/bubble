class_name BallColour
extends Resource

@export var BALL_COLOUR: Enums.BALL_COLOUR

var colour_map: Dictionary = {
	"ORANGE" = Plane(0.94,0.52,0.27,1.0),
	"YELLOW" = Plane(0.97,0.81,0.31,1.0),
	"GREEN" = Plane(0.44,0.97,0.31,1.0),
	"SKY_BLUE" = Plane(0.31,0.87,0.97,1.0),
	"DEEP_BLUE" = Plane(0.23,0.27,0.80,1.0),
	"DEEP_PURPLE" = Plane(0.53,0.22,0.76,1.0),
	"PINK" = Plane(0.89,0.43,0.90,1.0),
	"RED" = Plane(0.91,0.33,0.33,1.0),
}

func get_colour():
	match BALL_COLOUR:
		Enums.BALL_COLOUR.ORANGE:
			return colour_map[0]
		Enums.BALL_COLOUR.YELLOW:
			return colour_map[1]
		Enums.BALL_COLOUR.GREEN:
			return colour_map[2]
		Enums.BALL_COLOUR.SKY_BLUE:
			return colour_map[3]
		Enums.BALL_COLOUR.DEEP_BLUE:
			return colour_map[4]
		Enums.BALL_COLOUR.DEEP_PURPLE:
			return colour_map[5]
		Enums.BALL_COLOUR.PINK:
			return colour_map[6]
		Enums.BALL_COLOUR.RED:
			return colour_map[7]
