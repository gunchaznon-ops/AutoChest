if _G.hopServer then
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
local chests=workspace:WaitForChild("Chests")
while #chests:GetChildren()>0 do
for _,ch in ipairs(chests:GetChildren()) do
if ch:IsA("Model") and ch.PrimaryPart then
local tC=ch.PrimaryPart.CFrame+Vector3.new(0,2,0)
local tw=tS:Create(h,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=tC})
tw:Play()tw.Completed:Wait()task.wait(0.3)
elseif ch:IsA("BasePart") then
local tC=ch.CFrame+Vector3.new(0,2,0)
local tw=tS:Create(h,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=tC})
tw:Play()tw.Completed:Wait()task.wait(0.01)
end
end
end
tP:Teleport(placeId,p)
else
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local TeleportService=game:GetService("TeleportService")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local screenGui=Instance.new("ScreenGui")
screenGui.Name="AutoChest"
screenGui.Parent=playerGui
local frame=Instance.new("Frame")
frame.Size=UDim2.new(0,220,0,120)
frame.Position=UDim2.new(0.5,-110,0.5,-60)
frame.BackgroundColor3=Color3.fromRGB(50,150,255)
frame.Active=true
frame.Draggable=false
frame.Parent=screenGui
local closeButton=Instance.new("TextButton")
closeButton.Size=UDim2.new(0,25,0,25)
closeButton.Position=UDim2.new(1,-30,0,5)
closeButton.BackgroundColor3=Color3.fromRGB(200,50,50)
closeButton.Text="X"
closeButton.Parent=frame
local minimizeButton=Instance.new("TextButton")
minimizeButton.Size=UDim2.new(0,25,0,25)
minimizeButton.Position=UDim2.new(1,-60,0,5)
minimizeButton.BackgroundColor3=Color3.fromRGB(255,200,50)
minimizeButton.Text="-"
minimizeButton.Parent=frame
local runButton=Instance.new("TextButton")
runButton.Size=UDim2.new(0,100,0,40)
runButton.Position=UDim2.new(0.5,-50,0.5,-20)
runButton.BackgroundColor3=Color3.fromRGB(100,255,100)
runButton.Text="Run"
runButton.Parent=frame
local openGuiButton=Instance.new("TextButton")
openGuiButton.Size=UDim2.new(0,50,0,25)
openGuiButton.Position=UDim2.new(0,10,0.8,0)
openGuiButton.BackgroundColor3=Color3.fromRGB(150,150,150)
openGuiButton.Text="Open"
openGuiButton.Visible=false
openGuiButton.Active=true
openGuiButton.Parent=screenGui
closeButton.MouseButton1Click:Connect(function()screenGui:Destroy()end)
minimizeButton.MouseButton1Click:Connect(function()frame.Visible=false openGuiButton.Visible=true end)
openGuiButton.MouseButton1Click:Connect(function()frame.Visible=true openGuiButton.Visible=false end)
local function makeDraggable(gui)
local dragging,dragInput,dragStart,startPos
gui.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
dragStart=input.Position
startPos=gui.Position
input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then
dragging=false
end
end)
end
end)
gui.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then
dragInput=input
end
end)
UserInputService.InputChanged:Connect(function(input)
if input==dragInput and dragging then
local delta=input.Position-dragStart
gui.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)
end
makeDraggable(frame)
makeDraggable(openGuiButton)
local placeId=137595477352660
runButton.MouseButton1Click:Connect(function()
local character=player.Character or player.CharacterAdded:Wait()
local humanoidRootPart=character:WaitForChild("HumanoidRootPart")
local chestsFolder=workspace:WaitForChild("Chests")
while #chestsFolder:GetChildren()>0 do
for _,chest in ipairs(chestsFolder:GetChildren()) do
if humanoidRootPart then
local targetCFrame
if chest:IsA("Model") and chest.PrimaryPart then
targetCFrame=chest.PrimaryPart.CFrame+Vector3.new(0,2,0)
elseif chest:IsA("BasePart") then
targetCFrame=chest.CFrame+Vector3.new(0,2,0)
end
if targetCFrame then
local tween=TweenService:Create(humanoidRootPart,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=targetCFrame})
tween:Play()tween.Completed:Wait()task.wait(0.01)
end
end
end
end
end)
end
