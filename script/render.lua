local luams = require("lib.LuaMarchingSquares.src.luams")

local RENDER_TILE = "RENDER_TILE"
local RENDER_LINE = "RENDER_LINE"
local RENDER_LINE_INTERPOLATE = "RENDER_LINE_INTERPOLATE"

local types = {RENDER_TILE, RENDER_LINE, RENDER_LINE_INTERPOLATE}
local current_render
local points

local map_cols, map_rows
local tile_size
local bound
local layers

local tile_color = { 15, 95, 15, 126 }

local function init(mc, mr, ts)
  map_cols, map_rows = mc, mr
  tile_size = ts
end

local function updateLines()
  layers = luams.getContour(points, bound)
  local layer = #layers
  for l=1, layer do
    local path = #layers[l]
    for p=1, path do
      local point = #layers[l][p]
      local line = layers[l][p]
      for n=1, point, 2 do        
        line[n], line[n+1] = line[n] * tile_size, line[n+1] * tile_size        
      end
    end
  end
end

local function update(dt)
  if current_render == RENDER_LINE then
    luams.setInterpolate(false)
    updateLines()
  elseif current_render == RENDER_LINE_INTERPOLATE then
    luams.setInterpolate(true)
    updateLines()
  else layers = nil end
end

local function drawTile()
  local lg = love.graphics
  lg.setColor(tile_color)
  
  local x, y
  for r=1, map_rows do    
    y =  (r - 1) * tile_size
    for c=1, map_cols do
      if points[r][c] > bound then 
        x = (c -1) * tile_size
        lg.rectangle( "fill", x, y, tile_size, tile_size )
      end
    end
  end
end

local function drawLine()   
  local lg = love.graphics
  local layer = #layers
  for l=1, layer do
    local path = #layers[l]
    for p=1, path do
      lg.line(layers[l][p])
    end    
  end  
end

local function draw()
  if current_render == RENDER_TILE then drawTile()
  elseif current_render == RENDER_LINE then drawLine()
  elseif current_render == RENDER_LINE_INTERPOLATE then drawLine()
  end
end

local Render = {
  init= init,
  update= update,
  draw= draw,
  
  getTypes= function() return types end,  
  setPoints = function(value) points = value end,
  setBound = function(value) bound = value end,
  setRender = function(value) current_render = types[value] end,
}

return Render