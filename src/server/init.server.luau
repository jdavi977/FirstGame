local ServerScriptService = game:GetService("ServerScriptService")
local PlayerClass = require(ServerScriptService.Server.Classes.Player)
local MonsterClass = require(ServerScriptService.Server.Classes.Monster)

-- Gets all players joining the game
local Players = game:GetService("Players")

local function addMonsterSlime()
	local slime = MonsterClass.new("Slime")
	print("Created monster of type: " .. slime.Type)
	return slime
end

local function addMonsterGoblin()
	local goblin = MonsterClass.new("Goblin")
	print("Created monster of type: " .. goblin.Type)
	return goblin
end

local function onMonsterDefeated(monster, player)
	if not monster:isAlive() then
		local xp = monster:getExperience()
		player:addXp(xp)
	end
end

local function onPlayerAdded(player)
	local state = PlayerClass.new(player)

	-- We use : to call methods that have self as the first parameter
	local displayName = state:getDisplayName()
	print(displayName)

	local stats = state:getStats()
	print("Initial Stats:")
	print(stats)

	-- print("Test Damage and XP")
	-- state:takeDamage(50)
	-- state:addXp(50)
	-- stats = state:getStats()
	-- print(stats)

	print("Test Fight")
	local goblin = addMonsterGoblin()
	while goblin:isAlive() do
		state:attack(goblin)
		print("Goblin Health: " .. goblin.Health)
	end

	onMonsterDefeated(goblin, state)

	stats = state:getStats()
	print("Player Stats after defeating Goblin:")
	print(stats)
end

Players.PlayerAdded:Connect(onPlayerAdded)
addMonsterSlime()
addMonsterGoblin()
