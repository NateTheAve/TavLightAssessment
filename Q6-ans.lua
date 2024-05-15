function castMovementSpell(playerId, spellName)
    local player = g_game.getPlayerById(playerId)
    if not player then
        return
    end

    -- Broadcast the spell casting message
    local message = player:getName() .. " says: " .. spellName
    g_game.broadcastMessage(player:getPosition(), message)

    -- Get player's current position and collision box size
    local startPosition = player:getPosition()
    local collisionBoxSize = player:getCollisionBoxSize()
    local moveDistance = collisionBoxSize * 12

    -- Determine the direction of movement (assuming a direction, e.g., to the right)
    local direction = {x = 1, y = 0} -- This can be adjusted based on the desired direction
    local endPosition = {
        x = startPosition.x + moveDistance * direction.x,
        y = startPosition.y + moveDistance * direction.y
    }

    -- Move the player to the new position
    player:setPosition(endPosition)

    -- Create and place the images of the player along the path
    local numImages = 5
    local imageInterval = moveDistance / (numImages + 1)
    local images = {}

    for i = 1, numImages do
        local imagePosition = {
            x = startPosition.x + imageInterval * i * direction.x,
            y = startPosition.y + imageInterval * i * direction.y
        }
        local image = g_game.createPlayerImage(player, imagePosition)
        local opacity = 1 - (i / numImages)
        image:setOpacity(opacity)
        table.insert(images, image)
    end

    -- Function to remove images after a quarter of a second
    local function removeImages()
        for _, image in ipairs(images) do
            image:remove()
        end
    end

    -- Schedule the removal of images after 0.25 seconds
    g_game.scheduleEvent(removeImages, 250)
end
