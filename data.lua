local dummy_sound_filename = "__core__/sound/achievement-unlocked.ogg"
local dummy_sprite_filename = "__core__/graphics/empty.png"
local dummy_render_layer = "object"

-- TODO Bilka: idk where to put this
local function add_dummy_icon(prototype)
  prototype.icon = dummy_sprite_filename
  prototype.icon_size = 1
  return prototype
end

-- common properties
local function dummy_color() return {1, 1, 1, 1} end -- white
local function dummy_bounding_box() return {{0, 0}, {0, 0}} end
local function dummy_vector() return {0, 0} end
local function dummy_sound()
  return { filename = dummy_sound_filename }
end
local function dummy_sprite()
  return
  {
    filename = dummy_sprite_filename,
    size = 1
  }
end
local function dummy_rotated_sprite()
  local sprite = dummy_sprite()
  sprite.direction_count = 1
  return sprite
end
local function dummy_8_way_sprite()
  return
  {
    north = dummy_sprite(),
    north_east = dummy_sprite(),
    east = dummy_sprite(),
    south_east = dummy_sprite(),
    south = dummy_sprite(),
    south_west = dummy_sprite(),
    west = dummy_sprite(),
    north_west = dummy_sprite()
  }
end
local function dummy_animation()
  local sprite = dummy_sprite()
  sprite.frame_count = 1
  return sprite
end
local function dummy_rotated_animation()
  local animation = dummy_animation()
  animation.direction_count = 1
  return animation
end
local function dummy_attack_parameters()
  return
  {
    type = "beam",
    ammo_type = -- may be redundant -- TODO Bilka: Check if this is actually the case
    {
      category = "dummy-ammo-category"
    },
    range = 1,
    cooldown = 1
  }
end
local function dummy_rail_piece_layers()
  return
  {
    metals = dummy_sprite(),
    backplates = dummy_sprite(),
    ties = dummy_sprite(),
    stone_path = dummy_sprite()
  }
end
local function dummy_oriented_cliff_prototype()
  return
  {
    collision_bounding_box = dummy_bounding_box(),
    pictures = { dummy_sprite() },
    fill_volume = 1
  }
end
local function dummy_electric_input_energy_source()
  return
    {
      type = "electric",
      buffer_capacity = "1J",
      input_flow_limit = "1W",
      usage_priority = "primary-input"
    }
end
local function dummy_void_energy_source()
  return { type = "void" }
end
local function dummy_burner_energy_source()
  return { type = "burner", fuel_inventory_size = 1}
end
local function dummy_wire_connection_point()
  return
  {
    wire = {},
    shadow = {}
  }
end

-- common base prototypes
-- items
local function add_item_properties(prototype)
  prototype = add_dummy_icon(prototype)
  prototype.stack_size = 1
  return prototype
end
local function add_selection_tool_properties(prototype)
  prototype = add_item_properties(prototype)
  prototype.selection_color = dummy_color()
  prototype.alt_selection_color = dummy_color()
  prototype.selection_mode = "nothing"
  prototype.alt_selection_mode = "nothing"
  prototype.selection_cursor_box_type = "entity"
  prototype.alt_selection_cursor_box_type = "entity"
  return prototype
end
-- entities
local function add_combinator_properties(prototype)
  prototype.energy_source = dummy_void_energy_source()
  prototype.active_energy_usage = "1J"
  prototype.sprites = dummy_sprite()
  prototype.activity_led_sprites = dummy_sprite()
  prototype.input_connection_bounding_box = dummy_bounding_box()
  prototype.output_connection_bounding_box = dummy_bounding_box()
  prototype.activity_led_light_offsets =
  {
    dummy_vector(),
    dummy_vector(),
    dummy_vector(),
    dummy_vector()
  }
  prototype.screen_light_offsets =
  {
    dummy_vector(),
    dummy_vector(),
    dummy_vector(),
    dummy_vector()
  }
  prototype.input_connection_points =
  {
    dummy_wire_connection_point(),
    dummy_wire_connection_point(),
    dummy_wire_connection_point(),
    dummy_wire_connection_point()
  }
  prototype.output_connection_points =
  {
    dummy_wire_connection_point(),
    dummy_wire_connection_point(),
    dummy_wire_connection_point(),
    dummy_wire_connection_point()
  }
  return prototype
end
local function add_vehicle_properties(prototype)
  prototype.braking_force = 1
  prototype.energy_per_hit_point = 1
  prototype.friction_force = 1
  prototype.weight = 1
  return prototype
end
local function add_rolling_stock_properties(prototype)
  prototype = add_vehicle_properties(prototype)
  prototype.air_resistance = 1

  -- copied from vanilla because these values are finicky
  prototype.collision_box = {{-0.6, -2.4}, {0.6, 2.4}}
  prototype.connection_distance = 3
  prototype.joint_distance = 4

  prototype.max_speed = 1
  prototype.pictures = dummy_rotated_sprite()
  prototype.vertical_selection_shift = 1
  return prototype
end

data:extend(
{
  {
    -- copied from vanila
    type="map-settings",
    name="map-settings",

    pollution=
    {
      enabled=true,
      diffusion_ratio=0.02,
      min_to_diffuse=15,
      ageing=1,
      expected_max_per_chunk=150,
      min_to_show_per_chunk=50,
      min_pollution_to_damage_trees = 60,
      pollution_with_max_forest_damage = 150,
      pollution_per_tree_damage = 50,
      pollution_restored_per_tree_damage = 10,
      max_pollution_to_restore_trees = 20,
      enemy_attack_pollution_consumption_modifier = 1
    },

    enemy_evolution=
    {
      enabled=true,
      time_factor = 0.000004,
      destroy_factor = 0.002,
      pollution_factor = 0.0000009
    },

    enemy_expansion=
    {
      enabled = true,
      max_expansion_distance = 7,
      friendly_base_influence_radius = 2,
      enemy_building_influence_radius = 2,
      building_coefficient = 0.1,
      other_base_coefficient = 2.0,
      neighbouring_chunk_coefficient = 0.5,
      neighbouring_base_chunk_coefficient = 0.4;
      max_colliding_tiles_coefficient = 0.9,
      settler_group_min_size = 5,
      settler_group_max_size = 20,
      min_expansion_cooldown = 4 * 3600,
      max_expansion_cooldown = 60 * 3600
    },

    unit_group=
    {
      min_group_gathering_time = 3600,
      max_group_gathering_time = 10 * 3600,
      max_wait_time_for_late_members = 2 * 3600,
      max_group_radius = 30.0,
      min_group_radius = 5.0,
      max_member_speedup_when_behind = 1.4,
      max_member_slowdown_when_ahead = 0.6,
      max_group_slowdown_factor = 0.3,
      max_group_member_fallback_factor = 3,
      member_disown_distance = 10,
      tick_tolerance_when_member_arrives = 60,
      max_gathering_unit_groups = 30,
      max_unit_group_size = 200
    },

    steering=
    {
      default=
      {
        radius = 1.2,
        separation_force = 0.005,
        separation_factor = 1.2,
        force_unit_fuzzy_goto_behavior = false
      },
      moving=
      {
        radius = 3,
        separation_force = 0.01,
        separation_factor = 3,

        force_unit_fuzzy_goto_behavior = false
      }
    },

    path_finder=
    {
      fwd2bwd_ratio = 5,
      goal_pressure_ratio = 2,
      max_steps_worked_per_tick = 1000,
      max_work_done_per_tick = 8000,
      use_path_cache = true,
      short_cache_size = 5,
      long_cache_size = 25,
      short_cache_min_cacheable_distance = 10,
      short_cache_min_algo_steps_to_cache = 50,
      long_cache_min_cacheable_distance = 30,
      cache_max_connect_to_cache_steps_multiplier = 100,
      cache_accept_path_start_distance_ratio = 0.2,
      cache_accept_path_end_distance_ratio = 0.15,
      negative_cache_accept_path_start_distance_ratio = 0.3,
      negative_cache_accept_path_end_distance_ratio = 0.3,
      cache_path_start_distance_rating_multiplier = 10,
      cache_path_end_distance_rating_multiplier = 20,
      stale_enemy_with_same_destination_collision_penalty = 30,
      ignore_moving_enemy_collision_distance = 5,
      enemy_with_different_destination_collision_penalty = 30,
      general_entity_collision_penalty = 10,
      general_entity_subsequent_collision_penalty = 3,
      extended_collision_penalty = 3,
      max_clients_to_accept_any_new_request = 10,
      max_clients_to_accept_short_new_request = 100,
      direct_distance_to_consider_short_request = 100,
      short_request_max_steps = 1000,
      short_request_ratio = 0.5,
      min_steps_to_check_path_find_termination = 2000,
      start_to_goal_cost_multiplier_to_terminate_path_find = 2000.0,
      overload_levels = {0, 100, 500},
      overload_multipliers = {2, 3, 4}
    },

    max_failed_behavior_count = 3,

    difficulty_settings =
    {
       recipe_difficulty = defines.difficulty_settings.recipe_difficulty.normal,
       technology_difficulty = defines.difficulty_settings.technology_difficulty.normal,
       technology_price_multiplier = 1,
       research_queue_setting = "after-victory"
    }
  },

  -- default categories
  {
    type = "recipe-category",
    name = "crafting"
  },
  {
    type = "resource-category",
    name = "basic-solid"
  },
  {
    type = "fuel-category",
    name = "chemical"
  },

  -- stuff needed for core prototypes
  add_dummy_icon
  {
    type = "item-group",
    name = "dummy-item-group"
  },

  -- core prototypes
  {
    type = "item-subgroup",
    name = "other",
    group = "dummy-item-group"
  },
  add_selection_tool_properties
  {
    type = "copy-paste-tool",
    name = "cut-paste-tool"
  },

  -- stuff needed for prototypes
  {
    type = "ammo-category",
    name = "dummy-ammo-category"
  },
  {
    type = "equipment-category",
    name = "dummy-equipment-category"
  },
  { -- TODO move down to normal prototypes ?
    type = "active-defense-equipment",
    name = "dummy-active-defense-equipment",
    sprite = dummy_sprite(),
    shape = {
      type = "full",
      width = 1,
      height = 1
    },
    energy_source = dummy_electric_input_energy_source(),
    categories = {"dummy-equipment-category"},
    automatic = false,
    ability_icon = dummy_sprite(),
    attack_parameters = dummy_attack_parameters(),
    take_result = "dummy-item"
  },
  {
    type = "module-category",
    name = "dummy-module-category"
  },
  add_dummy_icon -- TODO move down to normal prototypes
  {
    type = "straight-rail",
    name = "dummy-straight-rail",
    pictures =
    {
      straight_rail_horizontal = dummy_rail_piece_layers(),
      straight_rail_vertical = dummy_rail_piece_layers(),
      straight_rail_diagonal_left_top = dummy_rail_piece_layers(),
      straight_rail_diagonal_right_top = dummy_rail_piece_layers(),
      straight_rail_diagonal_right_bottom = dummy_rail_piece_layers(),
      straight_rail_diagonal_left_bottom = dummy_rail_piece_layers(),
      curved_rail_vertical_left_top = dummy_rail_piece_layers(),
      curved_rail_vertical_right_top = dummy_rail_piece_layers(),
      curved_rail_vertical_right_bottom = dummy_rail_piece_layers(),
      curved_rail_vertical_left_bottom = dummy_rail_piece_layers(),
      curved_rail_horizontal_left_top = dummy_rail_piece_layers(),
      curved_rail_horizontal_right_top = dummy_rail_piece_layers(),
      curved_rail_horizontal_right_bottom = dummy_rail_piece_layers(),
      curved_rail_horizontal_left_bottom = dummy_rail_piece_layers(),
      rail_endings = dummy_8_way_sprite()
    }
  },
  add_dummy_icon -- TODO move down to normal prototypes
  {
    type = "curved-rail",
    name = "dummy-curved-rail",
    pictures =
    {
      straight_rail_horizontal = dummy_rail_piece_layers(),
      straight_rail_vertical = dummy_rail_piece_layers(),
      straight_rail_diagonal_left_top = dummy_rail_piece_layers(),
      straight_rail_diagonal_right_top = dummy_rail_piece_layers(),
      straight_rail_diagonal_right_bottom = dummy_rail_piece_layers(),
      straight_rail_diagonal_left_bottom = dummy_rail_piece_layers(),
      curved_rail_vertical_left_top = dummy_rail_piece_layers(),
      curved_rail_vertical_right_top = dummy_rail_piece_layers(),
      curved_rail_vertical_right_bottom = dummy_rail_piece_layers(),
      curved_rail_vertical_left_bottom = dummy_rail_piece_layers(),
      curved_rail_horizontal_left_top = dummy_rail_piece_layers(),
      curved_rail_horizontal_right_top = dummy_rail_piece_layers(),
      curved_rail_horizontal_right_bottom = dummy_rail_piece_layers(),
      curved_rail_horizontal_left_bottom = dummy_rail_piece_layers(),
      rail_endings = dummy_8_way_sprite()
    }
  },

  -- the prototypes
  -- items
  add_item_properties
  {
    type = "ammo",
    name = "dummy-ammo",
    ammo_type =
    {
      category = "dummy-ammo-category"
    }
  },
  add_item_properties
  {
    type = "armor",
    name = "dummy-armor",
    infinite = true
  },
  add_selection_tool_properties
  {
    type = "blueprint",
    name = "blueprint" -- also a core prototype
  },
  add_item_properties
  {
    type = "blueprint-book",
    name = "dummy-blueprint-book",
    inventory_size = 1
  },
  add_item_properties
  {
    type = "capsule",
    name = "dummy-capsule",
    capsule_action =
    {
      type = "equipment-remote", -- seems the simplest
      equipment = "dummy-active-defense-equipment"
    }
  },
  add_selection_tool_properties
  {
    type = "copy-paste-tool",
    name = "copy-paste-tool" -- also a core prototype
  },
  add_selection_tool_properties
  {
    type = "deconstruction-item",
    name = "dummy-deconstruction-item"
  },
  add_item_properties
  {
    type = "gun",
    name = "dummy-gun",
    attack_parameters = dummy_attack_parameters()
  },
  add_item_properties
  {
    type = "item",
    name = "dummy-item"
  },
  add_item_properties
  {
    type = "item-with-entity-data",
    name = "dummy-item-with-entity-data"
  },
  add_item_properties
  {
    type = "item-with-inventory",
    name = "dummy-item-with-inventory",
    inventory_size = 1
  },
  add_item_properties
  {
    type = "item-with-label",
    name = "dummy-item-with-label"
  },
  add_item_properties
  {
    type = "item-with-tags",
    name = "dummy-item-with-tags"
  },
  add_item_properties
  {
    type = "mining-tool", -- deprecated prototype
    name = "dummy-mining-tool",
    infinite = true
  },
  add_item_properties
  {
    type = "module",
    name = "dummy-module",
    tier = 1,
    effect = {},
    category = "dummy-module-category"
  },
  add_item_properties
  {
    type = "rail-planner",
    name = "dummy-rail-planner",
    straight_rail = "dummy-straight-rail",
    curved_rail = "dummy-curved-rail"
  },
  add_item_properties
  {
    type = "repair-tool",
    name = "dummy-repair-tool",
    infinite = true,
    speed = 1
  },
  add_selection_tool_properties
  {
    type = "selection-tool",
    name = "dummy-selection-tool"
  },
  add_item_properties
  {
    type = "tool",
    name = "dummy-tool",
    infinite = true
  },
  add_selection_tool_properties
  {
    type = "upgrade-item",
    name = "dummy-upgrade-item"
  },
  -- entities
  {
    type = "accumulator",
    name = "dummy-accumulator",
    energy_source = dummy_electric_input_energy_source(),
    picture = dummy_sprite(),
    charge_cooldown = 1,
    discharge_cooldown = 1
  },
  {
    type = "ammo-turret",
    name = "dummy-ammo-turret",
    call_for_help_radius = 1,
    attack_parameters = dummy_attack_parameters(),
    folded_animation = dummy_rotated_animation(),
    automated_ammo_count = 1,
    inventory_size = 1
  },
  add_combinator_properties
  {
    type = "arithmetic-combinator",
    name = "dummy-arithmetic-combinator",
    plus_symbol_sprites = dummy_sprite(),
    minus_symbol_sprites = dummy_sprite(),
    multiply_symbol_sprites = dummy_sprite(),
    divide_symbol_sprites = dummy_sprite(),
    modulo_symbol_sprites = dummy_sprite(),
    power_symbol_sprites = dummy_sprite(),
    left_shift_symbol_sprites = dummy_sprite(),
    right_shift_symbol_sprites = dummy_sprite(),
    and_symbol_sprites = dummy_sprite(),
    or_symbol_sprites = dummy_sprite(),
    xor_symbol_sprites = dummy_sprite()
  },
  {
    type = "arrow",
    name = "dummy-arrow",
    arrow_picture = dummy_sprite()
  },
  {
    type = "artillery-flare",
    name = "dummy-artillery-flare",
    life_time = 1,
    pictures = {dummy_animation()},
    render_layer = dummy_render_layer,
    render_layer_when_on_ground = dummy_render_layer,
    map_color = dummy_color()
  },
  {
    type = "artillery-projectile",
    name = "dummy-artillery-projectile",
    reveal_map = true,
    map_color = dummy_color()
  },
  {
    type = "artillery-turret",
    name = "dummy-artillery-turret",
    ammo_stack_limit = 1,
    automated_ammo_count = 1,
    gun = "dummy-gun",
    inventory_size = 1,
    manual_range_modifier = 1,
    turret_rotation_speed = 1
  },
  add_rolling_stock_properties
  {
    type = "artillery-wagon",
    name = "dummy-artillery-wagon",
    ammo_stack_limit = 1,
    gun = "dummy-gun",
    inventory_size = 1,
    manual_range_modifier = 1,
    turret_rotation_speed = 1
  },
  {
    type = "assembling-machine",
    name = "dummy-assembling-machine",
    energy_usage = "1J",
    energy_source = dummy_void_energy_source(),
    crafting_speed = 1,
    crafting_categories = {"crafting"}
  },
  {
    type = "beacon",
    name = "dummy-beacon",
    animation = dummy_animation(),
    animation_shadow = dummy_animation(),
    base_picture = dummy_sprite(),
    distribution_effectivity = 1,
    energy_source = dummy_void_energy_source(),
    energy_usage = "1J",
    module_specification = {},
    supply_area_distance = 1
  },
  {
    type = "beam",
    name = "dummy-beam",
    body = {dummy_animation()},
    damage_interval = 1,
    head = dummy_animation(),
    tail = dummy_animation(),
    width = 1
  },
  {
    type = "boiler",
    name = "dummy-boiler",
    burning_cooldown = 1,
    energy_consumption = "1J",
    energy_source = dummy_void_energy_source(),

    -- copied from vanilla because these values are finicky
    collision_box = {{-1.29, -0.79}, {1.29, 0.79}},
    fluid_box = {
      pipe_connections =
      {
        {
          position = {-2, 0.5}
        }
      }
    },
    output_fluid_box = {
      pipe_connections =
      {
        {
          position = {0, -1.5}
        }
      }
    },

    target_temperature = 1,
    structure =
    {
      north = dummy_sprite(),
      east = dummy_sprite(),
      south = dummy_sprite(),
      west = dummy_sprite(),
    },
    fire = {},
    fire_glow = {},
  },
  {
    type = "burner-generator",
    name = "dummy-burner-generator",
    animation = dummy_animation(),
    burner = dummy_burner_energy_source(),
    energy_source = dummy_electric_input_energy_source(), -- HACK
    max_power_output = "1J"
  },
  add_vehicle_properties
  {
    type = "car",
    name = "dummy-car",
    animation = dummy_rotated_animation(),
    energy_source = dummy_void_energy_source(),
    consumption = "1J",
    effectivity = 1,
    inventory_size = 1,
    rotation_speed = 1
  },
  add_rolling_stock_properties
  {
    type = "cargo-wagon",
    name = "dummy-cargo-wagon",
    inventory_size = 1
  },
  {
    type = "character",
    name = "character", -- also a core prototype
    mining_speed = 1,
    running_speed = 1,
    distance_per_frame = 1,
    maximum_corner_sliding_distance = 1,
    heartbeat = dummy_sound(),
    eat = dummy_sound(),
    inventory_size = 1,
    build_distance = 1,
    drop_item_distance = 1,
    reach_distance = 1,
    reach_resource_distance = 1,
    item_pickup_distance = 1,
    loot_pickup_distance = 1,
    ticks_to_keep_gun = 1,
    ticks_to_keep_aiming_direction = 1,
    ticks_to_stay_in_combat = 1,
    ticks_to_stay_in_combat = 1,
    damage_hit_tint = dummy_color(),
    running_sound_animation_positions = {},
    mining_with_tool_particles_animation_positions = {},
    animations =
    {
      {
        idle = dummy_rotated_animation(),
        idle_with_gun = dummy_rotated_animation(),
        running = dummy_rotated_animation(),
        running_with_gun = (function() local a = dummy_rotated_animation(); a.direction_count = 18; return a; end)(), -- HACK
        mining_with_tool = dummy_rotated_animation()
      }
    }
  },
  {
    type = "character-corpse",
    name = "dummy-character-corpse",
    time_to_live = 1,
    picture = dummy_animation()
  },
  {
    type = "cliff",
    name = "dummy-cliff",
    grid_offset = dummy_vector(),
    grid_size = dummy_vector(),
    orientations =  {
      west_to_east = dummy_oriented_cliff_prototype(),
      north_to_south = dummy_oriented_cliff_prototype(),
      east_to_west = dummy_oriented_cliff_prototype(),
      south_to_north = dummy_oriented_cliff_prototype(),
      west_to_north = dummy_oriented_cliff_prototype(),
      north_to_east = dummy_oriented_cliff_prototype(),
      east_to_south = dummy_oriented_cliff_prototype(),
      south_to_west = dummy_oriented_cliff_prototype(),
      west_to_south = dummy_oriented_cliff_prototype(),
      north_to_west = dummy_oriented_cliff_prototype(),
      east_to_north = dummy_oriented_cliff_prototype(),
      south_to_east = dummy_oriented_cliff_prototype(),
      west_to_none = dummy_oriented_cliff_prototype(),
      none_to_east = dummy_oriented_cliff_prototype(),
      north_to_none = dummy_oriented_cliff_prototype(),
      none_to_south = dummy_oriented_cliff_prototype(),
      east_to_none = dummy_oriented_cliff_prototype(),
      none_to_west = dummy_oriented_cliff_prototype(),
      south_to_none = dummy_oriented_cliff_prototype(),
      none_to_north = dummy_oriented_cliff_prototype()
    }
  },
  {
    type = "combat-robot",
    name = "dummy-combat-robot",
    speed = 1,
    attack_parameters = dummy_attack_parameters(),
    idle = dummy_rotated_animation(),
    in_motion = dummy_rotated_animation(),
    shadow_idle = dummy_rotated_animation(),
    shadow_in_motion = dummy_rotated_animation(),
    time_to_live = 1
  },
  {
    type = "constant-combinator",
    name = "dummy-constant-combinator",
    item_slot_count = 1,
    sprites = dummy_sprite(),
    activity_led_sprites = dummy_sprite(),
    activity_led_light_offsets =
    {
      dummy_vector(),
      dummy_vector(),
      dummy_vector(),
      dummy_vector()
    },
    circuit_wire_connection_points =
    {
      dummy_wire_connection_point(),
      dummy_wire_connection_point(),
      dummy_wire_connection_point(),
      dummy_wire_connection_point()
    }
  },
  {
    type = "construction-robot",
    name = "dummy-construction-robot",
    speed = 1,
    max_payload_size = 1,
    cargo_centered = dummy_vector(),
    construction_vector = dummy_vector()
  },
  {
    type = "container",
    name = "dummy-container",
    inventory_size = 1,
    picture = dummy_sprite()
  },
  {
    type = "corpse",
    name = "dummy-corpse"
  },

})

