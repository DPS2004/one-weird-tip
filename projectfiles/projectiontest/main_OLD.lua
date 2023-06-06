function love.load()
  
	----------------FUNCTIONS-------------------
	
	
	
	
	proj = require("proj")
	
	
	
	
	mypoints = {{x=0,y=0,z=0},{x=0,y=2,z=0},{x=0,y=2,z=1}}

	
	mymesh = proj:loadobj('axis.obj',1)
	--mymesh = proj:loadobj('bunny.obj',50)
	i = 0
  
end


function love.update(dt)
  --i = i + dt
	if love.keyboard.isDown('e') then
		proj.camera.pos.y = proj.camera.pos.y + dt*4
	end
	if love.keyboard.isDown('q') then
		proj.camera.pos.y = proj.camera.pos.y + dt*-4
	end
	
	if love.keyboard.isDown('a') then
		proj.camera.dir.y = proj.camera.dir.y - dt*2
	end
	if love.keyboard.isDown('d') then
		proj.camera.dir.y = proj.camera.dir.y + dt*2
	end
	
	print(math.deg(proj.camera.dir.y))
	if love.keyboard.isDown('r') then
		proj.camera.dir.x = proj.camera.dir.x - dt*2
	end
	if love.keyboard.isDown('f') then
		proj.camera.dir.x = proj.camera.dir.x+ dt*2
	end
	
	proj:updatelookdir()
	
	if love.keyboard.isDown('w') then
		proj.camera.pos = proj:vadd(proj.camera.pos,proj:vmul(proj.camera.lookdir,dt*4))
	end
	if love.keyboard.isDown('s') then
		proj.camera.pos = proj:vsub(proj.camera.pos,proj:vmul(proj.camera.lookdir,dt*4))
	end
	
  
end


function love.draw()
	proj:updatecamera()
  mymesh:drawtriangles(i)
	
	local pp = {}
	for i,v in ipairs(mypoints) do
		local x,y,c = proj:getpoint(v)
		table.insert(pp,{x=x,y=y,c=c})
	end
	love.graphics.setColor(1,1,1,1)
		
	love.graphics.setColor(1,0,1,1)
	
	for i,v in ipairs(pp) do
		if not v.c then
			love.graphics.circle('fill',v.x,v.y,10)
		end
	end
	--love.graphics.line(pp[1].x,pp[1].y,pp[2].x,pp[2].y)
end