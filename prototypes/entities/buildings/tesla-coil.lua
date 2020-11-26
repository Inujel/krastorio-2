local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds      = require("__base__/prototypes/entity/sounds")

-- Entity sound
local tesla_coil_sound =
{	
	filename = kr_buildings_sounds_path .. "tesla-coil.ogg",
	volume = 0.75,
	aggregation =
	{
		max_count = 2,
		remove = false,
		count_already_playing = true
	}
}

-- Beam sound
local tesla_coil_electric_beam_sound =
{
	variations = 
	{
		{
			filename = kr_others_sounds_path .. "zap-1.ogg",
			volume = 0.5
		},
		{
			filename = kr_others_sounds_path .. "zap-2.ogg",
			volume = 0.5
		},
		{
			filename = kr_others_sounds_path .. "zap-3.ogg",
			volume = 0.5
		}
	},		
	audible_distance_modifier = 2.0,
	aggregation =
	{
		max_count             = 2,
		remove                = true,
		count_already_playing = true
	}
}

-- Beam config vars
local light_tint           = {r=0, g=0.917, b=1}
local beam_blend_mode      = "additive-soft"
local beam_non_light_flags = { "trilinear-filtering" }

data:extend(
{   
	-- Tesla coil tower
	{
		type = "electric-energy-interface",
		name = "kr-tesla-coil",
		icon = kr_entities_icons_path .. "tesla-coil.png",
		icon_size = 64,
		flags = {"placeable-neutral", "player-creation", "not-rotatable"},
		minable = {mining_time = 0.25, result = "kr-tesla-coil"},
		max_health = 200,
		gui_mode = "none",
		corpse = "medium-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 30
			},
			{
				type = "physical",
				percent = 60
			},
			{
				type = "impact",
				percent = 30
			}
		},
		fast_replaceable_group = "tesla-coil",
		damaged_trigger_effect = hit_effects.entity(),
		collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
		selection_box = {{-1.45, -1.45}, {1.45, 1.45}},
		drawing_box = {{-0.5, -2}, {0.5, 1}},
		energy_source =
		{
			type = "electric",
			buffer_capacity = "60MJ",
			emissions_per_minute = 10,
			usage_priority = "secondary-input",
			input_flow_limit = "30MW",
			output_flow_limit = "0W"
		},
		
		energy_usage = "6MW",
		
		animation =
		{
			layers =
			{
				{
					filename = kr_entities_path .. "tesla-coil/tesla-coil-animation-light.png",
					priority = "high",
					width = 97,
					height = 116,
					frame_count = 60,
					line_length = 10,
					animation_speed = 0.000003,
					run_mode = "forward",
					draw_as_light = true,
					blend_mode = "additive-soft",
					hr_version =
					{
						filename = kr_entities_path .. "tesla-coil/hr-tesla-coil-animation-light.png",
						priority = "high",
						width = 194,
						height = 232,
						scale = 0.5,
						frame_count = 60,
						line_length = 10,
						animation_speed = 0.000003,
						run_mode = "forward",
						shift = {0, -0.75},
						draw_as_light = true,
						blend_mode = "additive-soft"
					}
				},
				{
					filename = kr_entities_path .. "tesla-coil/tesla-coil-animation.png",
					priority = "high",
					width = 97,
					height = 116,
					frame_count = 60,
					line_length = 10,
					animation_speed = 0.000003,
					run_mode = "forward",
					hr_version =
					{
						filename = kr_entities_path .. "tesla-coil/hr-tesla-coil-animation.png",
						priority = "high",
						width = 194,
						height = 232,
						scale = 0.5,
						frame_count = 60,
						line_length = 10,
						animation_speed = 0.000003,
						run_mode = "forward",
						shift = {0, -0.75},
					}
				},
				{
					filename = kr_entities_path .. "tesla-coil/tesla-coil-shadow.png",
					priority = "medium",
					width = 125,
					height = 75,
					repeat_count = 60,
					frame_count = 1,
					animation_speed = 0.000003,
					draw_as_shadow = true,
					hr_version =
					{
						filename = kr_entities_path .. "tesla-coil/hr-tesla-coil-shadow.png",
						priority = "medium",
						width = 250,
						height = 150,
						scale = 0.5,
						repeat_count = 60,
						frame_count = 1,
						animation_speed = 0.000003,
						shift = {0.37, -0.01},
						draw_as_shadow = true
					}
				}
			}
		},
		
		vehicle_impact_sound = sounds.generic_impact,
		working_sound =
		{
			sound = tesla_coil_sound,
			persistent = false
		}
	},
	-- Beam
	{
		type = "beam",
		name = "kr-tesla-coil-electric-beam",
		flags = {"not-on-map"},
		width = 0.5,
		damage_interval = 20,
		random_target_offset = true,
		action_triggered_automatically = false,
		working_sound = tesla_coil_electric_beam_sound,
		
		-- Graphics
		start =
		{
			filename = "__base__/graphics/entity/beam/tileable-beam-START.png",
			flags = beam_flags or beam_non_light_flags,
			line_length = 4,
			width = 52,
			height = 40,
			frame_count = 16,
			direction_count = 1,
			shift = {-0.03125, 0},
			tint = beam_tint,
			hr_version =
			{
				filename = "__base__/graphics/entity/beam/hr-tileable-beam-START.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 4,
				width = 94,
				height = 66,
				frame_count = 16,
				direction_count = 1,
				shift = {0.53125, 0},
				tint = beam_tint,
				scale = 0.5
			}
		},

		ending =
		{
			filename = "__base__/graphics/entity/beam/tileable-beam-END.png",
			flags = beam_flags or beam_non_light_flags,
			line_length = 4,
			width = 49,
			height = 54,
			frame_count = 16,
			direction_count = 1,
			shift = {-0.046875, 0},
			tint = beam_tint,
			hr_version =
			{
				filename = "__base__/graphics/entity/beam/hr-tileable-beam-END.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 4,
				width = 91,
				height = 93,
				frame_count = 16,
				direction_count = 1,
				shift = {-0.078125, -0.046875},
				tint = beam_tint,
				scale = 0.5
			}
		},

		head =
		{
			filename = "__base__/graphics/entity/beam/beam-head.png",
			flags = beam_flags or beam_non_light_flags,
			line_length = 16,
			width = 45 - 7,
			height = 39,
			frame_count = 16,
			shift = util.by_pixel(-7/2, 0),
			tint = beam_tint,
			blend_mode = blend_mode or beam_blend_mode
		},

		tail =
		{
			filename = "__base__/graphics/entity/beam/beam-tail.png",
			flags = beam_flags or beam_non_light_flags,
			line_length = 16,
			width = 45 - 6,
			height = 39,
			frame_count = 16,
			shift = util.by_pixel(6/2, 0),
			tint = beam_tint,
			blend_mode = blend_mode or beam_blend_mode
		},

		body =
		{
			{
				filename = "__base__/graphics/entity/beam/beam-body-1.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 16,
				width = 32,
				height = 39,
				frame_count = 16,
				tint = beam_tint,
				blend_mode = blend_mode or beam_blend_mode
			},
			{
				filename = "__base__/graphics/entity/beam/beam-body-2.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 16,
				width = 32,
				height = 39,
				frame_count = 16,
				blend_mode = blend_mode or beam_blend_mode
			},
			{
				filename = "__base__/graphics/entity/beam/beam-body-3.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 16,
				width = 32,
				height = 39,
				frame_count = 16,
				blend_mode = blend_mode or beam_blend_mode
			},
			{
				filename = "__base__/graphics/entity/beam/beam-body-4.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 16,
				width = 32,
				height = 39,
				frame_count = 16,
				blend_mode = blend_mode or beam_blend_mode
			},
			{
				filename = "__base__/graphics/entity/beam/beam-body-5.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 16,
				width = 32,
				height = 39,
				frame_count = 16,
				blend_mode = blend_mode or beam_blend_mode
			},
			{
				filename = "__base__/graphics/entity/beam/beam-body-6.png",
				flags = beam_flags or beam_non_light_flags,
				line_length = 16,
				width = 32,
				height = 39,
				frame_count = 16,
				blend_mode = blend_mode or beam_blend_mode
			}
		},

		light_animations =
		{
			start =
			{
				filename = "__base__/graphics/entity/beam/hr-tileable-beam-START-light.png",
				line_length = 4,
				width = 94,
				height = 66,
				frame_count = 16,
				direction_count = 1,
				shift = {0.53125, 0},
				scale = 0.5,
				tint = light_tint
			},

			ending =
			{
				filename = "__base__/graphics/entity/beam/hr-tileable-beam-END-light.png",
				line_length = 4,
				width = 91,
				height = 93,
				frame_count = 16,
				direction_count = 1,
				shift = {-0.078125, -0.046875},
				scale = 0.5,
				tint = light_tint
			},

			head =
			{
				filename = "__base__/graphics/entity/beam/beam-head-light.png",
				line_length = 16,
				width = 45 - 7,
				height = 39,
				frame_count = 16,
				shift = util.by_pixel(-7/2, 0),
				tint = light_tint
			},

			tail =
			{
				filename = "__base__/graphics/entity/beam/beam-tail-light.png",
				line_length = 16,
				width = 45 - 6,
				height = 39,
				shift = util.by_pixel(6/2, 0),
				frame_count = 16,
				tint = light_tint
			},

			body =
			{
				{
					filename = "__base__/graphics/entity/beam/beam-body-1-light.png",
					line_length = 16,
					width = 32,
					height = 39,
					frame_count = 16,
					tint = light_tint
				},
				{
					filename = "__base__/graphics/entity/beam/beam-body-2-light.png",
					line_length = 16,
					width = 32,
					height = 39,
					frame_count = 16,
					tint = light_tint
				},
				{
					filename = "__base__/graphics/entity/beam/beam-body-3-light.png",
					line_length = 16,
					width = 32,
					height = 39,
					frame_count = 16,
					tint = light_tint
				},
				{
					filename = "__base__/graphics/entity/beam/beam-body-4-light.png",
					line_length = 16,
					width = 32,
					height = 39,
					frame_count = 16,
					tint = light_tint
				},
				{
					filename = "__base__/graphics/entity/beam/beam-body-5-light.png",
					line_length = 16,
					width = 32,
					height = 39,
					frame_count = 16,
					tint = light_tint
				},
				{
					filename = "__base__/graphics/entity/beam/beam-body-6-light.png",
					line_length = 16,
					width = 32,
					height = 39,
					frame_count = 16,
					tint = light_tint
				}
			}
		}
	}
})