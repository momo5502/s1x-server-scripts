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

	game:ontimeout(
		function()
			elem:destroy()
		end,
		8000
	)
end

function change_vision(player)
	player:visionsetnakedforplayer("grayscale", 0)

	game:ontimeout(
		function()
			local mapname = game:getdvar("mapname")
			player:visionsetnakedforplayer(mapname, 2)
		end,
		7000
	)
end

function on_first_spawn(player)
	change_vision(player)

	game:ontimeout(
		function()
			show_message(player)
		end,
		600
	)
end

function player_connected(player)
	local timer =
		player:onnotifyonce(
		"spawned_player",
		function()
			on_first_spawn(player)
		end
	)
	timer:endon(player, "disconnect")
end

if game:getdvar("gamemode") == "mp" then
	level:onnotify("connected", player_connected)
end
