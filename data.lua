local properties = require("common-properties")
require("items")
require("entities")
require("equipment")

-- The utility constants are defined in the core mod.
--   Removing this property means trigger-target-type "common" and "ground-unit" do not have to be created.
data.raw["utility-constants"]["default"].default_trigger_target_mask_by_type = nil

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
  properties.add_icon
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
  properties.add_icon
  {
    type = "fluid",
    name = "dummy-fluid",
    base_color = properties.color(),
    default_temperature = 1,
    flow_color = properties.color(),
    max_temperature = 1,
    subgroup = "other"
  },
  {
    type = "tile",
    name = "dummy-tile",
    collision_mask = {"ground-tile"},
    layer = 1,
    variants =
    {
      empty_transitions = true,
      main = {{
        count = 1,
        picture = properties.sprite_filename_32px,
        size = 1
      }}
    },
    map_color = properties.color(),
    pollution_absorption_per_second = 1
  },
  {
    type = "equipment-grid",
    name = "dummy-equipment-grid",
    equipment_categories = {"dummy-equipment-category"},
    height = 1,
    width = 1
  },
  properties.add_icon
  {
    type = "virtual-signal",
    name = "signal-everything",
    subgroup = "other"
  },
  properties.add_icon
  {
    type = "virtual-signal",
    name = "signal-anything",
    subgroup = "other"
  },
  properties.add_icon
  {
    type = "virtual-signal",
    name = "signal-each",
    subgroup = "other"
  },
    {
    type = "damage-type",
    name = "physical"
  },
  {
    type = "damage-type",
    name = "impact"
  },
  {
    type = "trivial-smoke",
    name = "smoke-building",
    animation = properties.animation(),
    duration = 1,
    cyclic = true
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
    type = "optimized-particle",
    name = "dummy-optimized-particle",
    life_time = 2, -- workaround (1 errors)
    pictures = properties.animation(),
    render_layer = properties.render_layer,
    render_layer_when_on_ground = properties.render_layer
  },

  -- needed for maps to load in versions below 0.18.19
  properties.add_icon
  {
    type = "recipe",
    name = "dummy-recipe",
    ingredients = {},
    results = {},
    subgroup = "other"
  }
})
