function on_init()
    if not global.original_player_forces then
        --- @type table<number, LuaForce>
        global.original_player_forces = {}
    end
end
