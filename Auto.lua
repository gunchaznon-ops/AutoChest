local p=game:GetService("Players").LocalPlayer
local tS=game:GetService("TweenService")
local tP=game:GetService("TeleportService")
local rS=game:GetService("ReplicatedStorage")
local sEv=rS:WaitForChild("Connections"):WaitForChild("Spawn")
local placeId=137595477352660
repeat wait() until workspace:FindFirstChild("UserData")
local uD=workspace.UserData:WaitForChild("User_"..p.UserId)
repeat wait() until uD:FindFirstChild("Data")
local sN=uD.Data:WaitForChild("SpawnNumber")
sEv:FireServer(sN.Value)
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("HumanoidRootPart")
repeat wait() until uD:FindFirstChild("FullyLoaded") and uD.FullyLoaded.Value==true
local chests=workspace:WaitForChild("Chests"):GetChildren()
for _,ch in ipairs(chests) do
	if ch:IsA("Model") and ch.PrimaryPart then
		local tC=ch.PrimaryPart.CFrame+Vector3.new(0,2,0)
		local tw=tS:Create(h,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=tC})
		tw:Play()
		tw.Completed:Wait()
	elseif ch:IsA("BasePart") then
		local tC=ch.CFrame+Vector3.new(0,2,0)
		local tw=tS:Create(h,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=tC})
		tw:Play()
		tw.Completed:Wait()
	end
end

if _G.hopServer then
tP:Teleport(placeId,p)
end
