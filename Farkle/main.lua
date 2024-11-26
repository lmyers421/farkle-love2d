if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    Object = require "classic"
    Flux = require "flux"
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
    Flux.update(dt)

    local mouse_x = love.mouse.getX()
    local mouse_y = love.mouse.getY()

    for i,v in ipairs(DiceList) do
        if mouse_x > v.x and mouse_x < v.x + v.width and mouse_y > v.y and mouse_y < v.y + v.height and not v.locked then
            print("hovering over hitbox")
        end
    end

end

function love.draw()
    for i,v in ipairs(DiceList) do
        v:draw()
    end
    love.graphics.print("".. RollScore, 10, 10)
    love.graphics.print("".. TotalScore, 10, 30)

    love.graphics.print("".. love.mouse.getX(), 10,80)
    love.graphics.print("".. love.mouse.getY(), 10,100)
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
        if mouse_x > v.x and mouse_x < v.x + v.width and mouse_y > v.y and mouse_y < v.y + v.height and not v.locked then
            v:select()
            CalculateRollScore()
        end
    end
    
end

function CalculateRollScore()
    RollScore = 0
    for i,v in ipairs(DiceList) do
        if v.selected then
            table.insert(DiceSelected, v)
        end
    end
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
    local values = {}
    for i,v in ipairs(list) do
        table.insert(values, i, v.value)
    end
    if #values < 6 then
        return straight
    end
    table.sort(values)
    for i=1,6 do
        if values[i] == i then
            straight = true
        else
            straight = false
        end
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