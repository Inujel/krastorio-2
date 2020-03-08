-- Cheat Stuff
function givePatreonItems(event)
	local patreons =
	{
		["Krastor"] = true,
		["Linver"] = true,
		["jonasrejman"] = true,
		["Wassabee"] = true
	}
	
	if patreons[game.players[event.player_index].name] then
		local inventory = game.players[event.player_index].get_main_inventory()
		local patreon_items = 
		{
			{ name="kr-armored-shelter", count=1 }
		}
		for _, item in pairs(patreon_items) do
			if inventory.can_insert(item) then
				inventory.insert(item)
			end
		end
	end
end

return
{
	{ givePatreonItems, "on_player_created" }
}
	