Dice = Object.extend(Object)

function Dice:new(x)
    self.value = 1
    self.selectedX = x
    self.x = love.math.random(50,400)
    self.startingX = self.x
    self.y = love.math.random(50, 250)
    self.startingY = self.y
    self.r = (love.math.random(0,628))/100
    self.startingR = self.r
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

    self.width = self.frames[self.value]:getWidth()
    self.height = self.frames[self.value]:getHeight()

end

function Dice:update(dt)

end

function Dice:draw()
    if self.locked then
        local imageLocked = self.framesLocked[self.value]
        love.graphics.draw(imageLocked, self.x + self.width/2, self.y + self.height/2, self.r, 1, 1, self.width/2, self.height/2)
        -- hitbox love.graphics.rectangle("line", self.x, self.y,image:getWidth(), image:getHeight())
    else
        local image = self.frames[self.value]
        love.graphics.draw(image, self.x + self.width/2, self.y + self.height/2, self.r, 1, 1, self.width/2, self.height/2)
        -- hitbox love.graphics.rectangle("line", self.x, self.y,image:getWidth(), image:getHeight())
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
            Flux.to(self, .3, {x = self.startingX, y = self.startingY, r = self.startingR}):ease("expoout")
            self.selected = false
            return
        end
        Flux.to(self, .3, {x = self.selectedX, y = 400, r = 0}):ease("expoout")
        self.selected = true
end

function Dice:lock()
    self.locked = true
end