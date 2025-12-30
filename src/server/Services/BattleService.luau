local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService = require(ServerScriptService.Server.Services.PlayerService)

local BattleService = {}

function BattleService.defeatReward(player, monsterState)
	print("Player defeated monster and gained experience")
	player:addXp(monsterState:getExperience())
end

function BattleService.startBattle(player, monsterState)
	local playerState = PlayerService.getPlayerState(player)
	print("Battle Started")
	while playerState:isAlive() and monsterState:isAlive() do
		print("Monster health: " .. monsterState.Health)
		monsterState:takeDamage(playerState.AttackPoints)
		if monsterState:isAlive() then
			playerState:takeDamage(monsterState.AttackPoints)
			if not playerState:isAlive() then
				print("Player has been defeated!")
				PlayerService.death(player)
			end
		end
		if not monsterState:isAlive() then
			BattleService.defeatReward(playerState, monsterState)
		end
		task.wait(1)
	end
	print("Battle ended")
end

return BattleService
