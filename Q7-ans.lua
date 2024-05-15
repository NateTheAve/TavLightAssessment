function createJumpPopup()
    -- Create the popup box
    local popup = g_gui.createPopup("Jump Popup")
    local popupWidth = popup:getWidth()
    local popupHeight = popup:getHeight()

    -- Initialize button properties
    local button = popup:createButton("Jump", popupWidth, math.random(0, popupHeight))
    button:setSize(100, 50) -- Button size (width, height)

    -- Set the initial properties
    local clickCount = 0
    local maxClicks = math.random(5, 11)

    -- Function that moves the button horizontally
    local function moveButton()
        button:setPosition(button:getX() - 15, button:getY())
        if button:getX() <= 0 then
            -- Reset button to the starting position at a random height
            button:setPosition(popupWidth, math.random(0, popupHeight - button:getHeight()))
        end
    end

    -- Function handles button clicks
    local function onButtonClick()
        clickCount = clickCount + 1
        if clickCount < maxClicks then
            -- Reset button to the starting position at a random height
            button:setPosition(popupWidth, math.random(0, popupHeight - button:getHeight()))
        else
            -- Close the popup after the random number of clicks
            popup:close()
        end
    end

    -- Set the button click event handler
    button:onClick(onButtonClick)

    -- Create a timer to move the button continuously
    local function update()
        if popup:isOpen() then
            moveButton()
            g_gui.scheduleEvent(update, 10) -- Move button every 10 milliseconds
        end
    end
    g_gui.scheduleEvent(update, 10)
end

