local dummy_sound_filename = "__core__/sound/achievement-unlocked.ogg"
local dummy_sprite_filename = "__core__/graphics/empty.png"
local dummy_32px_sprite_filename = "__core__/graphics/bonus-icon.png"
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
local function dummy_nonzero_bounding_box() return {{-1.0, -0.5}, {0.1, 0.1}} end -- splitter: bounding box width must be > 0.5, height must be > 1
local function dummy_vector() return {0, 0} end
local function dummy_sound()
  return {filename = dummy_sound_filename}
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
local function dummy_rotated_sprite_custom_direction_count(direction_count)
  -- HACK
  local sprite = dummy_sprite()
  sprite.filename = dummy_32px_sprite_filename
  sprite.direction_count = direction_count
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
  return dummy_sprite()
end
local function dummy_rotated_animation()
  local animation = dummy_animation()
  animation.direction_count = 1
  return animation
end
local function dummy_attack_parameters()
  return
  {
    type = "stream", -- required by fluid turret
    ammo_type = -- may be redundant -- TODO Bilka: Check if this is actually the case
    {
      category = "dummy-ammo-category"
    },
    range = 1,
    cooldown = 1,
    animation = dummy_rotated_animation() -- required by unit
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
local function dummy_rail_pictures()
  return
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
end
local function dummy_oriented_cliff_prototype()
  return
  {
    collision_bounding_box = dummy_bounding_box(),
    pictures = {dummy_sprite()},
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
  return {type = "void"}
end
local function dummy_burner_energy_source()
  return {type = "burner", fuel_inventory_size = 1}
end
local function dummy_wire_connection_point()
  return
  {
    wire = {},
    shadow = {}
  }
end
local function dummy_damage_prototype()
  return {amount = 1, type = "physical"}
end
local function dummy_fluid_box()
  return {pipe_connections = {}}
end
local function dummy_heat_buffer()
  return
  {
    max_temperature = 15, -- because default defaults to 15 and this must be >= default
    specific_heat = "1J",
    max_transfer = "1J"
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
local function add_turret_properties(prototype)
  prototype.call_for_help_radius = 1
  prototype.attack_parameters = dummy_attack_parameters()
  prototype.folded_animation = dummy_rotated_animation()
  return prototype
end
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
local function add_pipe_properties(prototype)
  prototype.horizontal_window_bounding_box = dummy_bounding_box()
  prototype.vertical_window_bounding_box = dummy_bounding_box()
  prototype.fluid_box = dummy_fluid_box()
  prototype.pictures =
  {
    straight_vertical_single = dummy_sprite(),
    straight_vertical = dummy_sprite(),
    straight_vertical_window = dummy_sprite(),
    straight_horizontal = dummy_sprite(),
    straight_horizontal_window = dummy_sprite(),
    corner_up_right = dummy_sprite(),
    corner_up_left = dummy_sprite(),
    corner_down_right = dummy_sprite(),
    corner_down_left = dummy_sprite(),
    t_up = dummy_sprite(),
    t_down = dummy_sprite(),
    t_right = dummy_sprite(),
    t_left = dummy_sprite(),
    cross = dummy_sprite(),
    ending_up = dummy_sprite(),
    ending_down = dummy_sprite(),
    ending_right = dummy_sprite(),
    ending_left = dummy_sprite(),
    horizontal_window_background = dummy_sprite(),
    vertical_window_background = dummy_sprite(),
    fluid_background = dummy_sprite(),
    low_temperature_flow = dummy_sprite(),
    middle_temperature_flow = dummy_sprite(),
    high_temperature_flow = dummy_sprite(),
    gas_flow = dummy_animation()
  }
  return prototype
end
local function add_transport_belt_connectable_properties(prototype)
  prototype.collision_box = dummy_nonzero_bounding_box()
  prototype.speed = 1
  prototype.belt_animation_set =
  {
    animation_set = dummy_rotated_sprite_custom_direction_count(20)
  }
  return prototype
end
-- equipment
local function add_equipment_properties(prototype)
  prototype.sprite = dummy_sprite()
  prototype.shape = {
    type = "full",
    width = 1,
    height = 1
  }
  prototype.categories = {"dummy-equipment-category"}
  prototype.energy_source = dummy_electric_input_energy_source()
  prototype.take_result = "dummy-item"
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
       -- technology_price_multiplier -- not needed
       -- research_queue_setting -- not needed
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
  {
    type = "module-category",
    name = "dummy-module-category"
  },
  {
    type = "damage-type",
    name = "physical" -- also a core prototype
  },
  add_dummy_icon
  {
    type = "fluid",
    name = "water", -- also a core prototype
    base_color = dummy_color(),
    default_temperature = 1,
    flow_color = dummy_color(),
    max_temperature = 1,
    subgroup = "other"
  },
  {
    type = "optimized-particle",
    name = "dummy-optimized-particle",
    life_time = 2, -- workaround (1 errors)
    pictures = dummy_animation(),
    render_layer = dummy_render_layer,
    render_layer_when_on_ground = dummy_render_layer
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
    type = "mining-tool",
    name = "dummy-mining-tool", -- deprecated prototype
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
  add_turret_properties
  {
    type = "ammo-turret",
    name = "dummy-ammo-turret",
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
    pictures = dummy_animation(),
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
    body = dummy_animation(),
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
    fluid_box = dummy_fluid_box(),
    output_fluid_box = dummy_fluid_box(),
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
        running_with_gun = dummy_rotated_sprite_custom_direction_count(18),
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
    grid_size = {1, 1}, -- must be non-zero vector
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
  {
    type = "curved-rail",
    name = "dummy-curved-rail",
    pictures = dummy_rail_pictures()
  },
  add_combinator_properties
  {
    type = "decider-combinator",
    name = "dummy-decider-combinator",
    equal_symbol_sprites = dummy_sprite(),
    greater_or_equal_symbol_sprites = dummy_sprite(),
    greater_symbol_sprites = dummy_sprite(),
    less_or_equal_symbol_sprites = dummy_sprite(),
    less_symbol_sprites = dummy_sprite(),
    not_equal_symbol_sprites = dummy_sprite()
  },
  {
    type = "deconstructible-tile-proxy",
    name = "deconstructible-tile-proxy" -- also a core prototype
  },
  {
    type = "decorative",
    name = "dummy-decorative" -- deprecated prototype
  },
  {
    type = "electric-energy-interface",
    name = "dummy-electric-energy-interface",
    energy_source = dummy_electric_input_energy_source() -- HACK ?
  },
  {
    type = "electric-pole",
    name = "dummy-electric-pole",
    connection_points = {
      dummy_wire_connection_point()
    },
    pictures = dummy_rotated_sprite(),
    supply_area_distance = 1
  },
  add_turret_properties
  {
    type = "electric-turret",
    name = "dummy-electric-turret",
    energy_source = dummy_void_energy_source()
  },
  {
    type = "entity-ghost",
    name = "dummy-entity-ghost"
  },
  {
    type = "explosion",
    name = "dummy-explosion",
    animations = dummy_animation()
  },
  {
    type = "fire",
    name = "dummy-fire",
    damage_per_tick = dummy_damage_prototype(),
    spread_delay = 1,
    spread_delay_deviation = 1
  },
  {
    type = "fish",
    name = "dummy-fish",
    pictures = dummy_sprite()
  },
  {
    type = "flame-thrower-explosion",
    name = "dummy-flame-thrower-explosion",
    animations = dummy_animation(),
    damage = dummy_damage_prototype(),
    slow_down_factor = 1
  },
  add_turret_properties
  {
    type = "fluid-turret",
    name = "dummy-fluid-turret",
    activation_buffer_ratio = 1,
    fluid_box = dummy_fluid_box(),
    fluid_buffer_input_flow = 1,
    fluid_buffer_size = 1,
    turret_base_has_direction = true
  },
  add_rolling_stock_properties
  {
    type = "fluid-wagon",
    name = "dummy-fluid-wagon",
    capacity = 1
  },
  {
    type = "flying-text",
    name = "flying-text", -- also a core prototype
    speed = 1,
    time_to_live = 1
  },
  {
    type = "furnace",
    name = "dummy-furnace",
    energy_usage = "1J",
    energy_source = dummy_void_energy_source(),
    crafting_speed = 1,
    crafting_categories = {"crafting"},
    result_inventory_size = 1,
    source_inventory_size = 1
  },
  {
    type = "gate",
    name = "dummy-gate",
    activation_distance = 1,
    close_sound = dummy_sound(),
    open_sound = dummy_sound(),
    horizontal_animation = dummy_animation(),
    horizontal_rail_animation_left = dummy_animation(),
    horizontal_rail_animation_right = dummy_animation(),
    horizontal_rail_base = dummy_animation(),
    opening_speed = 1,
    timeout_to_close = 1,
    vertical_animation = dummy_animation(),
    vertical_rail_animation_left = dummy_animation(),
    vertical_rail_animation_right = dummy_animation(),
    vertical_rail_base = dummy_animation(),
    wall_patch = dummy_animation()
  },
  {
    type = "generator",
    name = "dummy-generator",
    effectivity = 1,
    energy_source = dummy_electric_input_energy_source(), -- HACK
    fluid_box = dummy_fluid_box(),
    fluid_usage_per_tick = 1,
    horizontal_animation = dummy_animation(),
    maximum_temperature = 1,
    vertical_animation = dummy_animation(),
    max_power_output = "1J"
  },
  {
    type = "heat-interface",
    name = "dummy-heat-interface",
    heat_buffer = dummy_heat_buffer()
  },
  {
    type = "heat-pipe",
    name = "dummy-heat-pipe",
    heat_buffer = dummy_heat_buffer(),
    connection_sprites =
    {
      single = {dummy_sprite()},
      straight_vertical = {dummy_sprite()},
      straight_horizontal = {dummy_sprite()},
      corner_right_down = {dummy_sprite()},
      corner_left_down = {dummy_sprite()},
      corner_right_up = {dummy_sprite()},
      corner_left_up = {dummy_sprite()},
      t_up = {dummy_sprite()},
      t_right = {dummy_sprite()},
      t_down = {dummy_sprite()},
      t_left = {dummy_sprite()},
      ending_up = {dummy_sprite()},
      ending_right = {dummy_sprite()},
      ending_down = {dummy_sprite()},
      ending_left = {dummy_sprite()},
      cross = {dummy_sprite()}
    },
    heat_glow_sprites =
    {
      single = {dummy_sprite()},
      straight_vertical = {dummy_sprite()},
      straight_horizontal = {dummy_sprite()},
      corner_right_down = {dummy_sprite()},
      corner_left_down = {dummy_sprite()},
      corner_right_up = {dummy_sprite()},
      corner_left_up = {dummy_sprite()},
      t_up = {dummy_sprite()},
      t_right = {dummy_sprite()},
      t_down = {dummy_sprite()},
      t_left = {dummy_sprite()},
      ending_up = {dummy_sprite()},
      ending_right = {dummy_sprite()},
      ending_down = {dummy_sprite()},
      ending_left = {dummy_sprite()},
      cross = {dummy_sprite()}
    }
  },
  {
    type = "highlight-box",
    name = "dummy-highlight-box"
  },
  {
    type = "infinity-container",
    name = "dummy-infinity-container",
    inventory_size = 1,
    picture = dummy_sprite(),
    erase_contents_when_mined = true
  },
  add_pipe_properties
  {
    type = "infinity-pipe",
    name = "dummy-infinity-pipe"
  },
  {
    type = "inserter",
    name = "dummy-inserter",

    -- copied from vanilla because these values are finicky
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    pickup_position = {0, -1},
    insert_position = {0, 1.2},

    energy_source = dummy_void_energy_source(),
    extension_speed = 1,
    hand_base_picture = dummy_sprite(),
    hand_base_shadow = dummy_sprite(),
    hand_closed_picture = dummy_sprite(),
    hand_closed_shadow = dummy_sprite(),
    hand_open_picture = dummy_sprite(),
    hand_open_shadow = dummy_sprite(),
    platform_picture = dummy_sprite(),
    rotation_speed = 1
  },
  {
    type = "item-entity",
    name = "item-on-ground" -- also a core prototype
  },
  {
    type = "item-request-proxy",
    name = "item-request-proxy", -- also a core prototype
    picture = dummy_sprite()
  },
  {
    type = "lab",
    name = "dummy-lab",
    energy_source = dummy_void_energy_source(),
    energy_usage = "1J",
    inputs = {},
    off_animation = dummy_animation(),
    on_animation = dummy_animation()
  },
  {
    type = "lamp",
    name = "dummy-lamp",
    energy_source = dummy_void_energy_source(),
    energy_usage_per_tick = "1J",
    picture_off = dummy_sprite(),
    picture_on = dummy_sprite()
  },
  {
    type = "land-mine",
    name = "dummy-land-mine",
    picture_safe = dummy_sprite(),
    picture_set = dummy_sprite(),
    trigger_radius = 1
  },
  {
    type = "leaf-particle",
    name = "leaf-particle-for-migration" -- deprecated prototype
  },
  add_transport_belt_connectable_properties
  {
    type = "loader",
    name = "dummy-loader",
    filter_count = 1,
    structure =
    {
      direction_in = dummy_sprite(),
      direction_out  = dummy_sprite()
    }
  },
  add_transport_belt_connectable_properties
  {
    type = "loader-1x1",
    name = "dummy-loader-1x1",
    filter_count = 1,
    structure =
    {
      direction_in = dummy_sprite(),
      direction_out  = dummy_sprite()
    }
  },
  add_rolling_stock_properties
  {
    type = "locomotive",
    name = "dummy-locomotive",
    energy_source = dummy_void_energy_source(),
    max_power = "1J",
    reversing_power_modifier = 1
  },
  {
    type = "logistic-container",
    name = "dummy-logistic-container",
    inventory_size = 1,
    picture = dummy_sprite(),
    logistic_mode = "active-provider"
  },
  {
    type = "logistic-robot",
    name = "dummy-logistic-robot",
    speed = 1,
    max_payload_size = 1,
    cargo_centered = dummy_vector()
  },
  {
    type = "market",
    name = "dummy-market",
    picture = dummy_sprite()
  },
  {
    type = "mining-drill",
    name = "dummy-mining-drill",
    animations = dummy_animation(),
    energy_source = dummy_void_energy_source(),
    energy_usage = "1J",
    mining_speed = 1,
    resource_categories = {"basic-solid"},
    resource_searching_radius = 1,
    vector_to_place_result = dummy_vector()
  },
  {
    type = "offshore-pump",
    name = "dummy-offshore-pump",
    fluid = "water",
    fluid_box = dummy_fluid_box(),
    pumping_speed = 1,
    graphics_set =
    {
      animation = dummy_animation()
    }
  },
  {
    type = "particle",
    name = "particle-for-migration" -- deprecated prototype
  },
  {
    type = "particle-source",
    name = "dummy-particle-source",
    height = 1,
    horizontal_speed = 1,
    particle = "dummy-optimized-particle",
    time_before_start = 1,
    time_to_live = 1,
    vertical_speed = 1
  },
  add_pipe_properties
  {
    type = "pipe",
    name = "dummy-pipe"
  },
  {
    type = "pipe-to-ground",
    name = "dummy-pipe-to-ground",
    fluid_box = dummy_fluid_box(),
    pictures = {
      down = dummy_sprite(),
      up = dummy_sprite(),
      left = dummy_sprite(),
      right = dummy_sprite(),
    }
  },
  {
    type = "player-port",
    name = "dummy-player-port",
    animation = dummy_animation()
  },
  {
    type = "power-switch",
    name = "dummy-power-switch",
    circuit_wire_connection_point = dummy_wire_connection_point(),
    led_off = dummy_sprite(),
    led_on = dummy_sprite(),
    left_wire_connection_point = dummy_wire_connection_point(),
    overlay_loop = dummy_animation(),
    overlay_start = dummy_animation(),
    overlay_start_delay = 1,
    power_on_animation = dummy_animation(),
    right_wire_connection_point = dummy_wire_connection_point()
  },
  {
    type = "programmable-speaker",
    name = "dummy-programmable-speaker",
    energy_source = dummy_void_energy_source(),
    energy_usage_per_tick = "1J",
    instruments = {},
    maximum_polyphony = 1,
    sprite = dummy_sprite()
  },
  {
    type = "projectile",
    name = "dummy-projectile",
    acceleration = 1,
    animation = dummy_animation()
  },
  {
    type = "pump",
    name = "dummy-pump",
    animations = dummy_animation(),
    energy_source = dummy_void_energy_source(),
    energy_usage = "1J",
    fluid_box = dummy_fluid_box(),
    pumping_speed = 1
  },
  {
    type = "radar",
    name = "dummy-radar",
    energy_per_nearby_scan = "1J",
    energy_per_sector = "1J",
    energy_source = dummy_void_energy_source(),
    energy_usage = "1J",
    max_distance_of_nearby_sector_revealed = 1,
    max_distance_of_sector_revealed = 1,
    pictures = dummy_rotated_sprite()
  },
  {
    type = "rail-chain-signal",
    name = "dummy-rail-chain-signal",
    animation = dummy_rotated_animation(),
    -- HACK
    selection_box_offsets= (function()
        local t = {}
        for i=1,8 do
          t[#t+1] = dummy_vector()
        end
        return t
      end)()
  },
  {
    type = "rail-remnants",
    name = "dummy-rail-remnants",
    bending_type = "straight",
    pictures = dummy_rail_pictures(),
    collision_box = dummy_nonzero_bounding_box()
  },
  {
    type = "rail-signal",
    name = "dummy-rail-signal",
    animation = dummy_rotated_animation()
  },
  {
    type = "reactor",
    name = "dummy-reactor",
    consumption = "1J",
    energy_source = dummy_void_energy_source(),
    heat_buffer = dummy_heat_buffer(),
    working_light_picture = dummy_sprite()
  },
  {
    type = "resource",
    name = "dummy-resource",
    stage_counts = {},
    stages = dummy_animation(),
    minable = {mining_time = 1}
  },
  {
    type = "roboport",
    name = "dummy-roboport",
    base = dummy_sprite(),
    base_animation = dummy_animation(),
    base_patch = dummy_sprite(),
    charge_approach_distance = 1,
    charging_energy = "1J",
    construction_radius = 1,
    door_animation_down = dummy_animation(),
    door_animation_up = dummy_animation(),
    energy_source = dummy_void_energy_source(),
    energy_usage = "1J",
    logistics_radius = 1,
    material_slots_count = 1,
    recharge_minimum = "1J",
    recharging_animation = dummy_animation(),
    request_to_open_door_timeout = 1,
    robot_slots_count = 0, -- workaround (1 errors)
    spawn_and_station_height = 1
  },
  {
    type = "rocket-silo",
    name = "dummy-rocket-silo",
    energy_usage = "1J",
    energy_source = dummy_void_energy_source(),
    crafting_speed = 1,
    crafting_categories = {"crafting"},
    active_energy_usage = "1J",
    idle_energy_usage = "1J",
    lamp_energy_usage = "1J",
    rocket_entity = "dummy-rocket-silo-rocket",
    satellite_animation = dummy_animation(),
    satellite_shadow_animation = dummy_animation(),
    arm_02_right_animation = dummy_animation(),
    arm_01_back_animation = dummy_animation(),
    arm_03_front_animation = dummy_animation(),
    shadow_sprite = dummy_sprite(),
    hole_sprite = dummy_sprite(),
    hole_light_sprite = dummy_sprite(),
    rocket_shadow_overlay_sprite = dummy_sprite(),
    rocket_glow_overlay_sprite = dummy_sprite(),
    door_back_sprite = dummy_sprite(),
    door_front_sprite = dummy_sprite(),
    base_day_sprite = dummy_sprite(),
    base_front_sprite = dummy_sprite(),
    red_lights_back_sprites = dummy_sprite(),
    red_lights_front_sprites = dummy_sprite(),
    hole_clipping_box = dummy_bounding_box(),
    door_back_open_offset = dummy_vector(),
    door_front_open_offset = dummy_vector(),
    silo_fade_out_start_distance = 1,
    silo_fade_out_end_distance = 1,
    times_to_blink = 1,
    light_blinking_speed = 1,
    door_opening_speed = 1,
    rocket_parts_required = 1
  },
  {
    type = "rocket-silo-rocket",
    name = "dummy-rocket-silo-rocket",
    rocket_sprite = dummy_sprite(),
    rocket_shadow_sprite = dummy_sprite(),
    rocket_glare_overlay_sprite = dummy_sprite(),
    rocket_smoke_bottom1_animation = dummy_animation(),
    rocket_smoke_bottom2_animation = dummy_animation(),
    rocket_smoke_top1_animation = dummy_animation(),
    rocket_smoke_top2_animation = dummy_animation(),
    rocket_smoke_top3_animation = dummy_animation(),
    rocket_flame_animation = dummy_animation(),
    rocket_flame_left_animation = dummy_animation(),
    rocket_flame_right_animation = dummy_animation(),
    rocket_rise_offset = dummy_vector(),
    rocket_flame_left_rotation = 1,
    rocket_flame_right_rotation = 1,
    rocket_render_layer_switch_distance = 1,
    full_render_layer_switch_distance = 1,
    full_render_layer_switch_distance = 1,
    rocket_launch_offset = dummy_vector(),
    effects_fade_in_start_distance = 1,
    effects_fade_in_end_distance = 1,
    shadow_fade_out_start_ratio = 1,
    shadow_fade_out_end_ratio = 1,
    rocket_visible_distance_from_center = 1,
    rising_speed = 1,
    engine_starting_speed = 1,
    flying_speed = 1,
    flying_acceleration = 1,
    inventory_size = 1
  },
  {
    type = "rocket-silo-rocket-shadow",
    name = "dummy-rocket-silo-rocket-shadow"
  },
  {
    type = "simple-entity",
    name = "dummy-simple-entity",
    picture = dummy_sprite()
  },
  {
    type = "simple-entity-with-force",
    name = "dummy-simple-entity-with-force",
    picture = dummy_sprite()
  },
  {
    type = "simple-entity-with-owner",
    name = "dummy-simple-entity-with-owner",
    picture = dummy_sprite()
  },
  {
    type = "smoke",
    name = "smoke-for-migration", -- deprecated prototype
    animation = dummy_animation()
  },
  {
    type = "smoke-with-trigger",
    name = "dummy-smoke-with-trigger",
    animation = dummy_animation()
  },
  {
    type = "solar-panel",
    name = "dummy-solar-panel",
    energy_source = dummy_electric_input_energy_source(), -- HACK
    picture = dummy_sprite(),
    production = "1J"
  },
  {
    type = "speech-bubble",
    name = "dummy-speech-bubble",
    style = "speech_bubble" -- defined in __core__/prototypes/style.lua
  },
  add_transport_belt_connectable_properties
  {
    type = "splitter",
    name = "dummy-splitter",
    structure =
    {
      north = dummy_animation(),
      east = dummy_animation(),
      south = dummy_animation(),
      west = dummy_animation()
    }
  },
  {
    type = "sticker",
    name = "dummy-sticker",
    duration_in_ticks = 1
  },
  {
    type = "storage-tank",
    name = "dummy-storage-tank",
    flow_length_in_ticks = 1,
    fluid_box = dummy_fluid_box(),
    pictures =
    {
      picture = dummy_sprite(),
      window_background = dummy_sprite(),
      fluid_background = dummy_sprite(),
      flow_sprite = dummy_sprite(),
      gas_flow = dummy_animation()
    },
    window_bounding_box = dummy_bounding_box()
  },
  {
    type = "straight-rail",
    name = "dummy-straight-rail",
    pictures = dummy_rail_pictures()
  },
  {
    type = "stream",
    name = "dummy-stream",
    particle_horizontal_speed = 1,
    particle_horizontal_speed_deviation = 0, -- workaround (1 errors)
    particle_spawn_interval = 1,
    particle_vertical_acceleration = 1
  },
  {
    type = "tile-ghost",
    name = "tile-ghost" -- also a core prototype
  },
  {
    type = "train-stop",
    name = "dummy-train-stop",
    animation_ticks_per_frame = 1
  },
  add_transport_belt_connectable_properties
  {
    type = "transport-belt",
    name = "dummy-transport-belt",
    connector_frame_sprites =
    {
      -- HACK
      frame_main = (function()
        local t = {}
        for i=1,7 do
          t[#t+1] = dummy_animation()
        end
        return t
      end)(),
      frame_shadow = (function()
        local t = {}
        for i=1,7 do
          t[#t+1] = dummy_animation()
        end
        return t
      end)(),
      frame_main_scanner = dummy_animation(),
      frame_main_scanner_movement_speed = 1,
      frame_main_scanner_horizontal_start_shift = dummy_vector(),
      frame_main_scanner_horizontal_end_shift = dummy_vector(),
      frame_main_scanner_horizontal_y_scale = 1,
      frame_main_scanner_horizontal_rotation = 1,
      frame_main_scanner_vertical_start_shift = dummy_vector(),
      frame_main_scanner_vertical_end_shift = dummy_vector(),
      frame_main_scanner_vertical_y_scale = 1,
      frame_main_scanner_vertical_rotation = 1,
      frame_main_scanner_cross_horizontal_start_shift = dummy_vector(),
      frame_main_scanner_cross_horizontal_end_shift = dummy_vector(),
      frame_main_scanner_cross_horizontal_y_scale = 1,
      frame_main_scanner_cross_horizontal_rotation = 1,
      frame_main_scanner_cross_vertical_start_shift = dummy_vector(),
      frame_main_scanner_cross_vertical_end_shift = dummy_vector(),
      frame_main_scanner_cross_vertical_y_scale = 1,
      frame_main_scanner_cross_vertical_rotation = 1,
      frame_main_scanner_nw_ne = dummy_animation(),
      frame_main_scanner_sw_se = dummy_animation()
    }
  },
  {
    type = "tree",
    name = "dummy-tree",
    pictures = dummy_sprite()
  },
  add_turret_properties
  {
    type = "turret",
    name = "dummy-turret"
  },
  add_transport_belt_connectable_properties
  {
    type = "underground-belt",
    name = "dummy-underground-belt",
    max_distance = 1,
    structure =
    {
      direction_in = dummy_sprite(),
      direction_out = dummy_sprite()
    },
    underground_sprite = dummy_sprite()
  },
  {
    type = "unit",
    name = "small-biter", -- also a core prototype
    attack_parameters = dummy_attack_parameters(),
    distance_per_frame = 1,
    distraction_cooldown = 1,
    movement_speed = 1,
    pollution_to_join_attack = 1,
    run_animation = dummy_rotated_animation(),
    vision_distance = 1
  },
  {
    type = "unit-spawner",
    name = "dummy-unit-spawner",
    animations = dummy_animation(),
    call_for_help_radius = 1,
    max_count_of_owned_units = 1,
    max_friends_around_to_spawn = 1,
    max_richness_for_spawn_shift = 1,
    max_spawn_shift = 1,
    pollution_absorption_absolute = 1,
    pollution_absorption_proportional = 1,
    result_units = {{"small-biter", {{1, 1}}}},
    spawning_cooldown = {1, 1},
    spawning_radius = 1,
    spawning_spacing = 1
  },
  {
    type = "wall",
    name = "dummy-wall",
    pictures =
    {
      single = dummy_sprite(),
      straight_vertical = dummy_sprite(),
      straight_horizontal = dummy_sprite(),
      corner_right_down = dummy_sprite(),
      corner_left_down = dummy_sprite(),
      t_up = dummy_sprite(),
      ending_right = dummy_sprite(),
      ending_left = dummy_sprite()
    }
  },
  -- equipment
  add_equipment_properties
  {
    type = "active-defense-equipment",
    name = "dummy-active-defense-equipment",
    automatic = false,
    ability_icon = dummy_sprite(),
    attack_parameters = dummy_attack_parameters()
  },
  add_equipment_properties
  {
    type = "battery-equipment",
    name = "dummy-battery-equipment"
  },
  add_equipment_properties
  {
    type = "belt-immunity-equipment",
    name = "dummy-belt-immunity-equipment",
    energy_consumption = "1J"
  },
  add_equipment_properties
  {
    type = "energy-shield-equipment",
    name = "dummy-energy-shield-equipment",
    energy_per_shield = "1J",
    max_shield_value = 1
  },
  add_equipment_properties
  {
    type = "generator-equipment",
    name = "dummy-generator-equipment",
    power = "1J"
  },
  add_equipment_properties
  {
    type = "movement-bonus-equipment",
    name = "dummy-movement-bonus-equipment",
    energy_consumption = "1J",
    movement_bonus = 1
  },
  add_equipment_properties
  {
    type = "night-vision-equipment",
    name = "dummy-night-vision-equipment",
    energy_input = "1J",
    color_lookup = {{1, "identity"}}
  },
  add_equipment_properties
  {
    type = "roboport-equipment",
    name = "dummy-roboport-equipment",
    charge_approach_distance = 1,
    charging_energy = "1J",
    construction_radius = 1,
    recharging_animation = dummy_animation(),
    spawn_and_station_height = 1
  },
  add_equipment_properties
  {
    type = "solar-panel-equipment",
    name = "dummy-solar-panel-equipment",
    power = "1J"
  },

  -- Needed for utility constants setup, utility constants are use them in the core mod
  -- TODO find out if I can modify the utility constants to no longer require this
  {
    type = "trigger-target-type",
    name = "common"
  },
  {
    type = "trigger-target-type",
    name = "ground-unit"
  },

  -- More core prototypes
  {
    type = "tile",
    name = "grass-1",
    collision_mask = {"ground-tile"},
    layer = 1,
    variants =
    {
      empty_transitions = true,
      main = {{
        count = 1,
        picture = dummy_32px_sprite_filename,
        size = 1
      }}
    },
    map_color = dummy_color(),
    pollution_absorption_per_second = 1
  },
  {
    type = "equipment-grid",
    name = "small-equipment-grid",
    equipment_categories = {"dummy-equipment-category"},
    height = 1,
    width = 1
  },
  add_item_properties
  {
    type = "item",
    name = "copper-cable"
  },
  add_item_properties
  {
    type = "item",
    name = "red-wire"
  },
  add_item_properties
  {
    type = "item",
    name = "green-wire"
  },
  add_dummy_icon
  {
    type = "virtual-signal",
    name = "signal-everything",
    subgroup = "other"
  },
  add_dummy_icon
  {
    type = "virtual-signal",
    name = "signal-anything",
    subgroup = "other"
  },
  add_dummy_icon
  {
    type = "virtual-signal",
    name = "signal-each",
    subgroup = "other"
  },
  {
    type = "damage-type",
    name = "impact"
  },
  {
    type = "trivial-smoke",
    name = "smoke-building",
    animation = dummy_animation(),
    duration = 1,
    cyclic = true
  }

})

