local Star = {}
-- Star.__index = Star
-- module(..., package.seeall);

function Star.new(originX, originY, touchX, touchY)
  assert(originX, "Required parameter missing")
  assert(originY, "Required parameter missing")
  assert(touchX, "Required parameter missing")
  assert(touchY, "Required parameter missing")

  local speed
  local star = display.newGroup()
  star.id = "star"
  star.speed = 2000
  star.touchX = touchX
  star.touchY = touchY
  star.originX = originX
  star.originY = originY
  
  function star:getImage()
    local starImage = display.newCircle( self, originX, originY, 10)
    starImage:setFillColor(255,255,255,128)
    starImage:setStrokeColor(0,0,0,128)
    starImage.strokeWidth = 1
    return starImage  
  end
  
  function star:fire()
    
    local dx = self.touchX - self.originX
    local dy = self.touchY - self.originY
    local angle = math.atan(dy/dx)
    -- local distance = 250
    local distance = _G.STAGE_WIDTH*2
    local targetX = originX + (distance * math.cos(angle))
    local targetY = originY + (distance * math.sin(angle))
    
    local onCompleteCallback = function(starImage)
      display.remove(starImage)
    end
    
    transition.to(self:getImage(), {time=self.speed, x=targetX, y=targetY, onComplete=onCompleteCallback})
  end

  
  return star
  
end

return Star