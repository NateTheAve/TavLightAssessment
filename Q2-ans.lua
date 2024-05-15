function printSmallGuildNames(memberCount)
    -- Construct SQL query to select guild names with max_members less than memberCount
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local query = string.format(selectGuildQuery, memberCount)
    
    local result = db.storeQuery(query)
    

    if result ~= nil then
       
        -- Loop through the result set and print guild names
        while result:next() do
            local guildName = result:getDataString("name")
            print(guildName)
        end
        result:free()
    else
        print("Error: Unable to execute query or empty result set")
    end
end
