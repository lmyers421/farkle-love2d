Button = Object.extend(Object)

function Button:new()
    self.x = 550
    self.y = 450
    self.locked = false
    self.image = love.graphics.newImage("sprites/rollbutton_sprite.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Button:update(dt)
end

function Button:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
