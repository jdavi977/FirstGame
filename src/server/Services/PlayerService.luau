local ServerScriptService = game:GetService("ServerScriptService")
local PlayerClass = require(ServerScriptService.Server.Classes.Player)

local Players = game:GetService("Players")
local PlayerService = {}
local playerStates = {}

function PlayerService.start()
	Players.PlayerAdded:Connect(function(player)
		local state = PlayerClass.new(player)
		playerStates[player] = state
		print("Player added: " .. state:getDisplayName())
	end)

	Players.PlayerRemoving:Connect(function(player)
		playerStates[player] = nil
	end)
end

return PlayerService
