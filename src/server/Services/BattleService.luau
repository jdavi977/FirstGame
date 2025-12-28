local BattleService = {}

function BattleService.defeatReward(player, monster)
	player.addXp(monster:getExperience())
end

function BattleService.startBattle(player, monster)
	print("Battle Started")
	while player.isAlive() and monster.isAlive do
		monster:takeDamage(player.AttackPoints)
		if monster.isAlive() then
			player:takeDamage(monster.AttackPoints)
			if not monster.isAlive() then
				BattleService.defeatReward(player, monster)
			end
		end
	end
	print("Battle ended")
end

return BattleService
