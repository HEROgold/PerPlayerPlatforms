require("scripts.helpers")

--- @param event EventData.on_player_created
function on_player_created(event)
local player = game.get_player(event.player_index)
    if not player then return end
    if not player.valid then return end
    global.original_player_forces[player.index] = game.forces[player.force]

    -- Initialize the player platform
    local platform = player.force.create_space_platform({
        planet = player.surface.planet.name,
        starter_pack = data.raw["space-platform-starter-pack"]
    })
    if not platform then
        game.print("Failed to create platform for player: " .. player.name)
        return
    end

    local platform_force = create_platform_force(platform)
    set_platform_force(platform, platform_force)
    set_platform_settings(platform)
    player.force = platform_force
    player.teleport({0,0}, platform.surface)
end
