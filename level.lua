-- one weird tip
-- (discovered by a mom)

level:setuprooms()
level:reorderrooms(0,2,0,1,3)

windowroom = level.rooms[0]
bgroom = level.rooms[1]
decoroom = level.rooms[2]

ontop = level.rooms[4]


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



-- intro
bgroom:setbg(0,'wdbackground.png')
window:move(0,{x=50,y=50,sx=1,sy=1})

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



window:move(3.5,{x=65},2,'outExpo')
window:move(3.5,{rot=-10},1,'outQuad')

businessproposal = level:newdecoration('popuptemporary.png',-1,decoroom.index,'businessproposal')
businessproposal:move(0,{x=25,y=55,sx=0,sy=0})
businessproposal:move(3.5,{sx=0.5,sy=0.5},0.5,'outQuad')