-- one weird tip
-- (discovered by a mom)
_ANIMATESPHERE = true


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

lp[6] = newpopup('ink.png',-9)
lp[7] = newpopup('ink.png',-10)
lp[6]:grow(23.5,50,80)
lp[7]:grow(23.5,50,20)

lp[8] = newpopup('prescription.png',-11)
lp[9] = newpopup('prescription.png',-12)
lp[8]:grow(27.5,80,80)
lp[9]:grow(27.5,20,20)

lp[10] = newpopup('replica.png',-13)
lp[11] = newpopup('replica.png',-14)
lp[10]:grow(31.5,80,50)
lp[11]:grow(31.5,20,50)


lp[12] = newpopup('doctorshatehim.png',-15)
lp[12]:grow(33.5,50,50)


for i=4,12 do
	lp[i]:shrink(35.5)
end

windowroom:settheme(35,'NeonMuseum')
row0:move(35,{x=10,y=70,pivot=0})
row1:show(35)
row1:move(35,{x=10,y=30,pivot=0})

function wanitahop(b,y)
	y = y or 30
	
	wanitachar:move(b - 0.2,{y=35},0.333,'outSine')
	wanitachar:move(b + 0.133,{y=30},0.333,'inSine')
end

for100 = newpopup('for100.png',-16)
inusdonly = newpopup('inusdonly.png',-17)
hundo = level:newdecoration('hundo.png', 0, wanitaroom.index, 'hundo')

levitra = newpopup('levitra.png',-18)
cialis = newpopup('cialis.png',-19)
palace = level:newdecoration('palace.png', 0, wanitaroom.index, 'palace')

toomoney = newpopup('toomoney.png',-20)
govt = newpopup('govt.png',-21)
loveme = newpopup('loveme.png',-22)
function wanitasection(first)

	local xmul = 1
	if not first then
		xmul = -1
	end
	local function xf(x)
		if first then
			return x
		else
			return 100 - x
		end
	end
	
	wanitaroom:move(34,{x=xf(75),y=-20,sx=50,sy=50})
	wanitaroom:setbg(34,"wbg_mynameis.png")
	wanitaroom:setfg(34,"wanitafg.png")
	wanitaroom:mask(34,"wanitamask.png")
	wanitachar:move(34,{x=50,y=30,pivot=0,sx=3*xmul,sy=3})
	wanitachar:showchar(34)
	wanitachar:setborder(34,'Outline','000000',100,0,'Linear')

	wanitaroom:move(35.5,{y=20},1,'outExpo')


	wanitahop(36.333)

	wanitaroom:setbg(37.666,'wbg_youngandlonely.png')

	wanitachar:playexpression(38,'barely')
	wanitachar:move(39,{sx=-3*xmul},0.5,'outQuad')

	wanitaroom:setbg(39.666,'wbg_white.png')
	wanitachar:playexpression(40,'neutral')

	wanitaroom:move(40,{x=50},2,'outExpo')
	window:move(40,{y=70},2,'outExpo')

	
	for100:grow(40,xf(83),22)
	inusdonly:grow(42,xf(83),22)
	for100:shrink(44)
	inusdonly:shrink(44)

	hundo:hide(0)
	hundo:move(0,{x=xf(-10),y=PY(126)})
	hundo:show(40)
	hundo:move(40,{x=xf(PX(126))},1,'outExpo')
	hundo:move(43,{x=xf(110)},1,'inExpo')

	levitra:grow(45,xf(30),60)
	wanitahop(45)
	cialis:grow(47,xf(70),60)
	wanitahop(47)
	levitra:shrink(48)
	cialis:shrink(48)

	wanitaroom:move(47,{y=-20},1,'inQuad')
	wanitaroom:move(47.9,{x=xf(-20),y=65})
	wanitaroom:move(48.01,{x=xf(20)},2,'outExpo')

	wanitaroom:setbg(48,'wbg_nigeria.png')
	wanitaroom:setfg(48,'wanitafg_nigeria.png')

	wanitachar:move(48,{sx=2*xmul,sy=2})
	wanitachar:playexpression(48,'barely')

	window:move(48,{x=xf(70),y=50},2,'outExpo')

	palace:hide(0)
	palace:move(0,{x=xf(-50)})
	palace:show(48)
	palace:move(50,{x=xf(50)},1,'outExpo')

	palace:hide(52)
	wanitaroom:setbg(52,'wbg_white.png')
	wanitaroom:setfg(52,'wanitafg.png')
	wanitachar:playexpression(52,'missed')

	
	toomoney:grow(48,xf(70),120)
	govt:grow(48,xf(70),150)
	loveme:grow(48,xf(70),180)

	toomoney:move(51,{y=20},1,'inSine')
	wanitahop(52)

	govt:move(55,{y=50},1,'inSine')
	wanitahop(56)

	loveme:move(57,{y=80},1,'inSine')
	wanitahop(58)
	wanitaroom:move(56,{x=xf(20),y=50},2,'inExpo')

	toomoney:shrink(60)
	govt:shrink(60)
	loveme:shrink(60)

	wanitachar:playexpression(60,'happy')
	wanitachar:playexpression(64,'happy')

	wanitaroom:setfg(60,'wanitafg_desperate.png')
	wanitaroom:setfg(61,'wanitafg_wealthy.png')
	wanitaroom:setfg(62,'wanitafg_single.png')
	wanitaroom:setfg(63,'wanitafg_christian.png')
	
	if first then
		for i=0,4 do
			wanitaroom:move(60-0.5+i,{x=30+i*10},0.5,'inQuad')
			if i==4 then
				window:move(60+i,{x=130},1,'outExpo')
				wanitaroom:move(60+i,{x=50,sx=75,sy=75},2,'outExpo')
			else
				window:move(60+i,{x=80+i*10},1,'outExpo')
				wanitaroom:move(60+i,{x=20+i*5},0.5,'outSine')
			end
		end
		wanitaroom:setfg(64,'wanitafg_allihave.png')
		level:reorderrooms(65,2,0,3,1)
		wanitaroom:move(68,{sx=0,sy=0})
		level:reorderrooms(68,3,2,0,1)
	else
		for i=0,3 do
			wanitaroom:move(60-0.5+i,{x=xf(30+i*10)},0.5,'inQuad')
			if i==3 then
				window:move(60+i,{x=xf(130)},1,'outExpo')
				wanitaroom:move(60+i,{x=xf(50),sx=75,sy=75},2,'outExpo')
			else
				window:move(60+i,{x=xf(80+i*10)},1,'outExpo')
				wanitaroom:move(60+i,{x=xf(20+i*5)},0.5,'outSine')
			end
		end
		local swapbeat = 63.25
		window:move(swapbeat,{sx=1.8,sy=1.8,x=50,y=50},0.75,'inExpo')
		level:reorderrooms(swapbeat,2,0,3,1)
		
		wanitaroom:move(64,{sx=0,sy=0})
		level:reorderrooms(64,3,2,0,1)
		
		row1:hide(swapbeat)
		row2:hide(swapbeat)
		row0:move(swapbeat,{y=10})
		row0:setborder(swapbeat,'Outline','000000',100,0,'Linear')
		windowroom:settheme(swapbeat,'None')
		windowroom:setbg(swapbeat,'idiotblank.png')
		windowroom:setbg(63.666,'idiot0.png')
		windowroom:setbg(64,'idiot1.png')
		windowroom:setbg(64.666,'idiot2.png')
		windowroom:setbg(65,'idiot3.png')
		windowroom:setbg(65.333,'idiot4.png')
		windowroom:setbg(65.666,'idiot5.png')
		windowroom:setbg(66,'idiot6.png')
		windowroom:setbg(66.5,'idiot7.png')
		windowroom:setbg(67,'idiot8.png')
		
		windowroom:setbg(68,'idiot9.png')
		windowroom:invertcolors(68)
		bgroom:invertcolors(68)
		windowroom:setbg(68.5,'idiot8.png')
		windowroom:invertcolors(68.5)
		bgroom:invertcolors(68.5)
		windowroom:setbg(69,'')
		
		
	end
end
wanitasection(true)

--chorus time!!!!!!

wtwindow = {}
clyrics = {}
wtwindow[1] = level:newdecoration('creepyhands', 10, windowroom.index, 'wtwindow1')
wtwindow[2] = level:newdecoration('creepyhands', 10, windowroom.index, 'wtwindow2')
clyrics[1] = level:newdecoration('choruslyrics',9, windowroom.index, 'clyrics1')
clyrics[2] = level:newdecoration('choruslyrics',9, windowroom.index, 'clyrics2')


winman = {}
function winman:move(w,b,p,l,e)
	wtwindow[w]:move(b,p,l,e)
	if p.rot then
		p.rot = p.rot * 2
	end
	clyrics[w]:move(b,p,l,e)
end
function winman:show(w,b)
	wtwindow[w]:show(b)
	clyrics[w]:show(b)
end
function winman:hide(w,b)
	wtwindow[w]:hide(b)
	clyrics[w]:hide(b)
end
function winman:image(b,e)
	e = tostring(e)
	wtwindow[1]:playexpression(b,e)
	wtwindow[2]:playexpression(b,e)
end
function winman:lyric(b,e)
	clyrics[1]:playexpression(b,e)
	clyrics[2]:playexpression(b,e)
end

winman:hide(1,0)
winman:hide(2,0)

function chorus(beat,first)
	level:offset(beat)
	
	
	local windowlow = 25
	local windowhigh = 75
	winman:move(1,-2,{x=120,y=windowhigh,sx=0.5,sy=0.5})
	winman:move(2,-2,{x=-20,y=windowlow,sx=0.5,sy=0.5})
	
	winman:show(1,0)
	winman:show(2,0)
	
	level:alloutline(0,'000000',10,0,'Linear')
	
	if first then
		row1:hide(0)
		row2:show(0)
		row0:move(0,{x=10,y=70,pivot=0})
		row2:move(0,{x=10,y=30,pivot=0})
	else
		row1:show(0)
		row2:show(0)
		
		row0:move(0,{x=10,y=70,pivot=0})
		row2:move(0,{x=10,y=50,pivot=0})
		row1:move(0,{x=10,y=30,pivot=0})
	
	end
	
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
	
	
	for i=0,7 do
		row0:setborder(i*7,'Outline','ffff00',100,0,'Linear')
		row0:setborder(i*7+0.5,'Outline','000000',10,0,'Linear')
	end
	
	for i=0,3 do
		window:move(i*14,{rot=10+(i*2)},3,'outExpo')
		window:move(i*14+3,{rot=0},4,'inExpo')
		window:move(i*14+7,{rot=-10-(i*2)},3,'outExpo')
		if i==3 then
			local scale = 1
			if not first then
				scale = 2
			end
			window:move(i*14+10,{rot=0,sx=scale,sy=scale},4,'inExpo')
		else
			window:move(i*14+10,{rot=0},4,'inExpo')
		end
		
		winman:move(1,i*14,{rot=-10-(i)},3,'outExpo')
		winman:move(1,i*14+3,{rot=0},4,'inExpo')
		winman:move(1,i*14+7,{rot=10+(i)},3,'outExpo')
		winman:move(1,i*14+10,{rot=0},4,'inExpo')
		
		winman:move(2,i*14,{rot=-10-(i)},3,'outExpo')
		winman:move(2,i*14+3,{rot=0},4,'inExpo')
		winman:move(2,i*14+7,{rot=10+(i)},3,'outExpo')
		winman:move(2,i*14+10,{rot=0},4,'inExpo')
		
		
		
	end
	
	for i=0,1 do
		winman:move(1,i*28,{x=windowlow},4,'outExpo')
		winman:move(2,i*28,{x=windowhigh},4,'outExpo')
		
		winman:move(1,i*28+7,{y=windowlow},4,'outExpo')
		winman:move(2,i*28+7,{y=windowhigh},4,'outExpo')
		
		winman:move(1,i*28+14,{x=windowhigh},4,'outExpo')
		winman:move(2,i*28+14,{x=windowlow},4,'outExpo')
		
		winman:move(1,i*28+21,{y=windowhigh},4,'outExpo')
		winman:move(2,i*28+21,{y=windowlow},4,'outExpo')
	end
	
	winman:move(1,56,{x=-20},4,'outExpo')
	winman:move(2,56,{x=120},4,'outExpo')
	
	local lastexpr = -1
	math.randomseed(1)
	for i=0,9*14 do
		local expression = math.random(0,29)
		if expression == lastexpr then
			expression = (expression + 1) % 30
		end
		lastexpr = expression
		winman:image(i*0.5,expression)
	end
	
	
	winman:lyric((7*0)+0,'one')
	winman:lyric((7*0)+1,'weird')
	winman:lyric((7*0)+2,'tip')
	winman:lyric((7*0)+3,'dis')
	winman:lyric((7*0)+3.5,'cov')
	winman:lyric((7*0)+4,'ered')
	winman:lyric((7*0)+4.5,'by')
	winman:lyric((7*0)+5,'a')
	winman:lyric((7*0)+5.5,'mom')
	
	winman:lyric((7*1)-0.5,'a')
	winman:lyric((7*1)+0,'weird')
	winman:lyric((7*1)+1,'old')
	winman:lyric((7*1)+2,'tip')
	winman:lyric((7*1)+3,'dis')
	winman:lyric((7*1)+3.5,'cov')
	winman:lyric((7*1)+4,'ered')
	winman:lyric((7*1)+4.5,'by')
	winman:lyric((7*1)+5,'a')
	winman:lyric((7*1)+5.5,'mom')
	
	winman:lyric((7*2)-0.5,'and')
	winman:lyric((7*2)+0,'you')
	winman:lyric((7*2)+1,'can')
	winman:lyric((7*2)+2,'own')
	winman:lyric((7*2)+3,'your')
	winman:lyric((7*2)+3.5,'name')
	winman:lyric((7*2)+4.5,'dot')
	winman:lyric((7*2)+5.5,'com')
	
	winman:lyric((7*3)-0.5,'and')
	winman:lyric((7*3)+0,'you')
	winman:lyric((7*3)+1,'can')
	winman:lyric((7*3)+2,'own')
	winman:lyric((7*3)+3,'your')
	winman:lyric((7*3)+3.5,'name')
	winman:lyric((7*3)+4.5,'dot')
	winman:lyric((7*3)+5.5,'com')
	
	winman:lyric((7*4)-0.5,'and')
	winman:lyric((7*4)+0,'you')
	winman:lyric((7*4)+1,'can')
	winman:lyric((7*4)+2,'own')
	winman:lyric((7*4)+3,'your')
	winman:lyric((7*4)+3.5,'name')
	winman:lyric((7*4)+4.5,'dot')
	winman:lyric((7*4)+5.5,'net')
	
	winman:lyric((7*5)-0.5,'with')
	winman:lyric((7*5)+0,'all')
	winman:lyric((7*5)+1,'the')
	winman:lyric((7*5)+2,'act')
	winman:lyric((7*5)+3,'ion')
	winman:lyric((7*5)+3.5,'you')
	winman:lyric((7*5)+4,'are')
	winman:lyric((7*5)+4.5,'gon')
	winman:lyric((7*5)+5,'na')
	winman:lyric((7*5)+5.5,'get')
	
	winman:lyric((7*6)-0.5,'with')
	winman:lyric((7*6)+0,'self')
	winman:lyric((7*6)+1,'help')
	winman:lyric((7*6)+2,'talks')
	winman:lyric((7*6)+3,'on')
	winman:lyric((7*6)+3.5,'c')
	winman:lyric((7*6)+4.5,'d')
	winman:lyric((7*6)+5.5,'rom')
	
	winman:lyric((7*7)-0.5,'and')
	winman:lyric((7*7)+0,'one')
	winman:lyric((7*7)+1,'weird')
	if first then
		winman:lyric((7*7)+2,'trick')
	else
		winman:lyric((7*7)+2,'tip')
	end
	winman:lyric((7*7)+3,'dis')
	winman:lyric((7*7)+3.5,'cov')
	winman:lyric((7*7)+4,'ered')
	winman:lyric((7*7)+4.5,'by')
	winman:lyric((7*7)+5,'a')
	winman:lyric((7*7)+5.5,'mom')
	
	
	
end
	
	
window:move(66,{sx=1.8,sy=1.8,x=50,y=50},2,'inExpo')
chorus(68,true)

level:offset(0)
navbar = level:newdecoration('navbar.png',0,windowroom.index, 'navbar')
navbar:hide(0)
navbar:move(0,{y=50+PY(12)})

notifs = {}
notifs.decos = {
	level:newdecoration('notif1.png',20,windowroom.index),
	level:newdecoration('notif2.png',19,windowroom.index),
	level:newdecoration('notif3.png',18,windowroom.index),
	level:newdecoration('notif4.png',17,windowroom.index),
	level:newdecoration('notif5.png',16,windowroom.index),
	level:newdecoration('notif6.png',15,windowroom.index),
	level:newdecoration('notif7.png',14,windowroom.index),
	level:newdecoration('notif8.png',13,windowroom.index),
	level:newdecoration('notif9.png',12,windowroom.index),
	level:newdecoration('notif10.png',11,windowroom.index),
}
notifs.d = {
	{h= 185, active = true},
	{h= 47, active = true},
	{h= 40, active = true},
	{h= 136, active = true},
	{h= 43, active = true},
	{h= 48, active = true},
	{h= 55, active = true},
	{h= 44, active = true},
	{h= 44, active = true},
	{h= 44, active = true},
}

function notifs:moveactive(b,p,dur,e)
	for i,v in ipairs(self.decos) do
		local d = self.d[i]
		if d.active then
			local myp = {}
			for k,_v in pairs(p) do
				myp[k] = _v
				if k == 'y' then
					local newy = 0
					for _i = 1,i-1 do
						if self.d[_i].active then
							newy = newy - PY(self.d[_i].h + 5)
						end
					end
					myp[k] = _v + newy
				end
			end
			v:move(b,myp,dur,e)
		end
	end
end
function notifs:dismiss(b,i,x)
	self.d[i].active = false
	self.decos[i]:move(b,{x=x*110+50},2,'outExpo')
	self.decos[i]:hide(b+2)
end
notifs:moveactive(0,{y=-50})

level:offset(124) -- beat 0 is now the start of social media section, code goes here
bgroom:setbg(-4,'wdbackground2.png')

window:pulse(0,1.05,16)

navbar:show(-4)
navbar:move(-4,{y=50},4,'inExpo')
notifs:moveactive(-4,{y=100-PY(12)},4,'inExpo')

level:alloutline(0,'000000',100,0,'Linear')
windowroom:flash(0,'000000',4,'E6ECF3',100,1,'Linear',true)

row0:move(-4,{y=20},4,'inExpo')
row2:move(-4,{y=10},4,'inExpo')
row1:move(-4,{y=10},4,'inExpo')

row2:hide(0)
row1:show(0)

notifs:dismiss(4-0.333,1,1)
notifs:moveactive(4-0.333,{y=100-PY(12)},2,'outExpo')

notifs:dismiss(8-0.333,2,-1)
notifs:moveactive(8-0.333,{y=100-PY(12)},2,'outExpo')

notifs:dismiss(12-0.333,3,1)
notifs:moveactive(12-0.333,{y=100-PY(12)},2,'outExpo')

notifs:dismiss(16-0.333,4,-1)
notifs:moveactive(16-0.333,{y=100-PY(12)},2,'outExpo')

notifs:dismiss(20-0.333,5,1)
notifs:moveactive(20-0.333,{y=100-PY(12)},2,'outExpo')

notifs:dismiss(26-0.333,6,-1)
notifs:moveactive(26-0.333,{y=100-PY(12)},2,'outExpo')

notifs:dismiss(32-0.333,7,1)
notifs:dismiss(32-0.333,8,-1)
notifs:dismiss(32-0.333,9,1)
notifs:dismiss(32-0.333,10,-1)


window:move(16,{x=30},2,'outExpo')
window:move(20,{x=70},2,'outExpo')
window:move(24,{x=30},2,'outExpo')
window:move(28,{x=70},2,'outExpo')
window:move(32,{x=50},2,'outExpo')

for i=0,3 do
	window:move((i+4)*4+0,{sx=0.8,sy=1.2},0.5,'outSine')
	window:move((i+4)*4+0.5,{sx=1,sy=1},0.5,'inExpo')
	window:move((i+4)*4+1,{sx=1.2,sy=0.8},0.5,'outSine')
	window:move((i+4)*4+1.5,{sx=1,sy=1},0.5,'inQuad')
	local rm = (i%2)*-2+1
	window:move((i+4)*4+2,{rot=10*rm},1,'outExpo')
	window:move((i+4)*4+2.666,{rot=-10*rm},1,'outExpo')
	window:move((i+4)*4+3,{rot=10*rm},1,'outExpo')
	window:move((i+4)*4+3.666,{rot=-10*rm},1,'outExpo')
	window:move((i+4)*4+4,{rot=0},1,'outExpo')
end

windowroom:settheme(32-0.333,'Rooftop')
windowroom:flash(32-0.333,'E6ECF3',100,'E6ECF3',0,0.5,'Linear',true)
navbar:move(32-0.333,{y=50+PY(16)},1,'outExpo')

row2:show(32)

row0:move(32,{x=10,y=70,pivot=0},2,'outExpo')
row2:move(32,{x=10,y=50,pivot=0},2,'outExpo')
row1:move(32,{x=10,y=30,pivot=0},2,'outExpo')

level:offset(120) --shhh pretend those 4 beats dont exist im not lazy you are
wanitasection(false) -- my favorite part of this level is when wanita says "its wanitaing time" and wanitas all over the place







--second chorus 
chorus(189,false)



level:offset(0) --init verts
verts = {}
vertstatus = {}
for i=1,162 do
	verts[i] = level:newdecoration('popups',11, windowroom.index, 'vert'..i)
	verts[i]:move(0,{x=-999,y=-999})
	verts[i]:hide(0)
	verts[i]:playexpression(0,tostring(math.random(0,53)))
	vertstatus[i] = {undrawn=true,c=false}
end
level:offset(245) -- ending
level:alloutline(0,'000000',50,1,'Linear')


proj = dofile('../proj.lua')
icosphere_mesh = proj:loadobj('../icosphere.obj',4,true)

sphereint = 1
spherelength = ((20*7)+2)/sphereint
if not _ANIMATESPHERE then
	spherelength = 14
end

local zscale = {}
print('rendering the Ball...')
for i = -1,spherelength do
	local beat = i * sphereint

	proj:updatelookdir()
	proj.camera.dir.x = (i+2) * (1/10) * sphereint
	proj.camera.dir.z = (i+2)*0.5 * (1/10) * sphereint
	proj:updatecamera()


	local function drawvert(v,x,y,z,c)
		local duration = sphereint
		if vertstatus[v].undrawn or (not c) then
			duration = 0
			vertstatus[v].undrawn = false
		end
		
		if z * 15 >= 1 then --attempt to catch glitched culling
			c = false
		end
		
		
		
		local firstframe = false
		
		if vertstatus[v].c ~= c then
			if c then
				verts[v]:show(beat)
				firstframe = true
			else
				verts[v]:hide(beat)
			end
			vertstatus[v].c = c
		end
		
		
		if i == -1 then 
			z = 0 
		end
		
		if c then
			if firstframe then
				verts[v]:move(beat-sphereint,{x=PX(x),y=PY(y),sx=15*z,sy=15*z},0,'Linear')
			end
			verts[v]:move(beat,{x=PX(x),y=PY(y),sx=15*z,sy=15*z},duration,'Linear')
			zscale[beat] = zscale[beat] or {}
			zscale[beat][v] = z
		end
	end
	
	for _i,v in ipairs(icosphere_mesh) do
		local x,y,z,c = proj:getpoint(v)
		z = z -0.95
		z = 0.03 - z
		drawvert(_i,x,y,z,c)
	end

	
end

for i,beatz in ipairs(zscale) do
	for _i=1,162 do
		if not beatz[_i] then
			zscale[i][_i] = 0
		end
	end
end

function expressionwave(beat)
	if zscale[beat] then
		local smallest = 9999
		for k,v in pairs(zscale[beat]) do
			if v < smallest and v ~= 0 then
				smallest = v
			end
		end
		for k,v in pairs(zscale[beat]) do
			verts[k]:playexpression(beat + math.max(0,v-smallest)*80,tostring(math.random(0,53)))
		end
	end
end

for i=0,20 do
	expressionwave(i*7)
end