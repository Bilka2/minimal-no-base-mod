-- This contains all items, including ones that are core prototypes.
--   Core prototypes are named prototypes that the game requires to always exist, for example a "copper-cable" item.

local properties = require("properties")

-- These functions are applied directly to the prototype table
-- This allows to easily create many prototypes that inherit from the same base class/prototype, without copy pasting properties
local function add_item_properties(prototype)
  prototype = properties.add_icon(prototype)
  prototype.stack_size = 1
  return prototype
end

local function add_selection_tool_properties(prototype)
  prototype = add_item_properties(prototype)
  prototype.selection_color = properties.color()
  prototype.alt_selection_color = properties.color()
  prototype.selection_mode = "nothing"
  prototype.alt_selection_mode = "nothing"
  prototype.selection_cursor_box_type = "entity"
  prototype.alt_selection_cursor_box_type = "entity"
  return prototype
end

-- item prototypes, one of each, alphabetical by type
data:extend({
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
      type = "equipment-remote",
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
    attack_parameters = properties.attack_parameters()
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
  }
})

-- core item prototypes that are not contained in the above data:extend
data:extend({
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
  }
})
