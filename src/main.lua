local grid = require("script.grid")
local circles = require("script.circles")
local points = require("script.points")
local render = require("script.render")
local info = require("script.info")

local screen_width, screen_height
local map_cols, map_rows

local tile_size = 32
local total_cirlces = 10
local bound = 0.8

function love.load()
  local ceil = math.ceil
  local lg = love.graphics
  
  screen_width, screen_height = lg.getDimensions()
  map_cols, map_rows = ceil( screen_width / tile_size ), ceil( screen_height / tile_size )  
  
  --init stuf
  grid.init(screen_width, screen_height, map_cols, map_rows, tile_size)
  circles.init(screen_width, screen_height, total_cirlces)
  points.init(map_cols, map_rows, tile_size)
  render.init(map_cols, map_rows, tile_size)
  info.init()
  
  grid.setBound(bound)
  render.setBound({0.6, 0.8})
  
  --Circle data
  points.setCircles(circles.getInstances())
  grid.setPoints(points.getInstances())
  render.setPoints(points.getInstances())
  
  --render tile
  render.setRender(3)
end

function love.update(dt)
  --move circles
  circles.update(dt)
  
  --update points and corners with new circle data
  points.update(dt)
  grid.update(dt)
  render.update(dt)
  
  info.draw()
end

function love.draw()
  grid.draw()
  circles.draw()
  points.draw()
  render.draw()
  
  info.draw()
end