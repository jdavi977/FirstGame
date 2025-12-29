local BattleService = {}

function BattleService.defeatReward(player, monster)
	print("Player defeated monster and gained experience")
	player:addXp(monster:getExperience())
end

function BattleService.startBattle(player, monster)
	print("Battle Started")
	while player:isAlive() and monster:isAlive() do
		monster:takeDamage(player.AttackPoints)
		if monster:isAlive() then
			player:takeDamage(monster.AttackPoints)
			task.wait(2)
		end
		if not monster:isAlive() then
			BattleService.defeatReward(player, monster)
		end
	end
	print("Battle ended")
end

return BattleService
