-- one weird tip
-- (discovered by a mom)

level:setuprooms()
level:reorderrooms(0,3,2,0,1)

windowroom = level.rooms[0]
bgroom = level.rooms[1]
decoroom = level.rooms[2]
wanitaroom = level.rooms[3]

ontop = level.rooms[4]

row0 = level.rows[0]
row1 = level.rows[1]
row2 = level.rows[2]

wanitachar = level.rows[3]

row1:setvisibleatstart(false)
row2:setvisibleatstart(false)
wanitachar:setvisibleatstart(false)


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

lp[0] = newpopup('imofferingtoyou.png',-3)
lp[0]:grow(3.5,20,55)

window:move(7.5,{x=35,rot=5},2,'outExpo')

lp[0]:back(7.5)
lp[1] = newpopup('mynewweightlossmethods.png',-4)
lp[1]:grow(7.5,80,35)

window:move(11.5,{x=65,y=65,rot=-5},2,'outExpo')

lp[1]:back(11.5)
lp[2] = newpopup('forpenniesaday.png',-5)
lp[2]:grow(11.5,40,25)

window:move(15.5,{x=45,y=35,rot=2},2,'outExpo')

lp[2]:back(15.5)
lp[3] = newpopup('andmiraclepills.png',-6)
lp[3]:grow(15.5,60,75)


window:move(19.5,{x=50,y=50,rot=0},2,'outExpo')
for i=0,3 do
	lp[i]:shrink(19.5)
end

window:pulse(20,1.05,16)

lp[4] = newpopup('smallbusinessowner.png',-7)
lp[5] = newpopup('smallbusinessowner.png',-8)
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

wanitaroom:move(34,{x=75,y=-20,sx=50,sy=50})
wanitaroom:setbg(34,"wanitawindow.png")
wanitaroom:mask(34,"wanitawindow.png")
wanitachar:move(34,{x=50,y=30,pivot=0,sx=3,sy=3})
wanitachar:showchar(34)

wanitaroom:move(35.5,{y=20},1,'outExpo')

function wanitahop(b,y)
	y = y or 30
	
	wanitachar:move(b - 0.2,{y=35},0.333,'outSine')
	wanitachar:move(b + 0.133,{y=30},0.333,'inSine')
end
wanitahop(36.333)

wanitachar:playexpression(38,'barely')
wanitachar:move(39,{sx=-3},0.5,'outQuad')

wanitachar:playexpression(40,'neutral')

wanitaroom:move(40,{x=50},2,'outExpo')
window:move(40,{y=70},2,'outExpo')

hundo = level:newdecoration('hundo.png', 0, wanitaroom.index, 'hundo')
hundo:hide(0)
hundo:move(0,{x=-10,y=PY(126)})
hundo:show(40)
hundo:move(40,{x=PX(126)},1,'outExpo')
hundo:move(43,{x=110},1,'inExpo')

levitra = newpopup('levitra.png',-16)
cialis = newpopup('cialis.png',-17)
levitra:grow(45,30,60)
wanitahop(45)
cialis:grow(47,70,60)
wanitahop(47)
levitra:shrink(48)
cialis:shrink(48)

wanitaroom:move(47,{y=-20},1,'inQuad')
wanitaroom:move(48,{x=-20,y=65})
wanitaroom:move(48.01,{x=20},2,'outExpo')

wanitaroom:setbg(48,'wanitanigeria.png')

wanitachar:move(48,{sx=2,sy=2})
wanitachar:playexpression(48,'barely')

palace = level:newdecoration('palace.png', 0, wanitaroom.index, 'palace')
palace:hide(0)
palace:move(0,{x=-50})
palace:show(48)
palace:move(50,{x=50},1,'outExpo')


for i=4,12 do
	lp[i]:shrink(35.5)
end



-- rest of wanita goes here
wanitaroom:move(68,{sx=0,sy=0})


--chorus time!!!!!!
wtwindow1 = level:newdecoration('weirdtipwindow.png', 10, windowroom.index, 'wtwindow1')
wtwindow2 = level:newdecoration('weirdtipwindow.png', 10, windowroom.index, 'wtwindow2')
wtwindow1:hide(0)
wtwindow2:hide(0)

function chorus(beat)
	level:offset(beat)
	
	
	local windowlow = 25
	local windowhigh = 75
	wtwindow1:move(-2,{x=120,y=windowhigh,sx=0.5,sy=0.5})
	wtwindow2:move(-2,{x=-20,y=windowlow,sx=0.5,sy=0.5})
	
	wtwindow1:show(0)
	wtwindow2:show(0)
	
	
	level.dofinalize = true --a crappy trick to force DN to write these events in the exact order
	--normally it doesnt matter, but for some reason it does here!
	--¯\_(ツ)_/¯
	windowroom:settheme(0,'matrix')
	windowroom:flash(0,'000000',4,'000000',4,1,'Linear',true)
	windowroom:hom(0,true)
	level.dofinalize = false
	--i guess you could call it...
	--a weird trick.
	--(gets killed instantly)
	
	window:move(-2,{sx=1.8,sy=1.8,x=50,y=50},2,'inExpo')

	for i=0,3 do
		window:move(i*14,{rot=10+(i*2)},3,'outExpo')
		window:move(i*14+3,{rot=0},4,'inExpo')
		window:move(i*14+7,{rot=-10-(i*2)},3,'outExpo')
		window:move(i*14+10,{rot=0},4,'inExpo')
		
		wtwindow1:move(i*14,{rot=-10-(i)},3,'outExpo')
		wtwindow1:move(i*14+3,{rot=0},4,'inExpo')
		wtwindow1:move(i*14+7,{rot=10+(i)},3,'outExpo')
		wtwindow1:move(i*14+10,{rot=0},4,'inExpo')
		
		wtwindow2:move(i*14,{rot=-10-(i)},3,'outExpo')
		wtwindow2:move(i*14+3,{rot=0},4,'inExpo')
		wtwindow2:move(i*14+7,{rot=10+(i)},3,'outExpo')
		wtwindow2:move(i*14+10,{rot=0},4,'inExpo')
		
		
		
	end
	
	for i=0,1 do
		wtwindow1:move(i*28,{x=windowlow},4,'outExpo')
		wtwindow2:move(i*28,{x=windowhigh},4,'outExpo')
		
		wtwindow1:move(i*28+7,{y=windowlow},4,'outExpo')
		wtwindow2:move(i*28+7,{y=windowhigh},4,'outExpo')
		
		wtwindow1:move(i*28+14,{x=windowhigh},4,'outExpo')
		wtwindow2:move(i*28+14,{x=windowlow},4,'outExpo')
		
		wtwindow1:move(i*28+21,{y=windowhigh},4,'outExpo')
		wtwindow2:move(i*28+21,{y=windowlow},4,'outExpo')
	end
	
	
	
end
	
	
	
chorus(68)