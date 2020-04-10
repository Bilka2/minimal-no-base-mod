-- Note: None of these properties are meant for use in a normal mod,
--   because they mostly produce empty images and have no function in-game beyond being loadable.
-- This file only contains properties that are large, or used very often.

-- All properties are based on the formats documented on the wiki: https://wiki.factorio.com/Prototype_overview

local properties = {}

properties.sound_filename = "__core__/sound/achievement-unlocked.ogg"
properties.sprite_filename = "__core__/graphics/empty.png"
properties.sprite_filename_32px = "__core__/graphics/factorio-icon.png"
properties.render_layer = "object"

-- This function is applied directly to the prototype table and adds the icon to it
properties.add_icon = function(prototype)
  prototype.icon = properties.sprite_filename
  prototype.icon_size = 1
  return prototype
end

-- Any property that is a table is returned via a function.
--   This means that everything gets a copy of the table, not a reference to the table.

properties.color = function() return {1, 1, 1, 1} end -- white
properties.bounding_box = function() return {{0, 0}, {0, 0}} end
-- splitter: bounding box width must be > 0.5, height must be > 1
properties.nonzero_bounding_box = function() return {{-1.0, -0.5}, {0.1, 0.1}} end
properties.vector = function() return {0, 0} end
properties.sound = function()
  return {filename = properties.sound_filename}
end
properties.sprite = function()
  return
  {
    filename = properties.sprite_filename,
    size = 1
  }
end
-- properties.sprite() is also used as SpriteVariations and Sprite4Way
properties.rotated_sprite = function()
  local sprite = properties.sprite()
  sprite.direction_count = 1
  return sprite
end
properties.rotated_sprite_custom_direction_count = function(direction_count)
  local sprite = properties.sprite()
  sprite.filename = properties.sprite_filename_32px
  sprite.direction_count = direction_count
  return sprite
end
properties.sprite_8_way = function()
  return
  {
    north = properties.sprite(),
    north_east = properties.sprite(),
    east = properties.sprite(),
    south_east = properties.sprite(),
    south = properties.sprite(),
    south_west = properties.sprite(),
    west = properties.sprite(),
    north_west = properties.sprite()
  }
end
properties.animation = function()
  return properties.sprite()
end
-- properties.animation() is also used as AnimationVariations and Animation4Way
properties.rotated_animation = function()
  local animation = properties.animation()
  animation.direction_count = 1
  return animation
end
properties.attack_parameters = function()
  return
  {
    type = "stream", -- required by fluid turret
    ammo_type = {category = "dummy-ammo-category"},
    range = 1,
    cooldown = 1,
    animation = properties.rotated_animation() -- required by unit
  }
end
properties.rail_piece_layers = function()
  return
  {
    metals = properties.sprite(),
    backplates = properties.sprite(),
    ties = properties.sprite(),
    stone_path = properties.sprite()
  }
end
properties.rail_pictures = function()
  return
  {
    straight_rail_horizontal = properties.rail_piece_layers(),
    straight_rail_vertical = properties.rail_piece_layers(),
    straight_rail_diagonal_left_top = properties.rail_piece_layers(),
    straight_rail_diagonal_right_top = properties.rail_piece_layers(),
    straight_rail_diagonal_right_bottom = properties.rail_piece_layers(),
    straight_rail_diagonal_left_bottom = properties.rail_piece_layers(),
    curved_rail_vertical_left_top = properties.rail_piece_layers(),
    curved_rail_vertical_right_top = properties.rail_piece_layers(),
    curved_rail_vertical_right_bottom = properties.rail_piece_layers(),
    curved_rail_vertical_left_bottom = properties.rail_piece_layers(),
    curved_rail_horizontal_left_top = properties.rail_piece_layers(),
    curved_rail_horizontal_right_top = properties.rail_piece_layers(),
    curved_rail_horizontal_right_bottom = properties.rail_piece_layers(),
    curved_rail_horizontal_left_bottom = properties.rail_piece_layers(),
    rail_endings = properties.sprite_8_way()
  }
end
properties.oriented_cliff_prototype = function()
  return
  {
    collision_bounding_box = properties.bounding_box(),
    pictures = {properties.sprite()},
    fill_volume = 1
  }
end
properties.electric_energy_source = function()
  return
  {
    type = "electric",
    buffer_capacity = "1J",
    input_flow_limit = "1W",
    -- this works even for entities that technically *output* energy
    usage_priority = "primary-input"
  }
end
properties.void_energy_source = function()
  return {type = "void"}
end
properties.burner_energy_source = function()
  return {type = "burner", fuel_inventory_size = 1}
end
properties.wire_connection_point = function()
  return
  {
    wire = {},
    shadow = {}
  }
end
properties.damage_prototype = function()
  return {amount = 1, type = "physical"}
end
properties.fluid_box = function()
  return {pipe_connections = {}}
end
properties.heat_buffer = function()
  return
  {
    -- because min temp defaults to 15 and this must be >= min temp
    max_temperature = 15,
    specific_heat = "1J",
    max_transfer = "1J"
  }
end

return properties