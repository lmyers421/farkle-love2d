Dice = Object.extend(Object)

function Dice:new(x)
    self.value = 1
    self.x = x
    self.y = 100
    self.selected = false
    self.locked = false
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
        love.graphics.rectangle("line", self.x, self.y, 45, 45, 5, 5)
    else
        love.graphics.rectangle("line", self.x, self.y, 45, 45)
    end
    love.graphics.print("" .. self.value, self.x + 20, self.y + 15)
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