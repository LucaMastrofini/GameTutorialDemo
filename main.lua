function love.load()
    camera = require 'libraries/camera' 
    cam = camera() -- include the camera library
    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    gameMap = sti('maps/mapDemo.lua')  -- loading the map created with Tiled
    love.graphics.setDefaultFilter('nearest', 'nearest') -- set nearest neighbor filtering on upscaling and downscaling to prevent blurriness


    player = {}
    player.x = 400
    player.y = 300
    player.speed = 3
    -- player.acceleration = 0.1
    -- player.sprite = love.graphics.newImage("sprites/parrot.png")
    player.spriteSheet = love.graphics.newImage("sprites/player-sheet.png")  -- loading the sprite sheet (in this case the player's walking animations)
    background = love.graphics.newImage("sprites/background.png") -- loading the background image
    -- creating a grid for the sprite sheet 12x18 is the size of each frame in the sprite sheet    
    player.grid = anim8.newGrid(12,18,player.spriteSheet:getWidth(), player.spriteSheet:getHeight())    
    player.animations = {}

    -- defining the animations for each direction
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.2)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.2)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.2)

    -- defing variable to switch between animations
    player.anim = player.animations.down
end

function love.update(dt)
    isMoving = false
    if love.keyboard.isDown("right") then
        --player.speed = player.speed + player.acceleration
        player.x = player.x + player.speed
        isMoving = true
        player.anim = player.animations.right
    end
    if love.keyboard.isDown("left") then
        --player.speed = player.speed + player.acceleration
        player.x = player.x - player.speed
        isMoving = true
        player.anim = player.animations.left
        
    end
    if love.keyboard.isDown("down") then
        --player.speed = player.speed + player.acceleration
        player.y = player.y + player.speed
        isMoving = true
        player.anim = player.animations.down
    end
    if love.keyboard.isDown("up") then
        --player.speed = player.speed + player.acceleration
        player.y = player.y - player.speed
        isMoving = true
        player.anim = player.animations.up
    end
    if not isMoving then
        player.anim:gotoFrame(2) 
    end
    player.anim:update(dt)
    cam:lookAt(player.x, player.y)  -- make the camera follow the player

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    if cam.x < w/2 then
        cam.x = w/2
    end
    if cam.y < h/2 then
        cam.y = h/2
    end
    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end
    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)   
    end
     -- update the animation (dt is delta time, the time elapsed since the last frame)
end

function love.draw()
    cam:attach()  -- begin camera
        gameMap:drawLayer(gameMap.layers["Ground"])  -- drawing the map layer named "Tile Layer 1"
        gameMap:drawLayer(gameMap.layers["Trees"]) -- drawing the map layer named "Trees"
        player.anim:draw(player.spriteSheet, player.x, player.y, nil, 6, nil, 6, 9)  -- source image, x, y, rotation, scale x, scale y, offset x, offset y
    cam:detach()  -- end camera
end 