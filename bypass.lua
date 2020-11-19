-- by dot_mp4

local detectedProperties = {
    "WalkSpeed";
    "JumpPower";
    "HipHeight";
    "Health";
}

local meta = getrawmetatable(game);
local oldNamecall, oldNewindex, oldIndex = meta.__namecall, meta.__newindex, meta.__index;

local fakeBodyVelocity = Instance.new'BodyVelocity';
fakeBodyVelocity.Name = 'Tempby';

setreadonly(meta, false);

local funcs = {
    namecall = function(self, ...)
        local arguments = {...}
        local namecallMethod = getnamecallmethod();

        if (namecallMethod == 'FireServer') then
            if self.Parent == game.ReplicatedStorage then
                return wait(9e9);
            end
            if table.find(detectedProperties, arguments[1]) then
                return wait(9e9);
            end
            if self.Name == 'Input' then
                if (arguments[1] == 'bv' or arguments[1] == 'hb') then
                    return wait(9e9);
                end
                if (arguments[1] == 'ws') then
                    return wait(9e9);
                end
            end
        end
        if (namecallMethod == 'Kick' or namecallMethod == 'Destroy') and (self == game.Players.LocalPlayer) then
            return wait(9e9);
        end
        if game.Players.LocalPlayer.Character and ((self == game.Players.LocalPlayer.Character and namecallMethod == 'ClearAllChildren') or (self == game.Players.LocalPlayer.Character and namecallMethod == 'BreakJoints')) then
            return wait(9e9);
        end
        if (namecallMethod == 'Destroy') and (self.Name == 'BodyGyro' or self.Name == 'BodyVelocity' or self.Name == 'BodyPosition') then
            return wait(9e9);
        end

        return oldNamecall(self, unpack(arguments));
    end;
    newindex = function(self, key, value)
        if checkcaller() then
            return oldNewindex(self, key, value);
        end

        if self:IsDescendantOf(game.Players.LocalPlayer.Character) and (key == 'CFrame') then
            return wait(9e9);
        end
        if (self:IsA'Humanoid') then
            game.StarterGui:SetCore('ResetButtonCallback', true);
            if (key == 'Health' or key == 'WalkSpeed' or key == 'JumpPower' or key == 'HipHeight') then
                return;
            end
        end

        return oldNewindex(self, key, value);
    end;
}

meta.__namecall = newcclosure(funcs.namecall);
meta.__newindex = newcclosure(funcs.newindex);

setreadonly(meta, true);
