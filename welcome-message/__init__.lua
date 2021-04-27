function show_message(player)
	local elem = game:newclienthudelem(player)
	elem.elemType = "font"
	elem.font = "default"
	elem.fontscale = 2
	elem.x = 0
	elem.y = -100
	elem.alignx = "center"
	elem.aligny = "middle"
	elem.horzalign = "center"
	elem.vertalign = "middle"
	--elem.glowcolor = vector:new(1.0, 1.0, 1.0)
	--elem.glowalpha = 0.5
	elem.color = vector:new(1.0, 1.0, 1.0)
	elem.alpha = 1
	elem:settext("^3Welcome to the ^4X Labs^3 server")
	elem:setpulsefx(40, 6000, 600)

	game:ontimeout(function()
		elem:destroy()
	end, 8000)
end

function on_first_spawn(player)
	game:ontimeout(function()
		show_message(player)
	end, 600)
	
end

function player_connected(player)
	local timer = player:onnotifyonce("spawned_player", function() on_first_spawn(player) end)
	player:onnotifyonce("disconnect", function() timer:clear() end)
end

if game:getdvar("gamemode") == "mp" then
	level:onnotify("connected", player_connected)
end
