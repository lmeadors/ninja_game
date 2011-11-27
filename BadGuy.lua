local BadGuy = {}

function BadGuy.new(originX, originY, speed)

  assert(originY, "Required parameter missing")
  assert(originX, "Required parameter missing")
  assert(speed, "Required parameter missing")
  
  local badGuy = display.newGroup()
  badGuy.id = "badGuy"
  badGuy.originY = originY
  badGuy.originX = originX
  badGuy.speed = speed

  function badGuy:getImage()
    -- print("originX:", self.originX)
    local badGuyImage = display.newCircle(self, self.originX, self.originY, 30)
    badGuyImage:setFillColor(0,0,0,128)
    badGuyImage:setStrokeColor(255,255,255,128)
    badGuyImage.strokeWidth = 2
    badGuyImage.type="BadGuy"
    return badGuyImage  
    
  end

  function badGuy:run()
    
    local targetX = -40
    local targetY = originY
    
    local onCompleteCallback = function(image)
      display.remove(image)
      
    end
    
    local image = self:getImage()
    physics.addBody(image, {density=1, radius=30})
    transition.to(image, {time=self.speed, x=targetX, y=targetY, onComplete=onCompleteCallback})
    
  end
  
  return badGuy

end

return BadGuy
