require("scripts.helpers")

--- Swap the player's force to the platform's force. if allowed.
--- @param player LuaPlayer
--- @param platform LuaSpacePlatform
local function swap_to_platform_force(player, platform)
    if not settings.global["lock-platforms"].value then
        return
    end
    --- @type LuaForce?
    local platform_force = nil
    if platform_has_force(platform) then
        platform_force = get_platform_force(platform)
    end
    local current_force = game.forces[player.force]
    local target_force = current_force

    local platform_force_name = platform_force and platform_force.name or "nil"
    player.print("current_force" .. current_force.name)
    player.print("platform_force" .. platform_force_name)
    player.print("target_force" .. target_force.name)

    if current_force == platform_force then
        -- If the player is already on their platform force
        -- Switch back to their original force.
        target_force = global.original_player_forces[player.index]
        player.print("targeting original force: " .. target_force.name)
    elseif current_force == global.original_player_forces[player.index] then
        -- If the player is on their original force, switch to the platform force.
        if not platform_force then
            player.print("currently on original force, but platform force not found.")
            return
        end
        target_force = platform_force
        player.print("targeting platform force: " .. target_force.name)
    end

    if platform and not is_on_own_platform(player) then
        player.force = target_force
        player.print("switched to force (not own platform)" .. target_force.name)
    else
        -- When moving to player's own platform, sync research and recipes
        sync_forces(game.forces[player.force], target_force)
        player.force = target_force
        player.print("switched to force (own platform)" .. target_force.name)
    end
end

--- @param event EventData.on_player_changed_surface
function on_player_changed_surface(event)
    local player = game.players[event.player_index]
    --- @type LuaSurface
    local surface = game.surfaces[event.surface_index]
    local platform = surface.platform
    if not platform then
        return
    end

    swap_to_platform_force(player, platform)
end
