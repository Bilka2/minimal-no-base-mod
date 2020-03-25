local dummy_sound_filename = "__core__/sound/achievement-unlocked.ogg" -- currently unused
local dummy_sprite_filename = "__core__/graphics/empty.png"
local dummy_color = {1, 1, 1, 1} -- white

local function add_dummy_icon(prototype)
  prototype.icon = dummy_sprite_filename
  prototype.icon_size = 1
  return prototype
end

-- common base prototypes
local function add_item_properties(prototype)
  prototype = add_dummy_icon(prototype)
  prototype.stack_size = 1
  return prototype
end
local function add_selection_tool_properties(prototype)
  prototype = add_item_properties(prototype)
  prototype.selection_color = dummy_color
  prototype.alt_selection_color = dummy_color
  prototype.selection_mode = "nothing"
  prototype.alt_selection_mode = "nothing"
  prototype.selection_cursor_box_type = "entity"
  prototype.alt_selection_cursor_box_type = "entity"
  return prototype
end

-- common properties
local function dummy_sprite()
  return
  {
    filename = dummy_sprite_filename,
    size = 1
  }
end
local function dummy_8waysprite()
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
local function dummy_attack_parameters()
  return
  {
    type = "beam",
    ammo_type =
    {
      category = "dummy-ammo-category"
    },
    range = 1.0,
    cooldown = 1.0
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

data:extend(
{
  {
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
    type = "active-defense-equipment",
    name = "dummy-active-defense-equipment",
    sprite = dummy_sprite(),
    shape = {
      type = "full",
      width = 1,
      height = 1
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "10kW",
      usage_priority = "primary-input"
    },
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
  add_dummy_icon
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
      rail_endings = dummy_8waysprite()
    }
  },
  add_dummy_icon
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
      rail_endings = dummy_8waysprite()
    }
  },

  -- the prototypes
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
    name = "copy-paste-tool" -- also core prototype
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
    speed = 1.0
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


})

