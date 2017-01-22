local circles_color = { 191, 0, 0 }

local instances
local screen_width, screen_height

local function createCircle()  
  local random = math.random
  local r = random( 16, 64 )
  local circle = {
    r= r,
    dx = random( -1, 1 ),
    dy = random( -1, 1 ),
    speed = random( 6, 50 ),
    px = random( r, screen_width - r ),
    py = random( r, screen_height - r ),
  }  
  return circle
end

local function init(sw, sh, count)
  screen_width, screen_height = sw, sh
  instances = {}  
  for i=1, count do
    local circle = createCircle()
    instances[i]  = circle
  end
end

local function update(dt)
  for i, c in ipairs( instances ) do
    c.px = c.px + c.dx * dt * c.speed
    c.py = c.py + c.dy * dt * c.speed          
    if c.px - c.r <= 0 then c.dx = 1 end
    if c.px + c.r >= screen_width then c.dx = -1 end
    if c.py - c.r <= 0 then c.dy = 1 end    
    if c.py + c.r >= screen_height then c.dy = -1 end
  end
end

local function draw()
  local lg = love.graphics
  lg.setColor( circles_color ) 
  for i, c in ipairs( instances ) do lg.circle( "line", c.px, c.py, c.r ) end
end

local Circles = {
  init= init,
  update= update,
  draw= draw,
  
  getInstances = function() return instances end
}
 
return Circles