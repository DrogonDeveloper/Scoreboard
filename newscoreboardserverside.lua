addEventHandler("onPlayerJoin", root,
	function()
		for i, player in ipairs(getElementsByType("player")) do
			setElementData(source, "id", i);
		end
	end
);
currrentplayers = getPlayerCount()