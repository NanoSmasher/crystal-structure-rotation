require("data")

function love.update(dt)
	local a = love.mouse.getX()
	for i=1,#coord do coord[i] = nil end

	-- code for
	if drag==1 and a>=size/12 and a<=size*11/12 then xzone = a - size/12 end
	theta = xzone/scale*2*math.pi
	locktheta()
	
	for i=1,#point do
		local x = point[i].x
		local y = point[i].y

--[[-------------------------------------------------
---------------------CODE BELOW----------------------
#
#
#	HELPFUL NOTES:
#
#	[1] Use the following variables to help you code:
#
#        x : The point's original x location
#        y : The point's original y location
#        theta : The radian to rotate in the 'z' axis
#
#    [3] Use these functions to help you code:
#
#        math.cos([variable])
#        math.sin([variable])
]]		
		
		newx = x*math.cos(theta) - y*math.sin(theta)		-- lines to code
		newy = x*math.sin(theta) + y*math.cos(theta)		-- lines to code
		
---------------------CODE ABOVE-----------------------
------------------------------------------------------
		coord[i] = {x=newx, y=newy, g=point[i].g, u=point[i].u,v=point[i].v}
	end
	
end

-- initialize all variables and states
function love.load()
	size = 600
	love.window.setTitle("Low-level rotations of Crystal structure faces")
	love.window.setMode(size,size)
	origin = size/2
	scale = size*5/6
	xzone = 0
	drag = 0
	theta = 0
	point = {}
	point = fcc100()
	coord = {}
	radius = 50
	draw_grey = -1
	draw_unit = 0
	epilson = 0.1
	
	--buttons: FCC[100], FCC[110], FCC[111], BCC[100], BCC[110], grey, unit
	button = {
		{name = "fcc100",	x1 = 10,	y1 = 20,	x2 = 70,	y2 = 40},
		{name = "fcc110",	x1 = 80,	y1 = 20,	x2 = 140,	y2 = 40},
		{name = "fcc111",	x1 = 150,	y1 = 20,	x2 = 210,	y2 = 40},
		{name = "bcc100",	x1 = 220,	y1 = 20,	x2 = 280,	y2 = 40},
		{name = "bcc110",	x1 = 290,	y1 = 20,	x2 = 350,	y2 = 40},
		{name = "grey",		x1 = 360,	y1 = 20,	x2 = 420,	y2 = 40},
		{name = "unit",		x1 = 430,	y1 = 20,	x2 = 490,	y2 = 40}
	}
end

-- Hit the Escape key to quit program
function love.keyreleased(key)
	if key == "escape" then love.event.push("quit") end
end

function love.mousepressed(x, y, b)
	if b == "l" then
		if (math.sqrt((x-xzone)*(x-xzone)+(y-size*15/16)*(y-size*15/16))) < size/10  then
			drag = 1 -- informs program user is over the theta slider
		else
			local on = sethover(x,y)
			if (on=='fcc100') then point = fcc100()
			elseif (on=='fcc110') then point = fcc110()
			elseif (on=='fcc111') then point = fcc111()
			elseif (on=='bcc100') then point = bcc100()
			elseif (on=='bcc110') then point = bcc110()
			elseif (on=='grey') then 
				if draw_grey == -1 then draw_grey = 0
				else  draw_grey = draw_grey == 0 and 1 or -1 -- Please, please don't ask
				end
				
			elseif (on=='unit') then draw_unit = draw_unit == 0 and 1 or 0 -- I said don't ask
			end
		end
	end
	
	if b == "wu" then
		xzone = xzone + 10
		if xzone > size*5/6 then xzone = size*5/6 end
		locktheta()
	end
	if b == "wd" then
		xzone = xzone - 10
		if xzone < 0 then xzone = 0 end
		locktheta()
	end
	if b == "m" then
		if draw_grey == -1 then draw_grey = 0
		elseif draw_grey == 0 then draw_grey = 1
		else  draw_grey = -1
		end
	end
end

-- See what button the user is hovering over. Returns 'none' if user isn't hovering over any.
function sethover(getx,gety)
	for i = 1, #button do
		if (getx>=button[i].x1 and getx<=button[i].x2 and gety>=button[i].y1 and gety<=button[i].y2) then
			return button[i].name
		end
	end
	return 'none'
end

-- To tell the program that the user no longer want to move the theta slider
function love.mousereleased()
   drag = 0
end

function love.draw()
	--  GRID
	love.graphics.circle("fill",origin,origin,3,16)
	love.graphics.setColor(200,200,200,50)
	for i=1,5 do
		love.graphics.line(i*size/6,0,i*size/6,size)
		love.graphics.line(0,i*size/6,size,i*size/6)
	end
	love.graphics.setColor(255,255,255)
	
	--[[ FACE
	**
	**					~~~ Special Note ~~~
	**		Love2D's coordinate system starts from the top-left corner.
	**		The standard Cartesian system starts from the bottom-left.
	**		Therefore, y is negative to flip the love system to the Cartesian system.
	**
	]]--
	if draw_grey == -1 then
		secondary_layer()
		primary_layer()
	elseif draw_grey == 1 then
		primary_layer()
		secondary_layer()
	else
		primary_layer()
	end
	
	-- ORANGE BOUNDS
	if draw_unit == 1 then
		bound = {}
		for i=1,#coord do
			if coord[i].v==1 then
				table.insert(bound, coord[i].x+origin)
				table.insert(bound, origin-coord[i].y)
			end
		end
		love.graphics.setColor(255,100,100)
		love.graphics.polygon('line',bound)
	end
	
	-- SLIDER
	love.graphics.setColor(255,255,255)
	love.graphics.line(size/12,size*15/16,size*11/12,size*15/16)
	love.graphics.circle("fill",xzone+size/12,size*15/16,size/64,32)
	love.graphics.print("theta = "..theta*180/math.pi,size*13/16,size*31/32)
	
	-- BUTTONS
	love.graphics.setColor(255,200,100)
	for i=1,#button do
		love.graphics.rectangle("fill",button[i].x1,button[i].y1,button[i].x2-button[i].x1,button[i].y2-button[i].y1)
	end
end

-- snap theta to specific angles
function locktheta()
	if theta > 1*math.pi/4 - epilson and theta < 1*math.pi/4 + epilson then theta = 1*math.pi/4 end
	if theta > 2*math.pi/4 - epilson and theta < 2*math.pi/4 + epilson then theta = 2*math.pi/4 end
	if theta > 3*math.pi/4 - epilson and theta < 3*math.pi/4 + epilson then theta = 3*math.pi/4 end
	if theta > 4*math.pi/4 - epilson and theta < 4*math.pi/4 + epilson then theta = 4*math.pi/4 end
	if theta > 5*math.pi/4 - epilson and theta < 5*math.pi/4 + epilson then theta = 5*math.pi/4 end
	if theta > 6*math.pi/4 - epilson and theta < 6*math.pi/4 + epilson then theta = 6*math.pi/4 end
	if theta > 7*math.pi/4 - epilson and theta < 7*math.pi/4 + epilson then theta = 7*math.pi/4 end
end

-- Draw white circles
function primary_layer()
	for i=1,#coord do
		if coord[i].g ~= 1 then
			love.graphics.setColor(255,255,255)
			love.graphics.circle("fill",coord[i].x+origin, origin-coord[i].y,radius,64)
		end
	end
end

-- Draw grey circles
function secondary_layer()
	for i=1,#coord do
		if coord[i].g==1 then 
			love.graphics.setColor(200,200,200,150)
			love.graphics.circle("fill",coord[i].x+origin, origin-coord[i].y,radius,64)
		end
	end
end