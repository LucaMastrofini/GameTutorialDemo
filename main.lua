function love.load()
    player = {}
    player.x = 400
    player.y = 300
    player.speed = 3
    --player.acceleration = 0.1
    player.sprite = love.graphics.newImage("sprites/parrot.png")

    background = love.graphics.newImage("sprites/background.png")
end

function love.update(dt)
    isMoving = false
    if love.keyboard.isDown("right") then
        --player.speed = player.speed + player.acceleration
        player.x = player.x + player.speed
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        --player.speed = player.speed + player.acceleration
        player.x = player.x - player.speed
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        --player.speed = player.speed + player.acceleration
        player.y = player.y + player.speed
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        --player.speed = player.speed + player.acceleration
        player.y = player.y - player.speed
        isMoving = true
    end
    if not isMoving then
        --player.speed = 3
    end
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(player.sprite, player.x, player.y)   
end 