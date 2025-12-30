local BattleService = {}

function BattleService.defeatReward(player, monster)
	print("Player defeated monster and gained experience")
	player:addXp(monster:getExperience())
end

function BattleService.startBattle(player, monster)
	print("Battle Started")
	while player:isAlive() and monster:isAlive() do
		print("Monster health: " .. monster.Health)
		monster:takeDamage(player.AttackPoints)
		if monster:isAlive() then
			player:takeDamage(monster.AttackPoints)
			if not player:isAlive() then
				print("Player has been defeated!")
			end
		end
		if not monster:isAlive() then
			BattleService.defeatReward(player, monster)
		end
		task.wait(1)
	end
	print("Battle ended")
end

return BattleService
