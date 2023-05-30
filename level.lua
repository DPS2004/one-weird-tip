-- one weird tip
-- (discovered by a mom)

level:setuprooms()
level:reorderrooms(0,2,0,1,3)

windowroom = level.rooms[0]
bgroom = level.rooms[1]
decoroom = level.rooms[2]

ontop = level.rooms[4]

row0 = level.rows[0]
row1 = level.rows[1]
row2 = level.rows[2]

row1:setvisibleatstart(false)
row2:setvisibleatstart(false)


-- window functions
-- (not discovered by a mom)

windowdeco = level:newdecoration('window1x.png', 0, decoroom.index, 'windowdeco')
window = {}
function window:move(beat, p, duration, ease)
	local decop = {}
	for k,v in pairs(p) do
		decop[k] = v
		if k == 'sx' or k == 'sy' then
			p[k] = v * 50
			decop[k] = v * 0.5
		end
		
	end
	windowroom:move(beat, p, duration, ease)
	windowdeco:move(beat, decop, duration, ease)

end

function window:pulse(beat,intensity,re,interval)
	intensity = intensity or 1.1
	re = re or 1
	interval = interval or 1
	
	for i=0,re-1 do
		self:move(beat+(i*interval)-0.05,{sx=intensity,sy=intensity},0.1,'Linear')
		self:move(beat+(i*interval)+0.05,{sx=1,sy=1},0.9,'outSine')
	end
end

function newpopup(file, layer)	
	local popup = {}
	
	popup.decofront = level:newdecoration(file, layer, decoroom.index)
	popup.decoback = level:newdecoration(file, layer, bgroom.index)
	
	function popup:move(beat, p, duration, ease) -- generic move function
		self.decofront:move(beat, p, duration, ease)
		self.decoback:move(beat, p, duration, ease)
	end
	
	function popup:grow(beat, x, y, r) -- grow the popup
		r = r or 0
		if x then
			self:move(beat, {x=x,y=y,rot=r})
		end
		self:move(beat,{sx=0.5,sy=0.5},0.5,'outQuad')
	end
	
	function popup:shrink(beat) -- shrink the popup
		self:move(beat,{sx=0,sy=0},0.5,'inQuad')
	end
	
	function popup:back(beat) -- send the popup to the back layer
		self.decofront:hide(beat)
	end
	
	function popup:front(beat) -- send the popup to the front layer
		self.decofront:show(beat)
	end
	
	
	popup:move(0, {x=-100,y=-100, sx=0, sy=0})
	
	return popup
end



-- intro
bgroom:setbg(0,'wdbackground.png')
window:move(0,{x=50,y=50,sx=1,sy=1})
windowroom:settheme(0,'HospitalWard')
row0:move(0,{x=10,y=30,pivot=0})

trash = level:newdecoration('trashcan.png', -1, bgroom.index, 'trash')
trash:move(0,{x=PX(20),y=PY(30),sx=0.5,sy=0.5})

ottoexec = level:newdecoration('ottoexec.png', 0, bgroom.index, 'ottoexec')
ottoexec:move(0,{x=PX(20),y=PY(30),sx=0,sy=0.5})

mouse = level:newdecoration('mousetemporary.png', -2, bgroom.index, 'mouse')
mouse:move(0,{x=PX(60),y=PY(-10),sx=0.5,sy=0.5})

ontop:flash(0,'000000',100)
ontop:flash(0.01,'000000',100,'000000',0,1,'Linear')

mouse:move(0.01,{x=PX(20),y=PY(30)},1.5,'outSine')
mouse:move(1.5,{sx=0.4,sy=0.4},0.2,'inSine')
mouse:move(1.7,{sx=0.5,sy=0.5},0.2,'outSine')

ottoexec:move(1.6,{sx=0.5},1,'outSine')
ottoexec:move(1.6,{y=PY(54)},1,'outQuad')

local ottoshakemul = -1
for i=0,50 do
	ottoshakemul = ottoshakemul * -1
	if i == 50 then
		ottoshakemul = 0
	end
	ottoexec:move(2.5+i*0.02,{x=PX(20+ottoshakemul*(i*0.08))})
end
ottoexec:move(3.5,{sx=0.4,sy=0.7},0.5,'outSine')
ottoexec:move(4,{sx=0.7,sy=0},0.5,'inSine')

lp = {}

window:move(3.5,{x=70,rot=-10},2,'outExpo')

lp[0] = newpopup('popuptemporary.png',-3)
lp[0]:grow(3.5,20,55)

window:move(7.5,{x=35,rot=5},2,'outExpo')

lp[0]:back(7.5)
lp[1] = newpopup('popuptemporary.png',-4)
lp[1]:grow(7.5,80,35)

window:move(11.5,{x=65,y=65,rot=-5},2,'outExpo')

lp[1]:back(11.5)
lp[2] = newpopup('popuptemporary.png',-5)
lp[2]:grow(11.5,40,25)

window:move(15.5,{x=45,y=35,rot=2},2,'outExpo')

lp[2]:back(15.5)
lp[3] = newpopup('popuptemporary.png',-6)
lp[3]:grow(15.5,60,75)


window:move(19.5,{x=50,y=50,rot=0},2,'outExpo')
for i=0,3 do
	lp[i]:shrink(19.5)
end

window:pulse(20,1.05,16)

lp[4] = newpopup('smallpopup.png',-7)
lp[5] = newpopup('smallpopup.png',-8)
lp[4]:grow(19.5,20,80)
lp[5]:grow(19.5,80,20)

lp[6] = newpopup('smallpopup.png',-9)
lp[7] = newpopup('smallpopup.png',-10)
lp[6]:grow(23.5,50,80)
lp[7]:grow(23.5,50,20)

lp[8] = newpopup('smallpopup.png',-11)
lp[9] = newpopup('smallpopup.png',-12)
lp[8]:grow(27.5,80,80)
lp[9]:grow(27.5,20,20)

lp[10] = newpopup('smallpopup.png',-13)
lp[11] = newpopup('smallpopup.png',-14)
lp[10]:grow(31.5,80,50)
lp[11]:grow(31.5,20,50)


lp[12] = newpopup('smallpopup.png',-15)
lp[12]:grow(33.5,50,50)

windowroom:settheme(35,'NeonMuseum')
row0:move(35,{x=10,y=70,pivot=0})
row1:show(35)
row1:move(35,{x=10,y=30,pivot=0})

for i=4,12 do
	lp[i]:shrink(35.5)
end
