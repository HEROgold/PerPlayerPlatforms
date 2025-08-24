require("events.on_init")
require("events.on_player_created")
require("events.on_player_changed_surface")
require("events.on_entity_died")

script.on_init(on_init)

script.on_event(defines.events.on_player_created, on_player_created)
script.on_event(defines.events.on_player_changed_surface, on_player_changed_surface)
script.on_event(defines.events.on_entity_died, on_entity_died, {
    {filter = "name", name = "space-platform"},
    {filter = "name", name = "space-platform-starter-pack"}
})
