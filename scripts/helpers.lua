--- Get all platforms related to a player.
--- @param player LuaPlayer
function get_platforms(player)
    return player.force.platforms
end

--- @param player LuaPlayer
function is_remote_view(player)
    -- physical_controller_type :: Read defines.controllers
    -- The player's "physical" controller. When a player is in the remote controller,
    -- this specifies the controller they will return to. When the player is not in the remote controller,
    -- this is equivalent to LuaPlayer::controller_type.
    return player.controller_type == defines.controllers.remote
end

--- Check if a player is looking at their own platform.
--- @param player LuaPlayer
function is_on_own_platform(player)
    for _, surface in pairs(game.surfaces) do
        for index, platform in pairs(get_platforms(player)) do
            if platform.surface.index == index then
                return true
            end
        end
    end
    return false
end

--- Check if a platform has a custom force.
--- @param platform LuaSpacePlatform
function platform_has_force(platform)
    return game.forces["platform_" .. platform.surface.index] ~= nil
end

--- Get the force associated with a platform.
--- @param platform LuaSpacePlatform
--- @return LuaForce
function get_platform_force(platform)
    return game.forces["platform_" .. platform.surface.index]
end

--- @param platform LuaSpacePlatform
function set_platform_settings(platform)
    local force = platform.force
    if settings.player["spawn-on-platform"].value then
        force.set_spawn_position({ 0, 0 }, platform.surface)
    end
end

--- @param platform LuaSpacePlatform
function create_platform_force(platform)
    return game.create_force("platform_" .. platform.surface.index)
end

--- @param platform LuaSpacePlatform
function set_platform_force(platform, force)
    platform.force = force
end

--- Synchronize forces their recipes and technologies.
--- @param original LuaForce
--- @param new LuaForce
function sync_forces(original, new)
    -- sync recipes
    for _, recipe in pairs(original.recipes) do
        if recipe.enabled then
            new.recipes[recipe.name].enabled = true
        end
    end
    -- sync technologies
    for _, technology in pairs(original.technologies) do
        if technology.researched then
            new.technologies[technology.name].researched = true
        end
    end
end
