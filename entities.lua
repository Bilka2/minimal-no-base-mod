-- This file contains all entities, including ones that are core prototypes.
--   Core prototypes are named prototypes that the game requires to always exist, for example a "copper-cable" item.

local properties = require("common-properties")

-- These functions are applied directly to the prototype table.
-- This allows to easily create many prototypes that inherit from the same base class/prototype, without copy pasting properties.
local function add_turret_properties(prototype)
  prototype.call_for_help_radius = 1
  prototype.attack_parameters = properties.attack_parameters()
  prototype.folded_animation = properties.rotated_animation()
  return prototype
end

local function add_combinator_properties(prototype)
  prototype.energy_source = properties.void_energy_source()
  prototype.active_energy_usage = "1J"
  prototype.sprites = properties.sprite()
  prototype.activity_led_sprites = properties.sprite()
  prototype.input_connection_bounding_box = properties.bounding_box()
  prototype.output_connection_bounding_box = properties.bounding_box()
  prototype.activity_led_light_offsets =
  {
    properties.vector(),
    properties.vector(),
    properties.vector(),
    properties.vector()
  }
  prototype.screen_light_offsets =
  {
    properties.vector(),
    properties.vector(),
    properties.vector(),
    properties.vector()
  }
  prototype.input_connection_points =
  {
    properties.wire_connection_point(),
    properties.wire_connection_point(),
    properties.wire_connection_point(),
    properties.wire_connection_point()
  }
  prototype.output_connection_points =
  {
    properties.wire_connection_point(),
    properties.wire_connection_point(),
    properties.wire_connection_point(),
    properties.wire_connection_point()
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
  prototype.pictures = properties.rotated_sprite()
  prototype.vertical_selection_shift = 1
  return prototype
end

local function add_pipe_properties(prototype)
  prototype.horizontal_window_bounding_box = properties.bounding_box()
  prototype.vertical_window_bounding_box = properties.bounding_box()
  prototype.fluid_box = properties.fluid_box()
  prototype.pictures =
  {
    straight_vertical_single = properties.sprite(),
    straight_vertical = properties.sprite(),
    straight_vertical_window = properties.sprite(),
    straight_horizontal = properties.sprite(),
    straight_horizontal_window = properties.sprite(),
    corner_up_right = properties.sprite(),
    corner_up_left = properties.sprite(),
    corner_down_right = properties.sprite(),
    corner_down_left = properties.sprite(),
    t_up = properties.sprite(),
    t_down = properties.sprite(),
    t_right = properties.sprite(),
    t_left = properties.sprite(),
    cross = properties.sprite(),
    ending_up = properties.sprite(),
    ending_down = properties.sprite(),
    ending_right = properties.sprite(),
    ending_left = properties.sprite(),
    horizontal_window_background = properties.sprite(),
    vertical_window_background = properties.sprite(),
    fluid_background = properties.sprite(),
    low_temperature_flow = properties.sprite(),
    middle_temperature_flow = properties.sprite(),
    high_temperature_flow = properties.sprite(),
    gas_flow = properties.animation()
  }
  return prototype
end

local function add_transport_belt_connectable_properties(prototype)
  prototype.collision_box = properties.nonzero_bounding_box()
  prototype.speed = 1
  prototype.belt_animation_set =
  {
    animation_set = properties.rotated_sprite_custom_direction_count(20)
  }
  return prototype
end

-- entity prototypes, one of each, alphabetical by type
data:extend({
  {
    type = "accumulator",
    name = "dummy-accumulator",
    energy_source = properties.electric_energy_source(),
    picture = properties.sprite(),
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
    plus_symbol_sprites = properties.sprite(),
    minus_symbol_sprites = properties.sprite(),
    multiply_symbol_sprites = properties.sprite(),
    divide_symbol_sprites = properties.sprite(),
    modulo_symbol_sprites = properties.sprite(),
    power_symbol_sprites = properties.sprite(),
    left_shift_symbol_sprites = properties.sprite(),
    right_shift_symbol_sprites = properties.sprite(),
    and_symbol_sprites = properties.sprite(),
    or_symbol_sprites = properties.sprite(),
    xor_symbol_sprites = properties.sprite()
  },
  {
    type = "arrow",
    name = "dummy-arrow",
    arrow_picture = properties.sprite()
  },
  {
    type = "artillery-flare",
    name = "dummy-artillery-flare",
    life_time = 1,
    pictures = properties.animation(),
    render_layer = properties.render_layer,
    render_layer_when_on_ground = properties.render_layer,
    map_color = properties.color()
  },
  {
    type = "artillery-projectile",
    name = "dummy-artillery-projectile",
    reveal_map = true,
    map_color = properties.color()
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
    energy_source = properties.void_energy_source(),
    crafting_speed = 1,
    crafting_categories = {"crafting"}
  },
  {
    type = "beacon",
    name = "dummy-beacon",
    animation = properties.animation(),
    animation_shadow = properties.animation(),
    base_picture = properties.sprite(),
    distribution_effectivity = 1,
    energy_source = properties.void_energy_source(),
    energy_usage = "1J",
    module_specification = {},
    supply_area_distance = 1
  },
  {
    type = "beam",
    name = "dummy-beam",
    body = properties.animation(),
    damage_interval = 1,
    head = properties.animation(),
    tail = properties.animation(),
    width = 1
  },
  {
    type = "boiler",
    name = "dummy-boiler",
    burning_cooldown = 1,
    energy_consumption = "1J",
    energy_source = properties.void_energy_source(),
    fluid_box = properties.fluid_box(),
    output_fluid_box = properties.fluid_box(),
    target_temperature = 1,
    structure =
    {
      north = properties.sprite(),
      east = properties.sprite(),
      south = properties.sprite(),
      west = properties.sprite(),
    },
    fire = {},
    fire_glow = {},
  },
  {
    type = "burner-generator",
    name = "dummy-burner-generator",
    animation = properties.animation(),
    burner = properties.burner_energy_source(),
    energy_source = properties.electric_energy_source(),
    max_power_output = "1J"
  },
  add_vehicle_properties
  {
    type = "car",
    name = "dummy-car",
    animation = properties.rotated_animation(),
    energy_source = properties.void_energy_source(),
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
    heartbeat = properties.sound(),
    eat = properties.sound(),
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
    damage_hit_tint = properties.color(),
    running_sound_animation_positions = {},
    mining_with_tool_particles_animation_positions = {},
    animations =
    {
      {
        idle = properties.rotated_animation(),
        idle_with_gun = properties.rotated_animation(),
        running = properties.rotated_animation(),
        running_with_gun = properties.rotated_sprite_custom_direction_count(18),
        mining_with_tool = properties.rotated_animation()
      }
    }
  },
  {
    type = "character-corpse",
    name = "dummy-character-corpse",
    time_to_live = 1,
    picture = properties.animation()
  },
  {
    type = "cliff",
    name = "dummy-cliff",
    grid_offset = properties.vector(),
    grid_size = {1, 1}, -- must be non-zero vector
    orientations =  {
      west_to_east = properties.oriented_cliff_prototype(),
      north_to_south = properties.oriented_cliff_prototype(),
      east_to_west = properties.oriented_cliff_prototype(),
      south_to_north = properties.oriented_cliff_prototype(),
      west_to_north = properties.oriented_cliff_prototype(),
      north_to_east = properties.oriented_cliff_prototype(),
      east_to_south = properties.oriented_cliff_prototype(),
      south_to_west = properties.oriented_cliff_prototype(),
      west_to_south = properties.oriented_cliff_prototype(),
      north_to_west = properties.oriented_cliff_prototype(),
      east_to_north = properties.oriented_cliff_prototype(),
      south_to_east = properties.oriented_cliff_prototype(),
      west_to_none = properties.oriented_cliff_prototype(),
      none_to_east = properties.oriented_cliff_prototype(),
      north_to_none = properties.oriented_cliff_prototype(),
      none_to_south = properties.oriented_cliff_prototype(),
      east_to_none = properties.oriented_cliff_prototype(),
      none_to_west = properties.oriented_cliff_prototype(),
      south_to_none = properties.oriented_cliff_prototype(),
      none_to_north = properties.oriented_cliff_prototype()
    }
  },
  {
    type = "combat-robot",
    name = "dummy-combat-robot",
    speed = 1,
    attack_parameters = properties.attack_parameters(),
    idle = properties.rotated_animation(),
    in_motion = properties.rotated_animation(),
    shadow_idle = properties.rotated_animation(),
    shadow_in_motion = properties.rotated_animation(),
    time_to_live = 1
  },
  {
    type = "constant-combinator",
    name = "dummy-constant-combinator",
    item_slot_count = 1,
    sprites = properties.sprite(),
    activity_led_sprites = properties.sprite(),
    activity_led_light_offsets =
    {
      properties.vector(),
      properties.vector(),
      properties.vector(),
      properties.vector()
    },
    circuit_wire_connection_points =
    {
      properties.wire_connection_point(),
      properties.wire_connection_point(),
      properties.wire_connection_point(),
      properties.wire_connection_point()
    }
  },
  {
    type = "construction-robot",
    name = "dummy-construction-robot",
    speed = 1,
    max_payload_size = 1,
    cargo_centered = properties.vector(),
    construction_vector = properties.vector()
  },
  {
    type = "container",
    name = "dummy-container",
    inventory_size = 1,
    picture = properties.sprite()
  },
  {
    type = "corpse",
    name = "dummy-corpse"
  },
  {
    type = "curved-rail",
    name = "dummy-curved-rail",
    pictures = properties.rail_pictures()
  },
  add_combinator_properties
  {
    type = "decider-combinator",
    name = "dummy-decider-combinator",
    equal_symbol_sprites = properties.sprite(),
    greater_or_equal_symbol_sprites = properties.sprite(),
    greater_symbol_sprites = properties.sprite(),
    less_or_equal_symbol_sprites = properties.sprite(),
    less_symbol_sprites = properties.sprite(),
    not_equal_symbol_sprites = properties.sprite()
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
    energy_source = properties.electric_energy_source()
  },
  {
    type = "electric-pole",
    name = "dummy-electric-pole",
    connection_points = {
      properties.wire_connection_point()
    },
    pictures = properties.rotated_sprite(),
    supply_area_distance = 1
  },
  add_turret_properties
  {
    type = "electric-turret",
    name = "dummy-electric-turret",
    energy_source = properties.void_energy_source()
  },
  {
    type = "entity-ghost",
    name = "dummy-entity-ghost"
  },
  {
    type = "explosion",
    name = "dummy-explosion",
    animations = properties.animation()
  },
  {
    type = "fire",
    name = "dummy-fire",
    damage_per_tick = properties.damage_prototype(),
    spread_delay = 1,
    spread_delay_deviation = 1
  },
  {
    type = "fish",
    name = "dummy-fish",
    pictures = properties.sprite()
  },
  {
    type = "flame-thrower-explosion",
    name = "dummy-flame-thrower-explosion",
    animations = properties.animation(),
    damage = properties.damage_prototype(),
    slow_down_factor = 1
  },
  add_turret_properties
  {
    type = "fluid-turret",
    name = "dummy-fluid-turret",
    activation_buffer_ratio = 1,
    fluid_box = properties.fluid_box(),
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
    energy_source = properties.void_energy_source(),
    crafting_speed = 1,
    crafting_categories = {"crafting"},
    result_inventory_size = 1,
    source_inventory_size = 1
  },
  {
    type = "gate",
    name = "dummy-gate",
    activation_distance = 1,
    close_sound = properties.sound(),
    open_sound = properties.sound(),
    horizontal_animation = properties.animation(),
    horizontal_rail_animation_left = properties.animation(),
    horizontal_rail_animation_right = properties.animation(),
    horizontal_rail_base = properties.animation(),
    opening_speed = 1,
    timeout_to_close = 1,
    vertical_animation = properties.animation(),
    vertical_rail_animation_left = properties.animation(),
    vertical_rail_animation_right = properties.animation(),
    vertical_rail_base = properties.animation(),
    wall_patch = properties.animation()
  },
  {
    type = "generator",
    name = "dummy-generator",
    effectivity = 1,
    energy_source = properties.electric_energy_source(),
    fluid_box = properties.fluid_box(),
    fluid_usage_per_tick = 1,
    horizontal_animation = properties.animation(),
    maximum_temperature = 1,
    vertical_animation = properties.animation(),
    max_power_output = "1J"
  },
  {
    type = "heat-interface",
    name = "dummy-heat-interface",
    heat_buffer = properties.heat_buffer()
  },
  {
    type = "heat-pipe",
    name = "dummy-heat-pipe",
    heat_buffer = properties.heat_buffer(),
    connection_sprites =
    {
      single = properties.sprite(),
      straight_vertical = properties.sprite(),
      straight_horizontal = properties.sprite(),
      corner_right_down = properties.sprite(),
      corner_left_down = properties.sprite(),
      corner_right_up = properties.sprite(),
      corner_left_up = properties.sprite(),
      t_up = properties.sprite(),
      t_right = properties.sprite(),
      t_down = properties.sprite(),
      t_left = properties.sprite(),
      ending_up = properties.sprite(),
      ending_right = properties.sprite(),
      ending_down = properties.sprite(),
      ending_left = properties.sprite(),
      cross = properties.sprite()
    },
    heat_glow_sprites =
    {
      single = properties.sprite(),
      straight_vertical = properties.sprite(),
      straight_horizontal = properties.sprite(),
      corner_right_down = properties.sprite(),
      corner_left_down = properties.sprite(),
      corner_right_up = properties.sprite(),
      corner_left_up = properties.sprite(),
      t_up = properties.sprite(),
      t_right = properties.sprite(),
      t_down = properties.sprite(),
      t_left = properties.sprite(),
      ending_up = properties.sprite(),
      ending_right = properties.sprite(),
      ending_down = properties.sprite(),
      ending_left = properties.sprite(),
      cross = properties.sprite()
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
    picture = properties.sprite(),
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

    energy_source = properties.void_energy_source(),
    extension_speed = 1,
    hand_base_picture = properties.sprite(),
    hand_base_shadow = properties.sprite(),
    hand_closed_picture = properties.sprite(),
    hand_closed_shadow = properties.sprite(),
    hand_open_picture = properties.sprite(),
    hand_open_shadow = properties.sprite(),
    platform_picture = properties.sprite(),
    rotation_speed = 1
  },
  {
    type = "item-entity",
    name = "item-on-ground" -- also a core prototype
  },
  {
    type = "item-request-proxy",
    name = "item-request-proxy", -- also a core prototype
    picture = properties.sprite()
  },
  {
    type = "lab",
    name = "dummy-lab",
    energy_source = properties.void_energy_source(),
    energy_usage = "1J",
    inputs = {},
    off_animation = properties.animation(),
    on_animation = properties.animation()
  },
  {
    type = "lamp",
    name = "dummy-lamp",
    energy_source = properties.void_energy_source(),
    energy_usage_per_tick = "1J",
    picture_off = properties.sprite(),
    picture_on = properties.sprite()
  },
  {
    type = "land-mine",
    name = "dummy-land-mine",
    picture_safe = properties.sprite(),
    picture_set = properties.sprite(),
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
      direction_in = properties.sprite(),
      direction_out  = properties.sprite()
    }
  },
  add_transport_belt_connectable_properties
  {
    type = "loader-1x1",
    name = "dummy-loader-1x1",
    filter_count = 1,
    structure =
    {
      direction_in = properties.sprite(),
      direction_out  = properties.sprite()
    }
  },
  add_rolling_stock_properties
  {
    type = "locomotive",
    name = "dummy-locomotive",
    energy_source = properties.void_energy_source(),
    max_power = "1J",
    reversing_power_modifier = 1
  },
  {
    type = "logistic-container",
    name = "dummy-logistic-container",
    inventory_size = 1,
    picture = properties.sprite(),
    logistic_mode = "active-provider"
  },
  {
    type = "logistic-robot",
    name = "dummy-logistic-robot",
    speed = 1,
    max_payload_size = 1,
    cargo_centered = properties.vector()
  },
  {
    type = "market",
    name = "dummy-market",
    picture = properties.sprite()
  },
  {
    type = "mining-drill",
    name = "dummy-mining-drill",
    animations = properties.animation(),
    energy_source = properties.void_energy_source(),
    energy_usage = "1J",
    mining_speed = 1,
    resource_categories = {"basic-solid"},
    resource_searching_radius = 1,
    vector_to_place_result = properties.vector()
  },
  {
    type = "offshore-pump",
    name = "dummy-offshore-pump",
    fluid = "dummy-fluid",
    fluid_box = properties.fluid_box(),
    pumping_speed = 1,
    graphics_set =
    {
      animation = properties.animation()
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
    fluid_box = properties.fluid_box(),
    pictures = {
      down = properties.sprite(),
      up = properties.sprite(),
      left = properties.sprite(),
      right = properties.sprite(),
    }
  },
  {
    type = "player-port",
    name = "dummy-player-port",
    animation = properties.animation()
  },
  {
    type = "power-switch",
    name = "dummy-power-switch",
    circuit_wire_connection_point = properties.wire_connection_point(),
    led_off = properties.sprite(),
    led_on = properties.sprite(),
    left_wire_connection_point = properties.wire_connection_point(),
    overlay_loop = properties.animation(),
    overlay_start = properties.animation(),
    overlay_start_delay = 1,
    power_on_animation = properties.animation(),
    right_wire_connection_point = properties.wire_connection_point()
  },
  {
    type = "programmable-speaker",
    name = "dummy-programmable-speaker",
    energy_source = properties.void_energy_source(),
    energy_usage_per_tick = "1J",
    instruments = {},
    maximum_polyphony = 1,
    sprite = properties.sprite()
  },
  {
    type = "projectile",
    name = "dummy-projectile",
    acceleration = 1,
    animation = properties.animation()
  },
  {
    type = "pump",
    name = "dummy-pump",
    animations = properties.animation(),
    energy_source = properties.void_energy_source(),
    energy_usage = "1J",
    fluid_box = properties.fluid_box(),
    pumping_speed = 1
  },
  {
    type = "radar",
    name = "dummy-radar",
    energy_per_nearby_scan = "1J",
    energy_per_sector = "1J",
    energy_source = properties.void_energy_source(),
    energy_usage = "1J",
    max_distance_of_nearby_sector_revealed = 1,
    max_distance_of_sector_revealed = 1,
    pictures = properties.rotated_sprite()
  },
  {
    type = "rail-chain-signal",
    name = "dummy-rail-chain-signal",
    animation = properties.rotated_animation(),
    -- HACK
    selection_box_offsets= (function()
        local t = {}
        for i=1,8 do
          t[#t+1] = properties.vector()
        end
        return t
      end)()
  },
  {
    type = "rail-remnants",
    name = "dummy-rail-remnants",
    bending_type = "straight",
    pictures = properties.rail_pictures(),
    collision_box = properties.nonzero_bounding_box()
  },
  {
    type = "rail-signal",
    name = "dummy-rail-signal",
    animation = properties.rotated_animation()
  },
  {
    type = "reactor",
    name = "dummy-reactor",
    consumption = "1J",
    energy_source = properties.void_energy_source(),
    heat_buffer = properties.heat_buffer(),
    working_light_picture = properties.sprite()
  },
  {
    type = "resource",
    name = "dummy-resource",
    stage_counts = {},
    stages = properties.animation(),
    minable = {mining_time = 1}
  },
  {
    type = "roboport",
    name = "dummy-roboport",
    base = properties.sprite(),
    base_animation = properties.animation(),
    base_patch = properties.sprite(),
    charge_approach_distance = 1,
    charging_energy = "1J",
    construction_radius = 1,
    door_animation_down = properties.animation(),
    door_animation_up = properties.animation(),
    energy_source = properties.void_energy_source(),
    energy_usage = "1J",
    logistics_radius = 1,
    material_slots_count = 1,
    recharge_minimum = "1J",
    recharging_animation = properties.animation(),
    request_to_open_door_timeout = 1,
    robot_slots_count = 0, -- workaround (1 errors)
    spawn_and_station_height = 1
  },
  {
    type = "rocket-silo",
    name = "dummy-rocket-silo",
    energy_usage = "1J",
    energy_source = properties.void_energy_source(),
    crafting_speed = 1,
    crafting_categories = {"crafting"},
    active_energy_usage = "1J",
    idle_energy_usage = "1J",
    lamp_energy_usage = "1J",
    rocket_entity = "dummy-rocket-silo-rocket",
    satellite_animation = properties.animation(),
    satellite_shadow_animation = properties.animation(),
    arm_02_right_animation = properties.animation(),
    arm_01_back_animation = properties.animation(),
    arm_03_front_animation = properties.animation(),
    shadow_sprite = properties.sprite(),
    hole_sprite = properties.sprite(),
    hole_light_sprite = properties.sprite(),
    rocket_shadow_overlay_sprite = properties.sprite(),
    rocket_glow_overlay_sprite = properties.sprite(),
    door_back_sprite = properties.sprite(),
    door_front_sprite = properties.sprite(),
    base_day_sprite = properties.sprite(),
    base_front_sprite = properties.sprite(),
    red_lights_back_sprites = properties.sprite(),
    red_lights_front_sprites = properties.sprite(),
    hole_clipping_box = properties.bounding_box(),
    door_back_open_offset = properties.vector(),
    door_front_open_offset = properties.vector(),
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
    rocket_sprite = properties.sprite(),
    rocket_shadow_sprite = properties.sprite(),
    rocket_glare_overlay_sprite = properties.sprite(),
    rocket_smoke_bottom1_animation = properties.animation(),
    rocket_smoke_bottom2_animation = properties.animation(),
    rocket_smoke_top1_animation = properties.animation(),
    rocket_smoke_top2_animation = properties.animation(),
    rocket_smoke_top3_animation = properties.animation(),
    rocket_flame_animation = properties.animation(),
    rocket_flame_left_animation = properties.animation(),
    rocket_flame_right_animation = properties.animation(),
    rocket_rise_offset = properties.vector(),
    rocket_flame_left_rotation = 1,
    rocket_flame_right_rotation = 1,
    rocket_render_layer_switch_distance = 1,
    full_render_layer_switch_distance = 1,
    full_render_layer_switch_distance = 1,
    rocket_launch_offset = properties.vector(),
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
    picture = properties.sprite()
  },
  {
    type = "simple-entity-with-force",
    name = "dummy-simple-entity-with-force",
    picture = properties.sprite()
  },
  {
    type = "simple-entity-with-owner",
    name = "dummy-simple-entity-with-owner",
    picture = properties.sprite()
  },
  {
    type = "smoke",
    name = "smoke-for-migration", -- deprecated prototype
    animation = properties.animation()
  },
  {
    type = "smoke-with-trigger",
    name = "dummy-smoke-with-trigger",
    animation = properties.animation()
  },
  {
    type = "solar-panel",
    name = "dummy-solar-panel",
    energy_source = properties.electric_energy_source(),
    picture = properties.sprite(),
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
      north = properties.animation(),
      east = properties.animation(),
      south = properties.animation(),
      west = properties.animation()
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
    fluid_box = properties.fluid_box(),
    pictures =
    {
      picture = properties.sprite(),
      window_background = properties.sprite(),
      fluid_background = properties.sprite(),
      flow_sprite = properties.sprite(),
      gas_flow = properties.animation()
    },
    window_bounding_box = properties.bounding_box()
  },
  {
    type = "straight-rail",
    name = "dummy-straight-rail",
    pictures = properties.rail_pictures()
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
          t[#t+1] = properties.animation()
        end
        return t
      end)(),
      frame_shadow = (function()
        local t = {}
        for i=1,7 do
          t[#t+1] = properties.animation()
        end
        return t
      end)(),
      frame_main_scanner = properties.animation(),
      frame_main_scanner_movement_speed = 1,
      frame_main_scanner_horizontal_start_shift = properties.vector(),
      frame_main_scanner_horizontal_end_shift = properties.vector(),
      frame_main_scanner_horizontal_y_scale = 1,
      frame_main_scanner_horizontal_rotation = 1,
      frame_main_scanner_vertical_start_shift = properties.vector(),
      frame_main_scanner_vertical_end_shift = properties.vector(),
      frame_main_scanner_vertical_y_scale = 1,
      frame_main_scanner_vertical_rotation = 1,
      frame_main_scanner_cross_horizontal_start_shift = properties.vector(),
      frame_main_scanner_cross_horizontal_end_shift = properties.vector(),
      frame_main_scanner_cross_horizontal_y_scale = 1,
      frame_main_scanner_cross_horizontal_rotation = 1,
      frame_main_scanner_cross_vertical_start_shift = properties.vector(),
      frame_main_scanner_cross_vertical_end_shift = properties.vector(),
      frame_main_scanner_cross_vertical_y_scale = 1,
      frame_main_scanner_cross_vertical_rotation = 1,
      frame_main_scanner_nw_ne = properties.animation(),
      frame_main_scanner_sw_se = properties.animation()
    }
  },
  {
    type = "tree",
    name = "dummy-tree",
    pictures = properties.sprite()
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
      direction_in = properties.sprite(),
      direction_out = properties.sprite()
    },
    underground_sprite = properties.sprite()
  },
  {
    type = "unit",
    name = "dummy-unit",
    attack_parameters = properties.attack_parameters(),
    distance_per_frame = 1,
    distraction_cooldown = 1,
    movement_speed = 1,
    pollution_to_join_attack = 1,
    run_animation = properties.rotated_animation(),
    vision_distance = 1
  },
  {
    type = "unit-spawner",
    name = "dummy-unit-spawner",
    animations = properties.animation(),
    call_for_help_radius = 1,
    max_count_of_owned_units = 1,
    max_friends_around_to_spawn = 1,
    max_richness_for_spawn_shift = 1,
    max_spawn_shift = 1,
    pollution_absorption_absolute = 1,
    pollution_absorption_proportional = 1,
    result_units = {{"dummy-unit", {{1, 1}}}},
    spawning_cooldown = {1, 1},
    spawning_radius = 1,
    spawning_spacing = 1
  },
  {
    type = "wall",
    name = "dummy-wall",
    pictures =
    {
      single = properties.sprite(),
      straight_vertical = properties.sprite(),
      straight_horizontal = properties.sprite(),
      corner_right_down = properties.sprite(),
      corner_left_down = properties.sprite(),
      t_up = properties.sprite(),
      ending_right = properties.sprite(),
      ending_left = properties.sprite()
    }
  }
})
