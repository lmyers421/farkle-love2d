Button = Object.extend(Object)

function Button:new(x,y,image)
    self.x = x
    self.y = y
    self.positionUp = self.y
    self.positionDown = self.y + 5
    self.locked = false
    self.image = image
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Button:update(dt)
end

function Button:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Button:clicked()
    Flux.to(self, .05, {x = self.x, y = self.positionDown}):ease("linear")
    Flux.to(self, .05, {x = self.x, y = self.positionUp}):ease("linear"):delay(.1)
end


