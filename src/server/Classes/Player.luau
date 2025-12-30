local ServerScriptService = game:GetService("ServerScriptService")
local types = require(ServerScriptService.Server.Engine.Types)

local Player = {}

-- Allows Player.methods to be called on Player instances
Player.__index = Player

function Player.new(player)
	local self = setmetatable({}, Player)

	self.UserId = player.UserId
	self.Name = player.Name

	-- self.CombatStats = {
	-- 	Health = 100,
	-- 	AttackPoints = 10,
	-- 	Level = 1,
	-- 	Xp = 0,
	-- }

	self.Health = 100
	self.AttackPoints = 10
	self.Level = 1
	self.Xp = 0

	return self
end

function Player.getDisplayName(self)
	-- .. is for String concatenation in Lua, we use .. instead of +
	return self.Name .. " (ID: " .. self.UserId .. ")"
end

function Player.takeDamage(self, damage)
	self.Health = math.max(self.Health - damage, 0)
end

function Player.attack(self, target)
	target:takeDamage(self.AttackPoints)
end

function Player.levelUp(self)
	self.Level = self.Level + 1
	self.Health = self.Health + 20
	self.AttackPoints = self.AttackPoints + 5
end

function Player.addXp(self, xp)
	self.Xp = self.Xp + xp
	if self.Xp >= self.Level * 100 then
		self:levelUp()
		self.Xp = 0
	end
end

function Player.getStats(self)
	return {
		Health = self.Health,
		AttackPoints = self.AttackPoints,
		Level = self.Level,
		Xp = self.Xp,
	}
end

function Player.isAlive(self)
	return self.Health > 0
end

return Player
