module(..., package.seeall);

-- local Game = {}

function Game.new()
  
  local boop = audio.loadSound("assets/beep.caf")
  local game = display.newGroup() 
  
  game.id = "game"
  
  -- modules
  Star = require "Star"
  
  -- display objects 
  local sky, player

  -- functions 
  local initGround
  
  -- display groups
  local stars
  
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
    stars = display.newGroup()
    print "inserting stars into game"
    game:insert(stars)
    print "start game done"
  end
  
  function startListeners()
    Runtime:addEventListener("touch", fireMissile)
  end

  function stopListeners()
    Runtime:removeEventListener("touch", fireMissile)
  end

  function fireMissile(event)
    if event.phase == "ended" then
      if event.x > player.x then
        print "play the boop"
        audio.play(boop)
        print "create a star"
        local star = Star.new(player.x, player.y, event.x, event.y)
        print "insert star in table"
        table.insert(stars, star)
        print ("star inserted: " .. tostring(table.getn(stars)) .. " stars in table")
        print "fire star"
        star:fire()
      else
        print "can't throw behind you, that's not safe"
      end
    end
  end

  return game

end
