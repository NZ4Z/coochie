local meta = getrawmetatable(game); -- by dot_mp4 FUCKING OBVIOUSLY BECAUSE DUDE (JEREMY HERE) I CANNOT BOTHER WITH LOOL? META TABLES
local index, namecall, newindex = meta.__index, meta.__namecall, meta.__newindex;

getgenv().aimVelocity = 7
getgenv().aimlockTarget = nil
getgenv().aimlockEnabled = false

getgenv().returnAimbot = function()
    if (aimlockEnabled and aimlockTarget) and (aimlockTarget.Character and aimlockTarget.Character.FindFirstChild(target.Character, 'Head') and aimlockTarget.Character.FindFirstChild(target.Character, 'Torso')) then
        local targetChar = aimlockTarget.Character
        local hitPart, velocityPart = targetChar.Head, targetChar.Torso
        return (hitPart.CFrame + velocityPart.Velocity / aimVelocity)
    end
    return false
end


local detectedProps = {
    "bv";
    "hb";
    "WalkSpeed";
    "JumpPower";
    "HipHeight";
    "Health"
}

local function IsA(self, prop)
    return self.IsA(self, prop)
end

local fakeBv = Instance.new'BodyVelocity';
fakeBv.Name = 'Tempby';

setreadonly(meta, false)

meta.__index = newcclosure(function(self, indexed)
    if getcallingscript() ~= script then
        if indexed == 'Name' and (IsA(self, 'BodyPosition') or IsA(self, 'BodyVelocity') or IsA(self, 'BodyGyro')) then
            return fakeBv;
        end
    end
    return index(self, indexed);
end)

meta.__newindex = newcclosure(function(self, key, value)
    if not checkcaller() then
        if self:IsDescendantOf(game.Players.LocalPlayer.Character) and (key == 'CFrame') then
            return wait(9e9);
        end 

        if IsA(self, 'Humanoid') then
            game.StarterGui:SetCore('ResetButtonCallback', true)
            if (key == 'WalkSpeed' or key == 'JumpPower' or key == 'HipHeight' or key == 'Health') then
                return;
            end
        end
    end
    return newindex(self, key, value);
end)

meta.__namecall = newcclosure(function(self, ...)
    local method, args = getnamecallmethod(), {...};
    
    if not checkcaller() then
        if (method == 'FireServer') then
            if (table.find(detectedProps, args[1]) or self.Parent == game.ReplicatedStorage) then
                return wait(9e9);
            end
            if (args[1] == 'ws') then
                args[2].w = args[2].z;
            end
            if (args[2] and args[2].mousehit) then
                if returnAimbot() then
                    args[2].mousehit = returnAimbot()
                    return namecall(self, unpack(args))
                end
            end
        end

        if (method == 'Kick' or method == 'Destroy') and (self == game.Players.LocalPlayer) then
            return wait(9e9);
        end
        if (method == 'ClearAllChildren' or method == 'BreakJoints') and self == game.Players.LocalPlayer.Character then
            return wait(9e9);
        end
        if (method == 'Destroy') and (IsA(self, 'BodyVelocity') or IsA(self, 'BodyPosition') or IsA(self, 'BodyGyro')) then
            return wait(9e9);
        end
    end

    return namecall(self, unpack(args))
end)

setreadonly(meta, true)
