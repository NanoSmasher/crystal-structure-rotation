--[[ LIST OF FUNCTIONS
love.update(dt)		
love.load()
love.keyreleased(key)
love.mousepressed(x, y, b)
love.mousereleased()
love.draw()
sethover(getx, gety)
locktheta()
primary_layer()
secondary_layer()
getdata(file)
]]--

function love.update(dt)
	-- remove all previous values
	for i=1,#coord do coord[i] = nil end
	-- calculate new values
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
#
#    [2] Use these functions to help you code:
#
#        cos([variable])
#        sin([variable])
#
#		 Both require radian input
]]		
		
		newx = x*cos(theta) - y*sin(theta)		-- lines to code
		newy = x*sin(theta) + y*cos(theta)		-- lines to code
		
---------------------CODE ABOVE-----------------------
------------------------------------------------------
		newx = newx or 0
		newy = newy or 0
		coord[i] = {x=newx, y=newy, g=point[i].g, u=point[i].u,v=point[i].v}
	end
	
	
	-- code for angle snapping
	local mX = love.mouse.getX()
	if drag==1 and mX>=size/12 and mX<=size*11/12 then xzone = mX - size/12 end
	theta = xzone/scale*2*math.pi
	locktheta()

	-- code for getting the data files
	filelist = {}
	local cd = "/data"							-- current directory
	local files = love.filesystem.getDirectoryItems(cd)
	for i, file in ipairs(files) do			-- 'i' starts at 1 and increments, 'file' is the full name of the file
		if string.find(file,".txt") then	-- if the file has the .txt extension
			table.insert(filelist,file)		-- add it to the filelist
		end
	end

end

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
	coord = {}
	radius = 50
	draw_grey = -1
	epilson = 0.1
	button = {}
	filelist = {}
end

function love.keyreleased(key)
	if key == "escape" then love.event.push("quit") end -- Hit the Escape key to quit program
end

function love.mousepressed(x, y, b)
	-- b == Left, WheelUp, WheelDown, Middle
	if b == "l" then
		if (math.sqrt((x-xzone)*(x-xzone)+(y-size*15/16)*(y-size*15/16))) < size/10  then
			drag = 1 -- informs program user is over the theta slider
		else
			local name = sethover(x,y) -- gets the name of the file name it is hovering over
			if name then point = getdata(name) or point end -- and loads it into the program
		end
	elseif b == "wu" then
		xzone = xzone + 10
		if xzone > size*5/6 then xzone = size*5/6 end
		locktheta()
	elseif b == "wd" then
		xzone = xzone - 10
		if xzone < 0 then xzone = 0 end
		locktheta()
	elseif b == "m" then
		if draw_grey == -1 then draw_grey = 0
		elseif draw_grey == 0 then draw_grey = 1
		else  draw_grey = -1
		end
	end
end

function love.mousereleased()
   drag = 0 -- Tell the program that the user no longer want to move the theta slider

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

	-- SLIDER
	love.graphics.setColor(255,255,255)
	love.graphics.line(size/12,size*15/16,size*11/12,size*15/16)
	love.graphics.circle("fill",xzone+size/12,size*15/16,size/64,32)
	love.graphics.print("theta = "..theta*180/math.pi,size*13/16,size*31/32)
	
	-- BUTTONS
	local a = 10
	for i=1, #filelist do
		love.graphics.setColor(255,200,100)
		love.graphics.rectangle("fill",10,a,6.7*(#filelist[i]-4)+12,18)
		love.graphics.setColor(0,0,0)
		love.graphics.print(string.sub(filelist[i],1,#filelist[i]-4),15,a+2)
		a = a + 20
	end
end

function sethover(getx,gety)
	-- If the mouse is hovering over a file, return the name of the file. Otherwise return nil
	local a = 10
	for i = 1, #filelist do
		if (getx>=10 and getx<=6.7*(#filelist[i]-4)+22 and gety>=a and gety<=a+18) then
			return filelist[i] 
		else a = a + 20 end
	end
	return nil
end

function locktheta()
	-- snap theta to specific angles
	if theta > 1*math.pi/4 - epilson and theta < 1*math.pi/4 + epilson then theta = 1*math.pi/4 end
	if theta > 2*math.pi/4 - epilson and theta < 2*math.pi/4 + epilson then theta = 2*math.pi/4 end
	if theta > 3*math.pi/4 - epilson and theta < 3*math.pi/4 + epilson then theta = 3*math.pi/4 end
	if theta > 4*math.pi/4 - epilson and theta < 4*math.pi/4 + epilson then theta = 4*math.pi/4 end
	if theta > 5*math.pi/4 - epilson and theta < 5*math.pi/4 + epilson then theta = 5*math.pi/4 end
	if theta > 6*math.pi/4 - epilson and theta < 6*math.pi/4 + epilson then theta = 6*math.pi/4 end
	if theta > 7*math.pi/4 - epilson and theta < 7*math.pi/4 + epilson then theta = 7*math.pi/4 end
end

function primary_layer()
	-- Draw white circles
	for i=1,#coord do
		if coord[i].g ~= 1 then
			love.graphics.setColor(255,255,255)
			love.graphics.circle("fill",coord[i].x+origin, origin-coord[i].y,radius,64)
		end
	end
end

function secondary_layer()
	-- Draw grey circles
	for i=1,#coord do
		if coord[i].g==1 then 
			love.graphics.setColor(200,200,200,150)
			love.graphics.circle("fill",coord[i].x+origin, origin-coord[i].y,radius,64)
		end
	end
end

function getdata(file)
	if not love.filesystem.isFile("/data/"..file) then return nil end
	-- If it is not a file, don't do anything

	local temp = {}	-- stores our current list of points
	local grey = -1	-- number of points to assign to grey 
	local num = 0	-- counter
	
	-- iterate over each line in the file
	for line in love.filesystem.lines("/data/"..file) do
		if line ~= "\n" then
			if grey == -1 then -- If this is the first line of code, read the number of grey units.
				grey = tonumber(line)
				if not grey then return nil end -- if there was no number to read, the file is bad
			else
				num = num+1
				-- break the comma separated values (CSV) into two points
				local comma = string.find(line,",")
				local x1 = tonumber(string.sub(line,1,comma-1))
				local y1 = tonumber(string.sub(line,comma+1))

				-- add the points to temp, assigning them either as grey or not-grey.
				if num <= grey then
					table.insert(temp, {x=x1, y=y1,g=1})
				else
					table.insert(temp, {x=x1, y=y1,g=0})
				end

			end
		end
	end

	return temp
end

function cos(x) return math.cos(x) end	-- shorten calls to match with the C syntax
function sin(x) return math.sin(x) end	-- shorten calls to match with the C syntax