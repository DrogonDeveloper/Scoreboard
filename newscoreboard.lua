local scoreboardVisible = false;

local asd = 1;

local tablePointer = 0; 

local currplayers = getElementsByType("player");

function getPlayerCount()
	return #getElementsByType("player")
end	

--for i=1, getPlayerCount()+32, 1 do
	--table.insert(currplayers, localPlayer)
--end

sX, sY = guiGetScreenSize()

setElementData(localPlayer, "playTime", 0);
setTimer(function()
	local playTime = getElementData(localPlayer, "playTime"); 
	setElementData(localPlayer, "playTime", playTime+1); 
end, 60000, 0);


addEventHandler("onClientRender", root,
	function()
		if (scoreboardVisible) then
			function getPlayerCount()
				return #getElementsByType("player")
			end	
			dxDrawRectangle(sX*0.35, sY*0.3, sX*0.3, sY*0.5, 0xCC000010)
			dxDrawRectangle(sX*0.6, sY*0.26, sX*0.05,sY*0.04, 0xC0000005)
			dxDrawLine(sX*0.6, sY*0.3, sX*0.65, sY*0.3)
			dxDrawLine(sX*0.6, sY*0.3, sX*0.6, sY*0.26)
			dxDrawLine(sX*0.6, sY*0.26, sX*0.65, sY*0.26)
			dxDrawLine(sX*0.65, sY*0.26, sX*0.65, sY*0.3)
			dxDrawText( getPlayerCount() .."/32", sX*0.605, sY*0.265, _, _, _, sY*2/1000, "arial")
			for i, player in ipairs(currplayers) do
				if (i <= 14) then
					local yMoving = 25*(i-1)
					local everythirdrectangle;
					if (i%3 == 0) then 
						everythirdrectangle = 0xCC2D242D;
					elseif (i%3 == 1) then
						everythirdrectangle = 0xCC3F3636;
					else
						everythirdrectangle = 0xCC302424;
					end
					dxDrawRectangle(sX*0.375, sY*0.325+yMoving, sX*0.25, sY*0.035, everythirdrectangle) --		ideide
					dxDrawLine(sX*0.375, sY*0.36+yMoving, sX*0.625, sY*0.36+yMoving) --0.29
					dxDrawLine(sX*0.4, sY*0.325+yMoving, sX*0.4, sY*0.36+yMoving)
					dxDrawText(i+tablePointer , sX*0.378, sY*0.33+yMoving, 0xFF2D1E24, _, _, sY*1.5/1000, "arial")	 --ID	
					dxDrawText(getPlayerName(currplayers[i+tablePointer]) .. "", sX*0.41, sY*0.33+yMoving, 0xFF2D1E24, _, _,sY*1.5/1000, "arial")		--playername		
					dxDrawText(getPlayerPing(currplayers[i+tablePointer]) .. "ms", sX*0.53, sY*0.33+yMoving, 0xFF2D1E24, _, _, sY*1.5/1000, "arial")	--ping
					dxDrawText(getElementData(currplayers[i+tablePointer], "playTime") .. " perc", sX*0.58, sY*0.33+yMoving, 0xDD2D1E24, _, _, sY*1.5/1000, "arial") --online since
				end
			end
		end
	end
);

function isCursorInArea(x,y, x2,y2)
	if (isCursorShowing()) then
		local cX, cY = getCursorPosition();
		if ( (cX >= x) and (cY >= y) and (cX <= x2) and (cY <= y2) ) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

addEventHandler("onClientKey", root,
	function(key, pOr)
		if (key == "mouse_wheel_up") then 
			if (tablePointer > 0) then 
				tablePointer = tablePointer - 1; 
			end
		elseif (key == "mouse_wheel_down") then 
			if (tablePointer < #currplayers - 14) then 
				tablePointer = tablePointer + 1; 
			end
		end
	end
);

function toggleScoreboard() 
	currPlayers = getElementsByType("player");
	if (not scoreboardVisible) then 
		if (#currPlayers > 14) then 
			if (tablePointer > #currPlayers-14) then 
				tablePointer = #currPlayers-14; 
			end
		else
			tablePointer = 0;
		end
	end
	scoreboardVisible = not scoreboardVisible;  
end
addCommandHandler("scoreboard", toggleScoreboard, false);

-- only for security 
if (getKeyState("tab")) then
	bindTimer = setTimer(function()
		if not (getKeyState("tab")) then
			bindKey("tab", "both", toggleScoreboard);
			killTimer(bindTimer);
		end
	end, 50, 0);
else
	bindKey("tab", "both", toggleScoreboard);
end

--		:) done



