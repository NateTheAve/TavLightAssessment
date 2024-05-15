
function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player) --after a delay of 1000 milliseconds, changes storage value to -1
    if player:getStorageValue(1000) == 1 then
        addEvent("releaseStorage", 1000, player)
    end
    return true
end