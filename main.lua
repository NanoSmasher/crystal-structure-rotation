point = {}

point[1] = {x=50,y=50,g=1,u=1}
point[2] = {x=50,y=-50,g=1,u=1}
point[3] = {x=-50,y=50,g=1,u=1}
point[4] = {x=-50,y=-50,g=1,u=1}
point[5] = {x=150,y=50,g=1,u=0}
point[6] = {x=0,y=0,g=0,u=1}
point[7] = {x=100,y=0,g=0,u=1}
point[8] = {x=0,y=100,g=0,u=1}
point[9] = {x=-100,y=0,g=0,u=1}
point[10] = {x=0,y=-100,g=0,u=1}

function love.load()
	size = 600
	love.window.setTitle("Low-level rotations of Crystal structure faces")
	love.window.setMode(size,size)
	origin = size/2
	scale = size*5/6
	xzone = 0
	drag = 0
	theta = 0
	coord = {}
	radius = 50
end

function love.keyreleased(key)
	if key == "escape" then love.event.push("quit") end
	if key == "a" then t = t + math.pi/4 end
end

function love.mousepressed(x, y, button)
   if button == "l" and (math.sqrt((x-xzone)*(x-xzone)+(y-size*15/16)*(y-size*15/16))) < size/10  then
      drag = 1
   end
end

function love.mousereleased()
   drag = 0
end

function love.update(dt)
	local x = love.mouse.getX()
	if drag==1 and x>=size/12 and x<=size*11/12 then
		xzone = x - size/12
		theta = xzone/scale*2*math.pi
	end
	
	for i=1,#point do
		-- x' = x * cos(theta) - y * sin(theta)
		-- y' = x * sin(theta) - y * cos(theta)
		newx = point[i].x*math.cos(theta) - point[i].y*math.sin(theta)		-- lines to code
		newy = point[i].x*math.sin(theta) + point[i].y*math.cos(theta)		-- lines to code
		coord[i] = {x=newx, y=newy, g=point[i].g, u=point[i].u}
	end
end

function love.draw()
	
	-- Start of grid system
	love.graphics.circle("fill",origin,origin,3,16)
	love.graphics.setColor(200,200,200,50)
	
	for i=1,5 do
		love.graphics.line(i*size/6,0,i*size/6,size)
		love.graphics.line(0,i*size/6,size,i*size/6)
	end
	love.graphics.setColor(255,255,255)
	-- End of grid system
	
	-- Start of slider control
	love.graphics.line(size/12,size*15/16,size*11/12,size*15/16)
	love.graphics.circle("fill",xzone+size/12,size*15/16,size/64,32)
	love.graphics.print("theta = "..xzone/scale*360,size*13/16,size*31/32)
	-- End of slider control
	
	--[[
	
	~~~ Special Note ~~~
	Love2D's coordinate system starts from the top-left.
	The standard Cartesian system starts from the bottom-left.
	y is negative to flip the love system to the Cartesian system.

	]]--

	-- Start of face
	for j=1,#coord do
		if coord[j].g==1 then love.graphics.setColor(200,200,200,150)
		else love.graphics.setColor(255,255,255) end
		love.graphics.circle("fill",coord[j].x+origin, origin-coord[j].y,radius,64)
	end
	-- End of face
	
end