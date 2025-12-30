--!strict
local Players = game:GetService("Players")

local Types = {}

export type CombatStats = {
	Health: number,
	AttackPoints: number,
	Level: number,
	Xp: number,
}

return Types
