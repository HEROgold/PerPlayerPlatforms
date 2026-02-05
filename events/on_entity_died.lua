--- When a space platform is destroyed, remove the old force, and recreate the player platform.
--- @param event EventData.on_entity_died
function on_entity_died(event)
    local force = event.entity.force
    local player = force.players[1]
    on_player_created({
        name = defines.events.on_player_created,
        player_index = player.index,
        tick = event.tick,
    })
    game.forces[force.name] = nil
end
