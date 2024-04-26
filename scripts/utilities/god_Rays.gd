extends TextureRect

var time = 1.0
var falloff = 1.0
var edge_fade = 0.3

func _process(delta):
	time += delta
	var sin_time = (sin(time) * 0.2) / 0.2
	var cos_time = (cos(time) * 1.5) / 1.5
	
	if sin_time < 0:
		sin_time *= -1
	if cos_time < 0:
		cos_time *= -1
		
	falloff = lerp(0.35, 1.0, sin_time)
	edge_fade = lerp(0.4,0.6, cos_time)
	material.set_shader_parameter("elapsed", time * 5)
	material.set_shader_parameter("falloff", falloff)
	material.set_shader_parameter("edge_fade", edge_fade)
	
