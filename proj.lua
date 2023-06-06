local proj = {}


----------------FUNCTIONS-------------------
function proj:vecmatmult(i,m)
	
	local x = i.x * m.m[0][0] + i.y * m.m[1][0] + i.z * m.m[2][0] + i.w * m.m[3][0]
	local y = i.x * m.m[0][1] + i.y * m.m[1][1] + i.z * m.m[2][1] + i.w * m.m[3][1]
	local z = i.x * m.m[0][2] + i.y * m.m[1][2] + i.z * m.m[2][2] + i.w * m.m[3][2]
	local w = i.x * m.m[0][3] + i.y * m.m[1][3] + i.z * m.m[2][3] + i.w * m.m[3][3]
	
	return self:vec(x,y,z,w)
	
end

function proj:crossproduct(v1,v2)
	local x = v1.y * v2.z - v1.z * v2.y
	local y = v1.z * v2.x - v1.x * v2.z
	local z = v1.x * v2.y - v1.y * v2.x
	return self:vec(x,y,z)
end

function proj:dotproduct(v1,v2)
	return v1.x*v2.x + v1.y * v2.y + v1.z * v2.z
end

function proj:vadd(v1,v2)
	local x = v1.x+v2.x
	local y = v1.y+v2.y
	local z = v1.z+v2.z
	return self:vec(x,y,z)
end

function proj:vsub(v1,v2)
	local x = v1.x-v2.x
	local y = v1.y-v2.y
	local z = v1.z-v2.z
	return self:vec(x,y,z)
end

function proj:vmul(v1,v2)
	local x = v1.x*v2
	local y = v1.y*v2
	local z = v1.z*v2
	return self:vec(x,y,z)
end

function proj:vdiv(v1,v2)
	local x = v1.x/v2
	local y = v1.y/v2
	local z = v1.z/v2
	return self:vec(x,y,z)
end

function proj:vlen(v)
	return math.sqrt(v.x^2 + v.y^2 + v.z^2)
end
function proj:normalize(v)
	
	local l = self:vlen(v)
	local x = v.x / l
	local y = v.y / l
	local z = v.z / l
	return self:vec(x,y,z)
end



function proj:matidentity()
	local newmat = self:mat()
	newmat.m[0][0] = 1
	newmat.m[1][1] = 1
	newmat.m[2][2] = 1
	newmat.m[3][3] = 1
	return newmat
end

function proj:matrotx(angle)
	local newmat = self:mat()
	newmat.m[0][0] = 1
	newmat.m[1][1] = math.cos(angle)
	newmat.m[1][2] = math.sin(angle)
	newmat.m[2][1] = 0 - math.sin(angle)
	newmat.m[2][2] = math.cos(angle)
	newmat.m[3][3] = 1
	return newmat
end

function proj:matroty(angle)
	local newmat = self:mat()
	newmat.m[0][0] = math.cos(angle)
	newmat.m[0][2] = math.sin(angle)
	newmat.m[2][0] = 0 - math.sin(angle)
	newmat.m[1][1] = 1
	newmat.m[2][2] = math.cos(angle)
	newmat.m[3][3] = 1
	return newmat
end

function proj:matrotz(angle)
	local newmat = self:mat()
	newmat.m[0][0] = math.cos(angle)
	newmat.m[0][1] = math.sin(angle)
	newmat.m[1][0] = 0 - math.sin(angle)
	newmat.m[1][1] = math.cos(angle)
	newmat.m[2][2] = 1
	newmat.m[3][3] = 1
	return newmat
end

function proj:mattrans(x,y,z)
	local newmat = self:matidentity()
	newmat.m[3][0] = x
	newmat.m[3][1] = y
	newmat.m[3][2] = z
	return newmat
end
		
function proj:matmult(m1,m2)
	local newmat = self:mat()
	for c=0,3 do
		for r=0,3 do
			newmat.m[r][c] = m1.m[r][0] * m2.m[0][c] + m1.m[r][1] * m2.m[1][c] + m1.m[r][2] * m2.m[2][c] + m1.m[r][3] * m2.m[3][c]
		end
	end
	return newmat
end 

function proj:matpoint(pos,target,up)
	local newforward = self:vsub(target,pos)
	newforward = self:normalize(newforward)
	
	local a = self:vmul(newforward,self:dotproduct(up,newforward))
	local newup = self:vsub(up,a)
	newup = self:normalize(newup)
	
	local newright = self:crossproduct(newup,newforward)
	
	local newmat = self:mat()
	newmat.m[0][0] = newright.x
	newmat.m[0][1] = newright.y
	newmat.m[0][2] = newright.z
	newmat.m[0][3] = 0
	
	newmat.m[1][0] = newup.x
	newmat.m[1][1] = newup.y
	newmat.m[1][2] = newup.z
	newmat.m[1][3] = 0
	
	newmat.m[2][0] = newforward.x
	newmat.m[2][1] = newforward.y
	newmat.m[2][2] = newforward.z
	newmat.m[2][3] = 0
	
	newmat.m[3][0] = pos.x
	newmat.m[3][1] = pos.y
	newmat.m[3][2] = pos.z
	newmat.m[3][3] = 1
	
	return newmat
end

function proj:quickinverse(m)
	newmat = self:mat()
	
	newmat.m[0][0] = m.m[0][0]
	newmat.m[0][1] = m.m[1][0]
	newmat.m[0][2] = m.m[2][0]
	newmat.m[0][3] = 0
	
	newmat.m[1][0] = m.m[0][1]
	newmat.m[1][1] = m.m[1][1]
	newmat.m[1][2] = m.m[2][1]
	newmat.m[1][3] = 0
	
	newmat.m[2][0] = m.m[0][2]
	newmat.m[2][1] = m.m[1][2]
	newmat.m[2][2] = m.m[2][2]
	newmat.m[2][3] = 0
	
	newmat.m[3][0] = -(m.m[3][0] * newmat.m[0][0] + m.m[3][1] * newmat.m[1][0] + m.m[3][2] * newmat.m[2][0])
	newmat.m[3][1] = -(m.m[3][0] * newmat.m[0][1] + m.m[3][1] * newmat.m[1][1] + m.m[3][2] * newmat.m[2][1])
	newmat.m[3][2] = -(m.m[3][0] * newmat.m[0][2] + m.m[3][1] * newmat.m[1][2] + m.m[3][2] * newmat.m[2][2])
	newmat.m[3][3] = 1
	
	return newmat
end

function proj:intersectplane(planep,planen,linestart,lineend)
	planen = self:normalize(planen)
	local planed = 0 - self:dotproduct(planen,planep)
	local ad = self:dotproduct(linestart,planen)
	local bd = self:dotproduct(lineend,planen)
	local t = (0 - planed - ad) / (bd - ad)
	local lineste = self:vsub(lineend,linestart)
	local lineintersect = self:vmul(lineste,t)
	return self:vadd(linestart,lineintersect)
end

function proj:clipplane(planep,planen,intri)
	planen = self:normalize(planen)
	
	local dist = function(p)
		p = self:normalize(p) --might be unneccesary
		return (planen.x * p.x + planen.y * p.y + planen.z * p.z - self:dotproduct(planen,planep))
	end
	
	local insidepoints = {}
	local outsidepoints = {}
	for i=0,2 do
		insidepoints[i] = self:vec()
		outsidepoints[i] = self:vec()
	end
	local insidepointcount = 0
	local outsidepointcount = 0
	
	local d = {}
	d[0] = dist(intri.points[1])
	d[1] = dist(intri.points[2])
	d[2] = dist(intri.points[3])
	
	for i=0,2 do
		if(d[i] >= 0) then 
			insidepoints[insidepointcount] = intri.points[i+1]
			insidepointcount = insidepointcount + 1
		else
			outsidepoints[outsidepointcount] = intri.points[i+1]
			outsidepointcount = outsidepointcount + 1
		end
	end
	
	if insidepointcount == 0 then
		--all points are outside of the plane, clip the entire triangle
		--no triangles will be returned
		return 0,nil,nil
	end
	if insidepointcount == 3 then
		--all points are inside the plane, return original triangle
		return 1,intri,nil
	end
	
	if (insidepointcount == 1 and outsidepointcount == 2) then
		--triangle should be clipped into one smaller triangle
		local outtri = self:copy(intri)
		
		outtri.points[1] = insidepoints[0]
		outtri.points[2] = self:intersectplane(planep,planen,insidepoints[0],outsidepoints[0])
		outtri.points[3] = self:intersectplane(planep,planen,insidepoints[0],outsidepoints[1])
		outtri.forcecolor = {1,0,0}
		return 1,outtri,nil
	end
	
	if (insidepointcount == 2 and outsidepointcount == 1) then
		--clip triangle and form a quad
		local outtri1 = self:copy(intri)
		local outtri2 = self:copy(intri)
		
		outtri1.points[1] = insidepoints[0]
		outtri1.points[2] = insidepoints[1]
		outtri1.points[3] = self:intersectplane(planep,planen,insidepoints[0],outsidepoints[0])
		outtri1.forcecolor = {0,1,0}
		outtri2.points[1] = insidepoints[1]
		outtri2.points[2] = outtri1.points[3]
		outtri2.points[3] = self:intersectplane(planep,planen,insidepoints[1],outsidepoints[0])
		outtri2.forcecolor = {0,0,1}
		
		return 2,outtri1,outtri2
	end
	print("ERROR!")
end

function proj:clippoint(planep,planen,p)
	planen = self:normalize(planen)
	
	
	--p = self:normalize(p) --might be unneccesary
	return (planen.x * p.x + planen.y * p.y + planen.z * p.z - self:dotproduct(planen,planep)) >= 0
	
end

function proj:updateprojectionmatrix()
	self.znear = self.fnear or 0.1
	self.zfar = self.ffar or 1000
	self.fov = self.fovv or 80
	self.width = self.width or 352
	self.height = self.height or 198
	self.aspectratio = self.height/self.width
	self.fovrad = 1 / math.tan(self.fov * 0.5 / 180 * math.pi)
	
	self.matproj = self:mat()
	
	self.matproj.m[0][0] = self.aspectratio * self.fovrad
	self.matproj.m[1][1] = self.fovrad
	self.matproj.m[2][2] = self.zfar / (self.zfar - self.znear)
	self.matproj.m[3][2] = (-1 * self.zfar * self.znear) / (self.zfar - self.znear)
	self.matproj.m[2][3] = 1
	self.matproj.m[3][3] = 0
end


function proj:updatelookdir()
	local target = self:vec(0,0,1)
	local camrotx = self:matrotx(self.camera.dir.x)
	local camroty = self:matroty(self.camera.dir.y)
	local camrotz = self:matrotz(self.camera.dir.z)
	
	target = self:vecmatmult(target,camrotx)
	target = self:vecmatmult(target,camroty)
	target = self:vecmatmult(target,camrotz)
	self.camera.lookdir = target
end
function proj:updatecamera()
	t = self:mattrans(0,0,0)
	self.matworld = self:matidentity()
	--self.matworld = self:matmult(z,x)
	self.matworld = self:matmult(self.matworld,t) --all this really does in practice is offset the entire world by 5 units lol
	
	local up = self:vec(0,1,0)
	
	--self:updatelookdir()

	local target = self:vadd(self.camera.pos,self.camera.lookdir)
	
	local matcamera = self:matpoint(self.camera.pos,target,up)

	self.matview = self:quickinverse(matcamera)
end



function proj:copy(orig,copies)
    copies = copies or {}
    local orig_type = type(orig)
    local _copy
    if orig_type == 'table' then
        if copies[orig] then
            _copy = copies[orig]
        else
            _copy = {}
            copies[orig] = _copy
            for orig_key, orig_value in next, orig, nil do
                _copy[self:copy(orig_key, copies)] = self:copy(orig_value, copies)
            end
            setmetatable(_copy, self:copy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        _copy = orig
    end
    return _copy
end

function proj:loadobj(filename,scale,veconly)
	local verts = {}
	local tris = {}
	for line in io.lines(filename) do
		local lt = string.sub(line,1,1)
		
		if lt == 'v' then --vert
			local v = self:vec()
			local state = 0
			for i in string.gmatch(string.sub(line,3,-1), "%S+") do
				if state == 0 then
					v.x = tonumber(i) * scale
				elseif state == 1 then
					v.y = tonumber(i) * scale
				elseif state == 2 then
					v.z = tonumber(i) * scale
				end
				state = state + 1
			end
			table.insert(verts,v)
		end
		
		if lt == 'f' then --face
			local v = self:triangle()
			local state = 0
			for i in string.gmatch(string.sub(line,3,-1), "%S+") do
				if state == 0 then
					v.points[1] = verts[tonumber(i)]
				elseif state == 1 then
					v.points[2] = verts[tonumber(i)]
				elseif state == 2 then
					v.points[3] = verts[tonumber(i)]
				end
				state = state + 1
			end
			
			table.insert(tris,v)
		end
		
	end
	print('loaded obj!')
	if veconly then
		return verts
	else
		return self:mesh(tris)
	end
	
end
----------------STRUCTURES------------------
function proj:vec(x,y,z,w)
	local newvec = {}
	newvec.x = x
	newvec.y = y
	newvec.z = z
	newvec.w = w or 1
	return newvec
end

function proj:triangle(p1,p2,p3)
	local newtriangle = {points = {}}
	if p2 then
		newtriangle.points = {p1,p2,p3}
	elseif p1 then
		newtriangle.points = p1
	end
	return newtriangle
end

function proj:mat()
	local newmat = {}
	
	newmat.m = {}
	for r=0,3 do
		newmat.m[r] = {}
		for c=0,3 do
			newmat.m[r][c] = 0
		end
	end
	
	return newmat
end

function proj:mesh(tris)
	local newmesh = {}
	newmesh.tris = tris
	
	function newmesh.drawtriangles(newmesh,ftheta)
		--[[
		local matrotz = self:matrotz(ftheta)
		local matrotx = self:matrotx(ftheta*0.5)
		local mattrans = self:mattrans(0,0,5)
		
		self:updatecamera(matrotz,matrotx,mattrans)
		]]--
		
		local trianglestodraw = {}
		
		for i,tri in ipairs(newmesh.tris) do
			
			local tritransformed = self:triangle()
			tritransformed.points[1] = self:vecmatmult(tri.points[1],self.matworld)
			tritransformed.points[2] = self:vecmatmult(tri.points[2],self.matworld)
			tritransformed.points[3] = self:vecmatmult(tri.points[3],self.matworld)
			
			--calculate the normal
			local line1 = self:vec()
			local line2 = self:vec()
			line1 = self:vsub(tritransformed.points[2],tritransformed.points[1])
			line2 = self:vsub(tritransformed.points[3],tritransformed.points[1])
			
			
			local normal = self:crossproduct(line1,line2)
			
			normal = self:normalize(normal)
			
			--project the triangle
			
			local camline = self:vsub(tritransformed.points[1],self.camera.pos)
			if self:dotproduct(normal,camline) < 0 then
				
				--convert world space to view space
				local dp = self:dotproduct(normal,self.light_direction)
				
				local triviewed = self:triangle()
				triviewed.points[1] = self:vecmatmult(tritransformed.points[1],self.matview)
				triviewed.points[2] = self:vecmatmult(tritransformed.points[2],self.matview)
				triviewed.points[3] = self:vecmatmult(tritransformed.points[3],self.matview)
				
				--clip triangles
				local clipcount = 0
				local clipped = {}
				
				clipcount, clipped[1], clipped[2] = self:clipplane(self:vec(0,0,0.1),self:vec(0,0,1),triviewed)
				
				for i=1,clipcount do
					local triprojected = self:triangle()
					triprojected.points[1] = self:vecmatmult(clipped[i].points[1],self.matproj)
					triprojected.points[2] = self:vecmatmult(clipped[i].points[2],self.matproj)
					triprojected.points[3] = self:vecmatmult(clipped[i].points[3],self.matproj)
					
					--normalize by dividing by w
					triprojected.points[1] = self:vdiv(triprojected.points[1], triprojected.points[1].w)
					triprojected.points[2] = self:vdiv(triprojected.points[2], triprojected.points[2].w)
					triprojected.points[3] = self:vdiv(triprojected.points[3], triprojected.points[3].w)
					
					---NOTE THIS MAY BE A BAD IDEA: GOT THIS INFO FROM A YOUTUBE COMMENT LMAO
					for i,v in ipairs(triprojected.points) do
						v.x = v.x * -1
						v.y = v.y * -1
					end
					
					--scale into view
					for i,v in ipairs(triprojected.points) do --this is only a for loop, because im lazy.
						v.x = (v.x + 1) * 0.5 * self.width
						v.y = (v.y + 1) * 0.5 * self.height
					end
					triprojected.dp = dp
					triprojected.forcecolor = clipped[i].forcecolor
					--[[
					
					]]--
					table.insert(trianglestodraw,triprojected)
				end
			end
		end
		
		table.sort(trianglestodraw,function(k1,k2)
			return (k1.points[1].z+k1.points[2].z+k1.points[3].z) > (k2.points[1].z+k2.points[2].z+k2.points[3].z)
		end)
		
		for i,tritoraster in ipairs(trianglestodraw) do
			
			local clipped = {}
			local triangles = {}
			
			--add the initial triangle
			table.insert(triangles,tritoraster)
			local newtriangles = 1
			
			for p=0,3 do
				local tristoadd = 0
				
				while newtriangles > 0 do
					local test = table.remove(triangles)
					newtriangles = newtriangles - 1
					
					if p == 0 then --no switches in lua :(
						tristoadd, clipped[1], clipped[2] = self:clipplane(self:vec(0,0,0),self:vec(0,1,0), test)
					elseif p == 1 then
						tristoadd, clipped[1], clipped[2] = self:clipplane(self:vec(0,self.height - 1,0),self:vec(0,-1,0), test)
					elseif p == 2 then
						tristoadd, clipped[1], clipped[2] = self:clipplane(self:vec(0,0,0),self:vec(1,0,0), test)
					elseif p == 3 then
						tristoadd, clipped[1], clipped[2] = self:clipplane(self:vec(self.width - 1,0,0),self:vec(-1,0,0), test)
					end
					
					for i=1,tristoadd do
						table.insert(triangles,clipped[i])
					end
					
				end
				
				newtriangles = #triangles
				
			end
			for _i,tri in ipairs(triangles) do
				if proj.wireframe then
					love.graphics.setLineWidth(2)
					love.graphics.line(tri.points[1].x,tri.points[1].y,tri.points[2].x,tri.points[2].y)
					love.graphics.line(tri.points[2].x,tri.points[2].y,tri.points[3].x,tri.points[3].y)
					love.graphics.line(tri.points[3].x,tri.points[3].y,tri.points[1].x,tri.points[1].y)
				else
					tri.dp = tri.dp * 0.65 + 0.6
					if tri.forcecolor then 
						love.graphics.setColor(tri.forcecolor,1)
					else
						
						love.graphics.setColor(tri.dp,tri.dp,tri.dp,1)
					end
					love.graphics.polygon('fill',
						{tri.points[1].x,tri.points[1].y,
						 tri.points[2].x,tri.points[2].y,
						 tri.points[3].x,tri.points[3].y
						})
					love.graphics.setColor(0,0,0,1)
					love.graphics.setLineWidth(2)
					love.graphics.line(tri.points[1].x,tri.points[1].y,tri.points[2].x,tri.points[2].y)
					love.graphics.line(tri.points[2].x,tri.points[2].y,tri.points[3].x,tri.points[3].y)
					love.graphics.line(tri.points[3].x,tri.points[3].y,tri.points[1].x,tri.points[1].y)
				end
			end
			
			
		end
		
	end
	
	return newmesh
	
end


function proj:getpoint(x,y,z)
	if (not y) and (not z) then
		local oldx = x
		x = oldx.x
		y = oldx.y
		z = oldx.z
	end
	local point = self:vec(x,y,z)
	
	point = self:vecmatmult(point,self.matworld)
	point = self:vecmatmult(point,self.matview)
	
	
	local clipped = self:clippoint(self:vec(0,0,0.1),self:vec(0,0,1),point)
	
	point = self:vecmatmult(point,self.matproj)
	point = self:vdiv(point, point.w)
	
	point.x = ((point.x) + 1) * 0.5 * self.width
	point.y = ((point.y*-1) + 1) * 0.5 * self.height
	
	return point.x,point.y,point.z,clipped

	
end

function proj:vlerp(v1,v2,t)
	local nv = self:vec(0,0,0)
	nv.x = v1.x + (v2.x - v1.x) * t
	nv.y = v1.y + (v2.y - v1.y) * t
	nv.z = v1.z + (v2.z - v1.z) * t
	return nv
end



proj.camera = {}
proj.camera.pos = proj:vec(0,0,0)
proj.camera.dir = proj:vec(0,0,0)
proj.camera.lookdir = proj:vec(0,0,1)

proj.wireframe = false

proj.light_direction = proj:vec(0,1,-1)
proj.light_direction = proj:normalize(proj.light_direction)

proj:updateprojectionmatrix()
proj:updatecamera()

return proj