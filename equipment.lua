-- This file contains all equipment.

local properties = require("common-properties")

-- This functions is applied directly to the prototype table.
-- This allows to easily create many prototypes that inherit from the same base class/prototype, without copy pasting properties.
local function add_equipment_properties(prototype)
  prototype.sprite = properties.sprite()
  prototype.shape = {
    type = "full",
    width = 1,
    height = 1
  }
  prototype.categories = {"dummy-equipment-category"}
  prototype.energy_source = properties.electric_energy_source()
  prototype.take_result = "dummy-item"
  return prototype
end

data:extend({
  add_equipment_properties
  {
    type = "active-defense-equipment",
    name = "dummy-active-defense-equipment",
    automatic = false,
    ability_icon = properties.sprite(),
    attack_parameters = properties.attack_parameters()
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
    recharging_animation = properties.animation(),
    spawn_and_station_height = 1
  },
  add_equipment_properties
  {
    type = "solar-panel-equipment",
    name = "dummy-solar-panel-equipment",
    power = "1J"
  }
})
