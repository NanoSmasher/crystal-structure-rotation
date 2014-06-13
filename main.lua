require("data")

function love.load()
	size = 600
	love.window.setTitle("Low-level rotations of Crystal structure faces")
	love.window.setMode(size,size)
	screen = "main"
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
	
	--buttons: FCC[100], FCC[110], FCC[111], BCC[100], BCC[110], grey, unit, about
	button = {
		{name = "fcc100",	x1 = 20,	y1 = 20,	x2 = 40,	y2 = 40},
		{name = "fcc110",	x1 = 60,	y1 = 20,	x2 = 80,	y2 = 40},
		{name = "fcc111",	x1 = 100,	y1 = 20,	x2 = 120,	y2 = 40},
		{name = "bcc100",	x1 = 140,	y1 = 20,	x2 = 160,	y2 = 40},
		{name = "bcc110",	x1 = 180,	y1 = 20,	x2 = 200,	y2 = 40},
		{name = "grey",		x1 = 220,	y1 = 20,	x2 = 240,	y2 = 40},
		{name = "unit",		x1 = 260,	y1 = 20,	x2 = 280,	y2 = 40},
		{name = "about",	x1 = 300,	y1 = 20,	x2 = 320,	y2 = 40}
	}
end

function love.keyreleased(key)
	if key == "escape" then love.event.push("quit") end
end

function love.mousepressed(x, y, b)
	if b == "l" and screen == 'main' then
		if (math.sqrt((x-xzone)*(x-xzone)+(y-size*15/16)*(y-size*15/16))) < size/10  then
			drag = 1
		else
			local on = sethover(x,y)
			if (on=='fcc100') then point = fcc100()
			elseif (on=='fcc110') then point = fcc110()
			elseif (on=='fcc111') then point = fcc111()
			 --[[WIP: rest of the faces]]--
			elseif (on=='grey') then 
				if draw_grey == -1 then draw_grey = 0
				elseif draw_grey == 0 then draw_grey = 1
				else  draw_grey = -1
				end
			elseif (on=='unit') then draw_unit = draw_unit == 0 and 1 or 0 --Please don't ask
			end
		end
	end
	
	if b == "wu" and screen == 'main' then
		xzone = xzone + 10
		if xzone > size*5/6 then xzone = size*5/6 end
		locktheta()
	end
	if b == "wd" and screen == 'main' then
		xzone = xzone - 10
		if xzone < 0 then xzone = 0 end
		locktheta()
	end
	if b == "m" and screen == 'main' then
		if draw_grey == -1 then draw_grey = 0
		elseif draw_grey == 0 then draw_grey = 1
		else  draw_grey = -1
		end
	end
end

function sethover(getx,gety)
	for i = 1, #button do
		if (getx>=button[i].x1 and getx<=button[i].x2 and gety>=button[i].y1 and gety<=button[i].y2) then
			return button[i].name
		end
	end
	return 'none'
end

function love.mousereleased()
   drag = 0
end

function love.update(dt)
	local x = love.mouse.getX()
	for i=1,#coord do coord[i] = nil end

	if drag==1 and x>=size/12 and x<=size*11/12 then xzone = x - size/12 end
	theta = xzone/scale*2*math.pi
	locktheta()
	
	for i=1,#point do
		-- x' = x * cos(theta) - y * sin(theta)
		-- y' = x * sin(theta) - y * cos(theta)
		newx = point[i].x*math.cos(theta) - point[i].y*math.sin(theta)		-- lines to code
		newy = point[i].x*math.sin(theta) + point[i].y*math.cos(theta)		-- lines to code
		coord[i] = {x=newx, y=newy, g=point[i].g, u=point[i].u,v=point[i].v}
	end
	
end

function love.draw()
	--  ####################	Start of grid	####################
	love.graphics.circle("fill",origin,origin,3,16)
	love.graphics.setColor(200,200,200,50)
	for i=1,5 do
		love.graphics.line(i*size/6,0,i*size/6,size)
		love.graphics.line(0,i*size/6,size,i*size/6)
	end
	love.graphics.setColor(255,255,255)
	--  ####################	End of grid		####################
	
	--[[####################	Start of face	####################
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
	--  ####################	End of face		####################

	--  ####################	Start of bound	####################
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
	-- ####################		End of bound	####################
	
	love.graphics.setColor(255,255,255)
	
	-- ####################		Start of slider ####################
	love.graphics.line(size/12,size*15/16,size*11/12,size*15/16)
	love.graphics.circle("fill",xzone+size/12,size*15/16,size/64,32)
	love.graphics.print("theta = "..theta*180/math.pi,size*13/16,size*31/32)
	-- ####################		End of slider 	####################
	
	-- ####################		Start of button ####################
	love.graphics.setColor(255,200,100)
	for i=1,#button do
		love.graphics.rectangle("fill",button[i].x1,button[i].y1,button[i].x2-button[i].x1,button[i].y2-button[i].y1)
	end
	-- ####################		End of button 	####################

end

function locktheta()
	if theta > 1*math.pi/4 - epilson and theta < 1*math.pi/4 + epilson then theta = 1*math.pi/4 end
	if theta > 2*math.pi/4 - epilson and theta < 2*math.pi/4 + epilson then theta = 2*math.pi/4 end
	if theta > 3*math.pi/4 - epilson and theta < 3*math.pi/4 + epilson then theta = 3*math.pi/4 end
	if theta > 4*math.pi/4 - epilson and theta < 4*math.pi/4 + epilson then theta = 4*math.pi/4 end
	if theta > 5*math.pi/4 - epilson and theta < 5*math.pi/4 + epilson then theta = 5*math.pi/4 end
	if theta > 6*math.pi/4 - epilson and theta < 6*math.pi/4 + epilson then theta = 6*math.pi/4 end
	if theta > 7*math.pi/4 - epilson and theta < 7*math.pi/4 + epilson then theta = 7*math.pi/4 end
end
function primary_layer()
	for i=1,#coord do
		if coord[i].g ~= 1 then
			love.graphics.setColor(255,255,255)
			love.graphics.circle("fill",coord[i].x+origin, origin-coord[i].y,radius,64)
		end
	end
end
function secondary_layer()
	for i=1,#coord do
		if coord[i].g==1 then 
			love.graphics.setColor(200,200,200,150)
			love.graphics.circle("fill",coord[i].x+origin, origin-coord[i].y,radius,64)
		end
	end
end