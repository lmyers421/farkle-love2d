if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "classic"
    require "dice"
    DiceList = {}
    local d1 = Dice(100)
    table.insert(DiceList, d1)
    local d2 = Dice(150)
    table.insert(DiceList, d2)
    local d3 = Dice(200)
    table.insert(DiceList, d3)
    local d4 = Dice(250)
    table.insert(DiceList, d4)
    local d5 = Dice(300)
    table.insert(DiceList, d5)
    local d6 = Dice(350)
    table.insert(DiceList, d6)

    DiceSelected = {}
    DiceLocked = {}

    RollScore = 0
    TotalScore = 0
end

function love.update(dt)
    for i,v in ipairs(DiceList) do
        v:update(dt)
    end
end

function love.draw()
    for i,v in ipairs(DiceList) do
        v:draw()
    end
    love.graphics.print("".. RollScore, 10, 10)
    love.graphics.print("".. TotalScore, 10, 30)
end

function love.keypressed(key)
    if key ==  "space" then
        for i,v in ipairs(DiceList) do
            v:roll()
        end
    end
    if key == "return" then
        CalculateRollScore()
    end
end

function love.mousereleased()
    local mouse_x = love.mouse.getX()
    local mouse_y = love.mouse.getY()
    for i,v in ipairs(DiceList) do
        if mouse_x > v.x and mouse_x < v.x + 45 and mouse_y > v.y and mouse_y < v.y + 45 and not v.locked then
            v:select()
            CalculateRollScore()
        end
    end
    
end

function CalculateRollScore()
    RollScore = 0
    print("entered")
    for i,v in ipairs(DiceList) do
        if v.selected then
            table.insert(DiceSelected, v)
        end
    end
    print("Interted selected")
    for i,v in ipairs(DiceSelected) do
        if v.value == 1 then
            RollScore = RollScore + 100
        elseif v.value == 5 then
            RollScore = RollScore + 50
        end
    end
    if CheckForStraight(DiceSelected) then
        RollScore = 1500
    end
    DiceSelected = {}
end

function CheckForStraight(list)
    local straight = false
    local one = false
    local two = false
    local three = false
    local four = false
    local five = false
    local six = false
    for i,v in ipairs(list) do
        if v.value == 1 then
            one = true
        end
        if v.value == 2 then
            two = true
        end
        if v.value == 3 then
            three = true
        end
        if v.value == 4 then
            four = true
        end
        if v.value == 5 then
            five = true
        end
        if v.value == 6 then
            six = true
        end
    end
    if one and two and three and four and five and six then
        straight = true
    end
    return straight
end










local love_errorhandler = love.errorhandler
function love.errorhandler(msg)
---@diagnostic disable-next-line: undefined-global
    if lldebugger then
        error(msg,2)
    else
        return love_errorhandler
    end
    
end