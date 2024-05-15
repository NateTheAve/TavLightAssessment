function do_sth_with_PlayerParty(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()
    local membersToRemove = {} -- List to store members to be removed
    
    -- Walk through each member in the party
    for _, member in ipairs(party:getMembers()) do
        -- Check if the member's name matches the provided membername
        if member:getName() == membername then
            -- Add the member to the list of members to be removed
            table.insert(membersToRemove, member)
        end
    end
    
    -- Remove the members found from the party
    for _, member in ipairs(membersToRemove) do
        party:removeMember(member)
    end
end
