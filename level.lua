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

wanitaroom:move(34,{x=75,y=-20,sx=50,sy=50})
wanitaroom:setbg(34,"wbg_mynameis.png")
wanitaroom:setfg(34,"wanitafg.png")
wanitaroom:mask(34,"wanitamask.png")
wanitachar:move(34,{x=50,y=30,pivot=0,sx=3,sy=3})
wanitachar:showchar(34)

wanitaroom:move(35.5,{y=20},1,'outExpo')

function wanitahop(b,y)
	y = y or 30
	
	wanitachar:move(b - 0.2,{y=35},0.333,'outSine')
	wanitachar:move(b + 0.133,{y=30},0.333,'inSine')
end
wanitahop(36.333)

wanitaroom:setbg(37.666,'wbg_youngandlonely.png')

wanitachar:playexpression(38,'barely')
wanitachar:move(39,{sx=-3},0.5,'outQuad')

wanitaroom:setbg(39.666,'wbg_white.png')
wanitachar:playexpression(40,'neutral')

wanitaroom:move(40,{x=50},2,'outExpo')
window:move(40,{y=70},2,'outExpo')

for100 = newpopup('for100.png',-16)
inusdonly = newpopup('inusdonly.png',-17)
for100:grow(40,83,22)
inusdonly:grow(42,83,22)
for100:shrink(44)
inusdonly:shrink(44)

hundo = level:newdecoration('hundo.png', 0, wanitaroom.index, 'hundo')
hundo:hide(0)
hundo:move(0,{x=-10,y=PY(126)})
hundo:show(40)
hundo:move(40,{x=PX(126)},1,'outExpo')
hundo:move(43,{x=110},1,'inExpo')

levitra = newpopup('levitra.png',-18)
cialis = newpopup('cialis.png',-19)
levitra:grow(45,30,60)
wanitahop(45)
cialis:grow(47,70,60)
wanitahop(47)
levitra:shrink(48)
cialis:shrink(48)

wanitaroom:move(47,{y=-20},1,'inQuad')
wanitaroom:move(47.9,{x=-20,y=65})
wanitaroom:move(48.01,{x=20},2,'outExpo')

wanitaroom:setbg(48,'wbg_nigeria.png')
wanitaroom:setfg(48,'wanitafg_nigeria.png')

wanitachar:move(48,{sx=2,sy=2})
wanitachar:playexpression(48,'barely')

window:move(48,{x=70,y=50},2,'outExpo')

palace = level:newdecoration('palace.png', 0, wanitaroom.index, 'palace')
palace:hide(0)
palace:move(0,{x=-50})
palace:show(48)
palace:move(50,{x=50},1,'outExpo')

palace:hide(52)
wanitaroom:setbg(52,'wbg_white.png')
wanitaroom:setfg(52,'wanitafg.png')
wanitachar:playexpression(52,'missed')

toomoney = newpopup('toomoney.png',-20)
toomoney:grow(48,70,120)
govt = newpopup('govt.png',-21)
govt:grow(48,70,150)
loveme = newpopup('loveme.png',-22)
loveme:grow(48,70,180)

toomoney:move(51,{y=20},1,'inSine')
wanitahop(52)

govt:move(55,{y=50},1,'inSine')
wanitahop(56)

loveme:move(57,{y=80},1,'inSine')
wanitahop(58)
wanitaroom:move(56,{x=20,y=50},2,'inExpo')

toomoney:shrink(60)
govt:shrink(60)
loveme:shrink(60)

wanitachar:playexpression(60,'happy')
wanitachar:playexpression(64,'happy')

wanitaroom:setfg(60,'wanitafg_desperate.png')
wanitaroom:setfg(61,'wanitafg_wealthy.png')
wanitaroom:setfg(62,'wanitafg_single.png')
wanitaroom:setfg(63,'wanitafg_christian.png')
wanitaroom:setfg(64,'wanitafg_allihave.png')

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

level:reorderrooms(65,2,0,3,1)





wanitaroom:move(68,{sx=0,sy=0})
level:reorderrooms(68,3,2,0,1)


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
	
	window:move(-2,{sx=1.8,sy=1.8,x=50,y=50},2,'inExpo')
	
	for i=0,7 do
		row0:setborder(i*7,'Outline','ffff00',100,0,'Linear')
		row0:setborder(i*7+0.5,'Outline','000000',10,0,'Linear')
	end
	
	for i=0,3 do
		window:move(i*14,{rot=10+(i*2)},3,'outExpo')
		window:move(i*14+3,{rot=0},4,'inExpo')
		window:move(i*14+7,{rot=-10-(i*2)},3,'outExpo')
		window:move(i*14+10,{rot=0},4,'inExpo')
		
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
	winman:lyric((7*7)+2,'trick')
	winman:lyric((7*7)+3,'dis')
	winman:lyric((7*7)+3.5,'cov')
	winman:lyric((7*7)+4,'ered')
	winman:lyric((7*7)+4.5,'by')
	winman:lyric((7*7)+5,'a')
	winman:lyric((7*7)+5.5,'mom')
	
	
	
end
	
	
	
chorus(68,true)
level:offset(124) -- beat 0 is now the start of social media section, code goes here