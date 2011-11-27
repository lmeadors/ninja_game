-- module(..., package.seeall);

local Game = {}

function Game.new()
  
  local boop = audio.loadSound("assets/beep.caf")
  local game = display.newGroup() 
  
  game.id = "game"
  
  -- modules
  Star = require "Star"
  BadGuy = require "BadGuy"
  local physics = require "physics"
  
  -- display objects 
  local sky, player

  -- functions 
  local initGround
  
  -- display groups
  -- local stars
  -- local badGuys
  
  -- this is local only
  function initGround()
    sky = display.newRect( game, _G.STAGE_LEFT, _G.STAGE_TOP, _G.STAGE_WIDTH, _G.STAGE_HEIGHT )
    sky:setFillColor(0, 64, 32)
  end
  
  function initPlayer()
    player = display.newImageRect(game, "assets/Player.png", 27, 40)
    player.x = 10
    player.y = HALF_HEIGHT
    
  end

  -- this is public because it's "a property of the game display group" (game:___)
  function game:startGame()
    initGround()
    initPlayer()
    startListeners()
    print "creating stars table?"
    -- stars = display.newGroup()
    -- badGuys = display.newGroup()
    print "inserting stars into game"
    -- game:insert(stars)
    -- game:insert(badGuys)
    print "start game done"
  end
  
  function startListeners()
    physics.start()
    Runtime:addEventListener("touch", fireMissile)
    Runtime:addEventListener("enterFrame", updateFrame)
    Runtime:addEventListener( "collision", onCollision )
  end

  function stopListeners()
    Runtime:removeEventListener( "collision", onCollision )
    Runtime:removeEventListener("enterFrame", updateFrame)
    Runtime:removeEventListener("touch", fireMissile)
    physics.pause()
    physics.stop()
  end

  function updateFrame(event)
    if math.random(1, 30) == 1 then
      -- print "fire a bad guy now!"
      createBadGuy()
    end
  end
  
  function createBadGuy()
    local badGuyX = _G.STAGE_WIDTH + 40
    local badGuyY = math.random(_G.STAGE_TOP, _G.STAGE_HEIGHT)
    -- print("badGuyX", badGuyX)
    local badGuy = BadGuy.new(badGuyX, badGuyY, math.random(2000, 5000))
    -- table.insert(badGuys, badGuy)
    -- print ("badguy inserted: " .. tostring(#badGuys) .. " total bad guys in table")
    
    -- for k,v in pairs(badGuys) do print(k,v) end
    
    
    badGuy:run()
  end
  
  function fireMissile(event)
    if event.phase == "ended" then
      if event.x > player.x then
        -- print "play the boop"
        audio.play(boop)
        -- print "create a star"
        local star = Star.new(player.x, player.y, event.x, event.y)
        -- print "insert star in table"
        -- table.insert(stars, star)
        -- print ("star inserted: " .. tostring(#stars) .. " total stars in table")
        -- print "fire star"
        star:fire()
      else
        -- print "can't throw behind you, that's not safe"
      end
    end
  end
  
  
  function onCollision(event)
    if (event.phase == "ended") then
      if (event.object1.type ~= event.object2.type) then
        print "A COLLISION!"
        print "Object 1:"
        for k,v in pairs(event.object1) do print(k,v) end
        print "Object 2:"
        for k,v in pairs(event.object2) do print(k,v) end
        display.remove(event.object1)
        display.remove(event.object2)
      end
    end
  end
  
  return game

end

return Game
