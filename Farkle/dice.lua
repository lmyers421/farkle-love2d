Dice = Object.extend(Object)

function Dice:new(x)
    self.value = 1
    self.x = x
    self.y = 100
    self.selected = false
    self.locked = false
    self.frames = {}
    self.framesLocked = {}

    for i=1,6 do
        table.insert(self.frames, love.graphics.newImage("sprites/dice_sprite".. i ..".png"))
    end 

    for i=1,6 do
        table.insert(self.framesLocked, love.graphics.newImage("sprites/dice_sprite".. i .."_locked.png"))
    end 
end

function Dice:update(dt)
    if self.selected then
        if self.y < 400 then
            self.y = self.y + 700 * dt
        end
    else
        if self.y > 100 then
            self.y = self.y - 700 * dt
        end
    end
end

function Dice:draw()
    if self.locked then
        love.graphics.draw(self.framesLocked[self.value], self.x, self.y)
    else
        love.graphics.draw(self.frames[self.value], self.x, self.y)
    end
end

function Dice:roll()
    if not self.selected then
        self.value = math.random(1,6)
    else
        self.lock(self)
    end
end

function Dice:select()
        if self.selected then
            self.selected = false
            return
        end
        self.selected = true
end

function Dice:lock()
    self.locked = true
end