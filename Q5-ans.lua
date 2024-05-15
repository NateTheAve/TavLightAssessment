function castAttackSpell(playerId, spellPower, areaRadius, spellName)
    local player = g_game.getPlayerById(playerId)
    if not player then
        return
    end

    -- Broadcast the spell casting message
    local message = player:getName() .. " says: " .. spellName
    g_game.broadcastMessage(player:getPosition(), message)

    -- Define the area of effect
    local area = player:getPosition()

    -- Create a timer to control the duration of the spell
    local duration = 3 -- in seconds
    local endTime = os.time() + duration

    -- Continuously apply the spell effect within the area for the duration
    while os.time() < endTime do
        -- Get all creatures in the area
        local creatures = Game.getCreaturesInArea(area:asSquare(areaRadius))

        -- Apply the spell effect to each creature in the area
        for _, creature in ipairs(creatures) do
            if creature:isMonster() then
                -- Calculate damage based on the spell power
                local damage = math.random(1, spellPower)

                -- Apply damage to the creature
                creature:dealDamage(player, DAMAGE_PHYSICAL, damage)
            end
        end

        -- Sleep for a short duration before applying the spell effect again
        sleep(1) -- Sleep for 1 second (1000 milliseconds)
    end
end