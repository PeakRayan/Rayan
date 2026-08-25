--[[
    PeakRayan Hub - Roblox UI Script
    By: 7aliv9
    Tabs: نسخ (Copy) | تحكم (Control) | سبام اكسترا
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function getGuiParent()
    local ok, hidden = pcall(function() return gethui() end)
    if ok and hidden then return hidden end
    local ok2, cg = pcall(function() return CoreGui end)
    if ok2 and cg then return cg end
    return PlayerGui
end
local guiParent = getGuiParent()

pcall(function()
    for _, n in ipairs({"PeakRayanHub","PeakRayanMini","PeakRayanSplash"}) do
        local old = guiParent:FindFirstChild(n)
        if old then old:Destroy() end
        local old2 = PlayerGui:FindFirstChild(n)
        if old2 then old2:Destroy() end
    end
end)

----------------------------------------------------------------
-- اشعار فريق PeakRayan بعد دقيقتين
----------------------------------------------------------------
local function getAvatar(username)
    local ok1, uid = pcall(function()
        return Players:GetUserIdFromNameAsync(username)
    end)
    if not ok1 then return "" end
    local ok2, url = pcall(function()
        return Players:GetUserThumbnailAsync(uid, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420)
    end)
    return ok2 and url or ""
end

local function showTeamCard()
    pcall(function()
        local sg = Instance.new("ScreenGui")
        sg.Name = "PeakRayan_TeamCard"
        sg.DisplayOrder = 9999997
        sg.IgnoreGuiInset = true
        sg.ResetOnSpawn = false
        pcall(function() sg.Parent = CoreGui end)
        if not sg.Parent then sg.Parent = PlayerGui end

        local overlay = Instance.new("Frame", sg)
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.5
        overlay.BorderSizePixel = 0

        local card = Instance.new("Frame", sg)
        card.Size = UDim2.new(0, 340, 0, 0)
        card.AnchorPoint = Vector2.new(0.5, 0.5)
        card.Position = UDim2.new(0.5, 0, 0.65, 0)
        card.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
        card.BackgroundTransparency = 0.05
        card.BorderSizePixel = 0
        card.AutomaticSize = Enum.AutomaticSize.Y
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 18)
        local stroke = Instance.new("UIStroke", card)
        stroke.Color = Color3.fromRGB(0, 200, 255)
        stroke.Thickness = 1.8
        stroke.Transparency = 0.2

        local pad = Instance.new("UIPadding", card)
        pad.PaddingTop    = UDim.new(0, 16)
        pad.PaddingBottom = UDim.new(0, 20)
        pad.PaddingLeft   = UDim.new(0, 16)
        pad.PaddingRight  = UDim.new(0, 16)

        local layout = Instance.new("UIListLayout", card)
        layout.Padding = UDim.new(0, 14)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local title = Instance.new("TextLabel", card)
        title.Size = UDim2.new(1, 0, 0, 26)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = "PeakRayan Hub"
        title.TextSize = 17
        title.TextColor3 = Color3.fromRGB(0, 210, 255)
        title.TextXAlignment = Enum.TextXAlignment.Center
        title.LayoutOrder = 1

        local div = Instance.new("Frame", card)
        div.Size = UDim2.new(1, 0, 0, 1)
        div.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        div.BackgroundTransparency = 0.5
        div.BorderSizePixel = 0
        div.LayoutOrder = 2

        local function makePersonCard(username, roleText, order)
            local avatarUrl = getAvatar(username)
            local row = Instance.new("Frame", card)
            row.Size = UDim2.new(1, 0, 0, 90)
            row.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
            row.BackgroundTransparency = 0.3
            row.BorderSizePixel = 0
            row.LayoutOrder = order
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 12)

            local img = Instance.new("ImageLabel", row)
            img.Size = UDim2.new(0, 72, 0, 72)
            img.Position = UDim2.new(0, 10, 0.5, -36)
            img.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
            img.BorderSizePixel = 0
            img.Image = avatarUrl
            Instance.new("UICorner", img).CornerRadius = UDim.new(0, 36)
            local imgStroke = Instance.new("UIStroke", img)
            imgStroke.Color = Color3.fromRGB(0, 200, 255)
            imgStroke.Thickness = 2
            imgStroke.Transparency = 0.1

            local nameLbl = Instance.new("TextLabel", row)
            nameLbl.Size = UDim2.new(1, -96, 0, 32)
            nameLbl.Position = UDim2.new(0, 90, 0.5, -30)
            nameLbl.BackgroundTransparency = 1
            nameLbl.Font = Enum.Font.GothamBold
            nameLbl.Text = "@" .. username
            nameLbl.TextSize = 14
            nameLbl.TextColor3 = Color3.fromRGB(220, 240, 255)
            nameLbl.TextXAlignment = Enum.TextXAlignment.Right

            local roleLbl = Instance.new("TextLabel", row)
            roleLbl.Size = UDim2.new(1, -96, 0, 28)
            roleLbl.Position = UDim2.new(0, 90, 0.5, 4)
            roleLbl.BackgroundTransparency = 1
            roleLbl.Font = Enum.Font.GothamSemibold
            roleLbl.Text = roleText
            roleLbl.TextSize = 13
            roleLbl.TextColor3 = Color3.fromRGB(0, 210, 255)
            roleLbl.TextXAlignment = Enum.TextXAlignment.Right
        end

        makePersonCard("7aliv9", "المطور", 3)

        local closeBtn = Instance.new("TextButton", card)
        closeBtn.Size = UDim2.new(1, 0, 0, 34)
        closeBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
        closeBtn.BackgroundTransparency = 0.1
        closeBtn.BorderSizePixel = 0
        closeBtn.AutoButtonColor = false
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.Text = "حسناً"
        closeBtn.TextSize = 14
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.LayoutOrder = 4
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)
        closeBtn.MouseEnter:Connect(function()
            TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
        end)
        closeBtn.MouseLeave:Connect(function()
            TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(0, 140, 200)}):Play()
        end)

        card.BackgroundTransparency = 1
        overlay.BackgroundTransparency = 1
        TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0.05}):Play()

        local function closeCard()
            TweenService:Create(card,    TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
            TweenService:Create(overlay, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
            task.delay(0.28, function() pcall(function() sg:Destroy() end) end)
        end
        closeBtn.MouseButton1Click:Connect(closeCard)
    end)
end

task.delay(120, function() showTeamCard() end)

----------------------------------------------------------------
-- ما الجديد
----------------------------------------------------------------
local function showWhatsNew()
    local wsg = Instance.new("ScreenGui")
    wsg.Name = "PeakRayan_WhatsNew"
    wsg.DisplayOrder = 9999998
    wsg.IgnoreGuiInset = true
    wsg.ResetOnSpawn = false
    wsg.Parent = CoreGui

    local overlay = Instance.new("Frame", wsg)
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 0.45
    overlay.BorderSizePixel = 0

    local card = Instance.new("Frame", wsg)
    card.Size = UDim2.new(0, 400, 0, 0)
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.new(0.5, 0, 0.5, 0)
    card.BackgroundColor3 = Color3.fromRGB(6, 18, 10)
    card.BackgroundTransparency = 0.08
    card.BorderSizePixel = 0
    card.AutomaticSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)
    local cs = Instance.new("UIStroke", card)
    cs.Color = Color3.fromRGB(0, 230, 110); cs.Thickness = 1.8; cs.Transparency = 0.15

    local cpad = Instance.new("UIPadding", card)
    cpad.PaddingTop = UDim.new(0, 16); cpad.PaddingBottom = UDim.new(0, 18)
    cpad.PaddingLeft = UDim.new(0, 18); cpad.PaddingRight = UDim.new(0, 18)

    local layout = Instance.new("UIListLayout", card)
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local titleRow = Instance.new("Frame", card)
    titleRow.Size = UDim2.new(1, 0, 0, 30)
    titleRow.BackgroundTransparency = 1
    titleRow.LayoutOrder = 1
    local tLayout = Instance.new("UIListLayout", titleRow)
    tLayout.FillDirection = Enum.FillDirection.Horizontal
    tLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local titleLbl = Instance.new("TextLabel", titleRow)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = "PeakRayan Hub — ما الجديد"
    titleLbl.TextSize = 18
    titleLbl.TextColor3 = Color3.fromRGB(0, 255, 130)
    titleLbl.AutomaticSize = Enum.AutomaticSize.XY

    local divider = Instance.new("Frame", card)
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    divider.BackgroundTransparency = 0.6
    divider.BorderSizePixel = 0
    divider.LayoutOrder = 2

    local bodyLines = {
        "التحديثات الجديدة",
        "",
        "تم تغيير الانترو الى انترو جديد",
        "تم تغيير ريموت الشات في خانة النسخ",
        "تم اضافة زرين في خانة النسخ:",
        "   اسم كامل — يرسل الاوامر بالاسم الكامل",
        "   ثلاث حروف — يرسل الاوامر باول 3 حروف فقط",
        "تم اضافة مراقبة الشات وتقليد الشات",
        "",
        "حسابي روب: 7aliv9",
    }

    local bodyLbl = Instance.new("TextLabel", card)
    bodyLbl.Size = UDim2.new(1, 0, 0, 0)
    bodyLbl.AutomaticSize = Enum.AutomaticSize.Y
    bodyLbl.BackgroundTransparency = 1
    bodyLbl.Font = Enum.Font.GothamSemibold
    bodyLbl.Text = table.concat(bodyLines, "\n")
    bodyLbl.TextSize = 14
    bodyLbl.TextColor3 = Color3.fromRGB(200, 245, 215)
    bodyLbl.TextXAlignment = Enum.TextXAlignment.Right
    bodyLbl.TextWrapped = true
    bodyLbl.LayoutOrder = 3

    local closeBtn = Instance.new("TextButton", card)
    closeBtn.Size = UDim2.new(1, 0, 0, 36)
    closeBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 70)
    closeBtn.BackgroundTransparency = 0.1
    closeBtn.BorderSizePixel = 0
    closeBtn.AutoButtonColor = false
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "فاهمت، يلا نبدا"
    closeBtn.TextSize = 15
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.LayoutOrder = 4
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(0, 210, 90)}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(0, 160, 70)}):Play()
    end)

    card.Position = UDim2.new(0.5, 0, 0.65, 0)
    card.BackgroundTransparency = 1
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0.08}):Play()

    local closed = false
    local function closeWhatsNew()
        if closed then return end; closed = true
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.22, function() pcall(function() wsg:Destroy() end) end)
    end
    closeBtn.MouseButton1Click:Connect(closeWhatsNew)
end

local function runSplash()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/Antro/refs/heads/main/README.md"))()
    end)
    task.delay(0.5, function() showWhatsNew() end)
end
pcall(runSplash)

----------------------------------------------------------------
-- Main GUI
----------------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "PeakRayanHub"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.DisplayOrder = 9000
pcall(function() gui.Parent = guiParent end)
if not gui.Parent then gui.Parent = PlayerGui end

local main = Instance.new("Frame", gui)
main.Name = "Main"; main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0); main.Size = UDim2.new(0, 520, 0, 360)
main.BackgroundColor3 = Color3.fromRGB(6, 16, 9); main.BackgroundTransparency = 0.42
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local mStroke = Instance.new("UIStroke", main)
mStroke.Color = Color3.fromRGB(0, 230, 110); mStroke.Thickness = 1.4; mStroke.Transparency = 0.25
local mGradient = Instance.new("UIGradient", main)
mGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 30, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 12, 7)),
}
mGradient.Rotation = 135

local glow = Instance.new("Frame", main)
glow.BackgroundColor3 = Color3.fromRGB(0, 255, 130); glow.BorderSizePixel = 0
glow.Size = UDim2.new(1, 0, 0, 2); glow.Position = UDim2.new(0, 0, 0, 44)
local glowGrad = Instance.new("UIGradient", glow)
glowGrad.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.2),
    NumberSequenceKeypoint.new(1, 1),
}
task.spawn(function()
    while glow.Parent do
        glowGrad.Offset = Vector2.new(-1, 0)
        TweenService:Create(glowGrad, TweenInfo.new(2.2, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)}):Play()
        task.wait(2.2)
    end
end)

local title = Instance.new("TextLabel", main)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -90, 0, 44); title.Position = UDim2.new(0, 16, 0, 0)
title.Font = Enum.Font.GothamBlack; title.Text = "PeakRayan | 7aliv9"
title.TextSize = 22; title.TextColor3 = Color3.fromRGB(0, 255, 130)
title.TextXAlignment = Enum.TextXAlignment.Left

----------------------------------------------------------------
-- Close + Minimize
----------------------------------------------------------------
local closeBtn = Instance.new("TextButton", main)
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.Position = UDim2.new(1, -8, 0, 8)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
closeBtn.BackgroundTransparency = 0.3; closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"; closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(180, 255, 200); closeBtn.TextSize = 16
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
local closeStroke = Instance.new("UIStroke", closeBtn)
closeStroke.Color = Color3.fromRGB(0, 200, 100); closeStroke.Transparency = 0.4
closeBtn.MouseEnter:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1}):Play() end)
closeBtn.MouseLeave:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play() end)

local minBtn = Instance.new("TextButton", main)
minBtn.AnchorPoint = Vector2.new(1, 0)
minBtn.Position = UDim2.new(1, -44, 0, 8)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 45)
minBtn.BackgroundTransparency = 0.2; minBtn.BorderSizePixel = 0
minBtn.Text = ""; minBtn.AutoButtonColor = false
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)
local minStroke = Instance.new("UIStroke", minBtn)
minStroke.Color = Color3.fromRGB(0, 255, 130); minStroke.Transparency = 0.2; minStroke.Thickness = 1.4
minBtn.MouseEnter:Connect(function() TweenService:Create(minBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play() end)
minBtn.MouseLeave:Connect(function() TweenService:Create(minBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play() end)

----------------------------------------------------------------
-- Mini bubble
----------------------------------------------------------------
local miniGui = Instance.new("ScreenGui")
miniGui.Name = "PeakRayanMini"; miniGui.ResetOnSpawn = false; miniGui.IgnoreGuiInset = true
miniGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; miniGui.DisplayOrder = 9001
pcall(function() miniGui.Parent = guiParent end)
if not miniGui.Parent then miniGui.Parent = PlayerGui end

local miniBubble = Instance.new("TextButton", miniGui)
miniBubble.AnchorPoint = Vector2.new(0, 0.5)
miniBubble.Position = UDim2.new(0, 16, 0.5, 0)
miniBubble.Size = UDim2.new(0, 44, 0, 44)
miniBubble.BackgroundColor3 = Color3.fromRGB(0, 110, 55)
miniBubble.BackgroundTransparency = 0.15; miniBubble.BorderSizePixel = 0
miniBubble.AutoButtonColor = false
miniBubble.Text = "PR"
miniBubble.Font = Enum.Font.GothamBlack
miniBubble.TextSize = 13
miniBubble.TextColor3 = Color3.fromRGB(230, 255, 240)
miniBubble.Visible = true
Instance.new("UICorner", miniBubble).CornerRadius = UDim.new(1, 0)
local miniStroke = Instance.new("UIStroke", miniBubble)
miniStroke.Color = Color3.fromRGB(0, 255, 130); miniStroke.Thickness = 1.6; miniStroke.Transparency = 0.2

task.spawn(function()
    while miniGui.Parent do
        if miniBubble.Visible then
            TweenService:Create(miniStroke, TweenInfo.new(0.7), {Transparency = 0.7}):Play(); task.wait(0.7)
            TweenService:Create(miniStroke, TweenInfo.new(0.7), {Transparency = 0.15}):Play(); task.wait(0.7)
        else
            task.wait(0.2)
        end
    end
end)

local function setHidden(hidden)
    if hidden then
        TweenService:Create(main, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        task.wait(0.22)
        main.Visible = false
        main.Size = UDim2.new(0, 520, 0, 360)
        main.BackgroundTransparency = 0.42
    else
        main.Visible = true
        main.Size = UDim2.new(0, 0, 0, 0)
        main.BackgroundTransparency = 1
        TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 520, 0, 360), BackgroundTransparency = 0.42}):Play()
    end
end

minBtn.MouseButton1Click:Connect(function() setHidden(true) end)
miniBubble.MouseButton1Click:Connect(function() setHidden(main.Visible) end)
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(main, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.22); gui:Destroy(); miniGui:Destroy()
end)

----------------------------------------------------------------
-- Drag
----------------------------------------------------------------
local function makeDraggable(handle, target)
    local dragging, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(title, main)
makeDraggable(miniBubble, miniBubble)

----------------------------------------------------------------
-- Tab bar
----------------------------------------------------------------
local tabBar = Instance.new("Frame", main)
tabBar.BackgroundTransparency = 1
tabBar.Position = UDim2.new(0, 16, 0, 56); tabBar.Size = UDim2.new(1, -32, 0, 36)
local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal; tabLayout.Padding = UDim.new(0, 8)

local pages, tabButtons = {}, {}

local function makeTab(name)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(0, 130, 1, 0); btn.BackgroundColor3 = Color3.fromRGB(8, 30, 14)
    btn.BackgroundTransparency = 0.4; btn.BorderSizePixel = 0; btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold; btn.Text = name; btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(160, 230, 180)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(0, 200, 100); s.Transparency = 0.6

    local page = Instance.new("Frame", main)
    page.Position = UDim2.new(0, 16, 0, 100); page.Size = UDim2.new(1, -32, 1, -116)
    page.BackgroundColor3 = Color3.fromRGB(4, 12, 7); page.BackgroundTransparency = 0.55
    page.BorderSizePixel = 0; page.Visible = false
    Instance.new("UICorner", page).CornerRadius = UDim.new(0, 10)
    local ps = Instance.new("UIStroke", page); ps.Color = Color3.fromRGB(0, 180, 90); ps.Transparency = 0.7

    pages[name] = page; tabButtons[name] = btn
    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(pages) do p.Visible = (n == name) end
        for n, b in pairs(tabButtons) do
            if n == name then
                TweenService:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.1, TextColor3 = Color3.fromRGB(0, 255, 130)}):Play()
            else
                TweenService:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.55, TextColor3 = Color3.fromRGB(160, 230, 180)}):Play()
            end
        end
    end)
    return page
end

local copyPage    = makeTab("نسخ")
local controlPage = makeTab("تحكم")
local extraPage   = makeTab("سبام اكسترا")

----------------------------------------------------------------
-- Page: نسخ
----------------------------------------------------------------
local selectedNames = {}
local nameMode   = "full"
local silentMode = false

local function getEffectiveName()
    if #selectedNames == 0 then return nil end
    local names = {}
    for _, selected in ipairs(selectedNames) do
        table.insert(names, nameMode == "three" and selected:sub(1, 3) or selected)
    end
    return table.concat(names, ",")
end

local playersBar = Instance.new("ScrollingFrame", copyPage)
playersBar.Position = UDim2.new(0, 10, 0, 10); playersBar.Size = UDim2.new(1, -20, 0, 46)
playersBar.BackgroundColor3 = Color3.fromRGB(2, 10, 5); playersBar.BackgroundTransparency = 0.5
playersBar.BorderSizePixel = 0; playersBar.ScrollBarThickness = 3
playersBar.ScrollingDirection = Enum.ScrollingDirection.X
playersBar.AutomaticCanvasSize = Enum.AutomaticSize.X
playersBar.CanvasSize = UDim2.new(0, 0, 0, 0)
playersBar.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 130)
Instance.new("UICorner", playersBar).CornerRadius = UDim.new(0, 8)
local pbLayout = Instance.new("UIListLayout", playersBar)
pbLayout.FillDirection = Enum.FillDirection.Horizontal; pbLayout.Padding = UDim.new(0, 6)
pbLayout.SortOrder = Enum.SortOrder.LayoutOrder; pbLayout.VerticalAlignment = Enum.VerticalAlignment.Center
local pbPad = Instance.new("UIPadding", playersBar)
pbPad.PaddingLeft = UDim.new(0, 8); pbPad.PaddingRight = UDim.new(0, 8)

local selectedLabel = Instance.new("TextLabel", copyPage)
selectedLabel.BackgroundTransparency = 1
selectedLabel.Position = UDim2.new(0, 10, 0, 60); selectedLabel.Size = UDim2.new(1, -20, 0, 20)
selectedLabel.Font = Enum.Font.GothamSemibold; selectedLabel.TextSize = 13
selectedLabel.TextColor3 = Color3.fromRGB(180, 255, 200)
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedLabel.Text = "اختر لاعب أو أكثر من القائمة"

local targetLog = Instance.new("TextLabel", copyPage)
targetLog.BackgroundColor3 = Color3.fromRGB(8, 20, 14)
targetLog.BackgroundTransparency = 0.35
targetLog.BorderSizePixel = 0
targetLog.Position = UDim2.new(0, 10, 0, 82)
targetLog.Size = UDim2.new(1, -20, 0, 54)
targetLog.Font = Enum.Font.Code
targetLog.TextSize = 11
targetLog.TextColor3 = Color3.fromRGB(180, 255, 205)
targetLog.TextXAlignment = Enum.TextXAlignment.Left
targetLog.TextYAlignment = Enum.TextYAlignment.Top
targetLog.TextWrapped = false
targetLog.Text = "سجل المستهدفين\nلم يتم تحديد أي لاعب"
Instance.new("UICorner", targetLog).CornerRadius = UDim.new(0, 8)
local targetLogStroke = Instance.new("UIStroke", targetLog)
targetLogStroke.Color = Color3.fromRGB(0, 220, 110)
targetLogStroke.Transparency = 0.55
local targetLogPad = Instance.new("UIPadding", targetLog)
targetLogPad.PaddingLeft = UDim.new(0, 8)
targetLogPad.PaddingTop = UDim.new(0, 5)

local playerChips = {}
local targetStats = {}
local function formatDuration(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

local function getTargetStats(name)
    local currentlyOnline = Players:FindFirstChild(name) ~= nil
    targetStats[name] = targetStats[name] or {
        joins = currentlyOnline and 1 or 0, leaves = 0, online = currentlyOnline,
        onlineSince = os.clock(), connectedTime = 0
    }
    return targetStats[name]
end

local function updateTargetLog()
    if #selectedNames == 0 then
        targetLog.Text = "سجل المستهدفين\nلم يتم تحديد أي لاعب"
        return
    end
    local lines = {"سجل المستهدفين — يتحدث تلقائياً"}
    for _, name in ipairs(selectedNames) do
        local stat = getTargetStats(name)
        local current = stat.connectedTime
        if stat.online then current = current + (os.clock() - stat.onlineSince) end
        local state = stat.online and "متصل" or "غير متصل"
        table.insert(lines, string.format("%s  |  %s  |  دخول:%d خروج:%d  |  %s",
            name, state, stat.joins, stat.leaves, formatDuration(current)))
    end
    targetLog.Text = table.concat(lines, "\n")
end

task.spawn(function()
    while targetLog.Parent do
        updateTargetLog()
        task.wait(1)
    end
end)

local function isNameSelected(name)
    for _, selected in ipairs(selectedNames) do
        if selected == name then return true end
    end
    return false
end

local function toggleSelectedName(name)
    for i, selected in ipairs(selectedNames) do
        if selected == name then
            table.remove(selectedNames, i)
            return
        end
    end
    table.insert(selectedNames, name)
end

local function updateSelectedLabel()
    if #selectedNames == 0 then
        selectedLabel.Text = "اختر لاعب أو أكثر من القائمة"
    else
        selectedLabel.Text = string.format("تم اختيار %d — %s", #selectedNames, table.concat(selectedNames, ","))
    end
    updateTargetLog()
end

local function refreshPlayers()
    for _, c in ipairs(playersBar:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    playerChips = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local chip = Instance.new("TextButton", playersBar)
            chip.Size = UDim2.new(0, 0, 1, -8); chip.AutomaticSize = Enum.AutomaticSize.X
            chip.BackgroundColor3 = Color3.fromRGB(10, 35, 18); chip.BackgroundTransparency = 0.2
            chip.BorderSizePixel = 0; chip.AutoButtonColor = false
            chip.Font = Enum.Font.GothamBold; chip.Text = "  " .. p.Name .. "  "
            chip.TextSize = 13; chip.TextColor3 = Color3.fromRGB(200, 255, 215)
            Instance.new("UICorner", chip).CornerRadius = UDim.new(0, 8)
            local cs = Instance.new("UIStroke", chip); cs.Color = Color3.fromRGB(0, 200, 100); cs.Transparency = 0.5
            chip.MouseButton1Click:Connect(function()
                toggleSelectedName(p.Name)
                updateSelectedLabel()
                for playerName, ch in pairs(playerChips) do
                    local selected = isNameSelected(playerName)
                    TweenService:Create(ch, TweenInfo.new(0.12), {
                        BackgroundColor3 = selected and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(10, 35, 18)
                    }):Play()
                end
            end)
            chip.MouseEnter:Connect(function()
                if not isNameSelected(p.Name) then
                    TweenService:Create(chip, TweenInfo.new(0.12), {BackgroundTransparency = 0.05}):Play()
                end
            end)
            chip.MouseLeave:Connect(function()
                if not isNameSelected(p.Name) then
                    TweenService:Create(chip, TweenInfo.new(0.12), {BackgroundTransparency = 0.2}):Play()
                end
            end)
            playerChips[p.Name] = chip
        end
    end
end
refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerAdded:Connect(function(player)
    local stat = targetStats[player.Name]
    if stat then
        stat.joins = stat.joins + 1
        stat.online = true
        stat.onlineSince = os.clock()
    end
    updateTargetLog()
end)
Players.PlayerRemoving:Connect(function(player)
    local stat = targetStats[player.Name]
    if stat and stat.online then
        stat.connectedTime = stat.connectedTime + (os.clock() - stat.onlineSince)
        stat.leaves = stat.leaves + 1
        stat.online = false
    end
    updateSelectedLabel()
    refreshPlayers()
end)

local function makeBigBtn(parent, text, posY, color1, color2)
    color1 = color1 or Color3.fromRGB(0, 150, 75)
    color2 = color2 or Color3.fromRGB(0, 90, 45)
    local b = Instance.new("TextButton", parent)
    b.Position = UDim2.new(0, 10, 0, posY); b.Size = UDim2.new(1, -20, 0, 46)
    b.BackgroundColor3 = Color3.fromRGB(0, 110, 55); b.BackgroundTransparency = 0.15
    b.BorderSizePixel = 0; b.AutoButtonColor = false
    b.Font = Enum.Font.GothamBlack; b.Text = text; b.TextSize = 16
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", b); s.Color = Color3.fromRGB(0, 255, 130); s.Transparency = 0.3
    local g = Instance.new("UIGradient", b)
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2),
    }
    g.Rotation = 90
    b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play() end)
    return b
end

local spamScroll = Instance.new("ScrollingFrame", copyPage)
spamScroll.Position = UDim2.new(0, 0, 0, 142)
spamScroll.Size = UDim2.new(1, 0, 1, -172)
spamScroll.BackgroundTransparency = 1
spamScroll.BorderSizePixel = 0
spamScroll.ScrollBarThickness = 4
spamScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 130)
spamScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
spamScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local spamList = Instance.new("UIListLayout", spamScroll)
spamList.Padding = UDim.new(0, 6)
spamList.SortOrder = Enum.SortOrder.LayoutOrder
local spamPad = Instance.new("UIPadding", spamScroll)
spamPad.PaddingTop = UDim.new(0, 6); spamPad.PaddingBottom = UDim.new(0, 6)
spamPad.PaddingLeft = UDim.new(0, 8); spamPad.PaddingRight = UDim.new(0, 8)

local prefixRow = Instance.new("Frame", spamScroll)
prefixRow.BackgroundTransparency = 1
prefixRow.Size = UDim2.new(1, 0, 0, 36)
prefixRow.LayoutOrder = 0

local prefixBox = Instance.new("TextBox", prefixRow)
prefixBox.Size = UDim2.new(0, 48, 1, 0); prefixBox.Position = UDim2.new(0, 0, 0, 0)
prefixBox.BackgroundColor3 = Color3.fromRGB(20, 80, 180); prefixBox.BackgroundTransparency = 0.15
prefixBox.BorderSizePixel = 0; prefixBox.Text = ";"
prefixBox.PlaceholderText = ";"
prefixBox.TextColor3 = Color3.fromRGB(255, 255, 255)
prefixBox.Font = Enum.Font.GothamBold; prefixBox.TextSize = 18
prefixBox.ClearTextOnFocus = false
Instance.new("UICorner", prefixBox).CornerRadius = UDim.new(0, 8)
local pbStroke2 = Instance.new("UIStroke", prefixBox)
pbStroke2.Color = Color3.fromRGB(80, 160, 255); pbStroke2.Thickness = 1.5; pbStroke2.Transparency = 0.2

local prefixLabel = Instance.new("TextLabel", prefixRow)
prefixLabel.BackgroundTransparency = 1
prefixLabel.Position = UDim2.new(0, 56, 0, 0); prefixLabel.Size = UDim2.new(1, -56, 1, 0)
prefixLabel.Font = Enum.Font.GothamSemibold; prefixLabel.TextSize = 13
prefixLabel.TextColor3 = Color3.fromRGB(160, 210, 255)
prefixLabel.TextXAlignment = Enum.TextXAlignment.Left
prefixLabel.Text = "اكتب علامة الادمن الخاصة بك"

local nameModeRow = Instance.new("Frame", spamScroll)
nameModeRow.BackgroundTransparency = 1
nameModeRow.Size = UDim2.new(1, 0, 0, 34)
nameModeRow.LayoutOrder = 1

local fullNameBtn = Instance.new("TextButton", nameModeRow)
fullNameBtn.Size = UDim2.new(0.5, -4, 1, 0)
fullNameBtn.Position = UDim2.new(0, 0, 0, 0)
fullNameBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 80)
fullNameBtn.BackgroundTransparency = 0.1
fullNameBtn.BorderSizePixel = 0; fullNameBtn.AutoButtonColor = false
fullNameBtn.Font = Enum.Font.GothamBold; fullNameBtn.Text = "اسم كامل"
fullNameBtn.TextSize = 14; fullNameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", fullNameBtn).CornerRadius = UDim.new(0, 9)
local fnStroke = Instance.new("UIStroke", fullNameBtn)
fnStroke.Color = Color3.fromRGB(0, 255, 130); fnStroke.Thickness = 2; fnStroke.Transparency = 0.1

local threeLettersBtn = Instance.new("TextButton", nameModeRow)
threeLettersBtn.Size = UDim2.new(0.5, -4, 1, 0)
threeLettersBtn.Position = UDim2.new(0.5, 4, 0, 0)
threeLettersBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
threeLettersBtn.BackgroundTransparency = 0.15
threeLettersBtn.BorderSizePixel = 0; threeLettersBtn.AutoButtonColor = false
threeLettersBtn.Font = Enum.Font.GothamBold; threeLettersBtn.Text = "ثلاث حروف"
threeLettersBtn.TextSize = 14; threeLettersBtn.TextColor3 = Color3.fromRGB(200, 255, 215)
Instance.new("UICorner", threeLettersBtn).CornerRadius = UDim.new(0, 9)
local tlStroke = Instance.new("UIStroke", threeLettersBtn)
tlStroke.Color = Color3.fromRGB(0, 200, 100); tlStroke.Thickness = 1.5; tlStroke.Transparency = 0.4

local function updateNameModeUI()
    if nameMode == "full" then
        TweenService:Create(fullNameBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 160, 80), BackgroundTransparency = 0.05}):Play()
        fnStroke.Transparency = 0.05
        TweenService:Create(threeLettersBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 50, 30), BackgroundTransparency = 0.2}):Play()
        tlStroke.Transparency = 0.5
    else
        TweenService:Create(fullNameBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 50, 30), BackgroundTransparency = 0.2}):Play()
        fnStroke.Transparency = 0.5
        TweenService:Create(threeLettersBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 160, 80), BackgroundTransparency = 0.05}):Play()
        tlStroke.Transparency = 0.05
    end
end

fullNameBtn.MouseButton1Click:Connect(function() nameMode = "full"; updateNameModeUI() end)
threeLettersBtn.MouseButton1Click:Connect(function() nameMode = "three"; updateNameModeUI() end)

local silentRow = Instance.new("Frame", spamScroll)
silentRow.BackgroundTransparency = 1
silentRow.Size = UDim2.new(1, 0, 0, 30)
silentRow.LayoutOrder = 2

local silentBtn = Instance.new("TextButton", silentRow)
silentBtn.Size = UDim2.new(1, 0, 1, 0)
silentBtn.BackgroundColor3 = Color3.fromRGB(18, 10, 38)
silentBtn.BackgroundTransparency = 0.05
silentBtn.BorderSizePixel = 0; silentBtn.AutoButtonColor = false
silentBtn.Font = Enum.Font.GothamBold
silentBtn.Text = "تشغيل نسخ خفي"
silentBtn.TextSize = 13; silentBtn.TextColor3 = Color3.fromRGB(180, 150, 255)
Instance.new("UICorner", silentBtn).CornerRadius = UDim.new(0, 9)
local silentStroke = Instance.new("UIStroke", silentBtn)
silentStroke.Color = Color3.fromRGB(100, 60, 200); silentStroke.Thickness = 1.6; silentStroke.Transparency = 0.3

local rateRow = Instance.new("Frame", spamScroll)
rateRow.BackgroundTransparency = 1
rateRow.Size = UDim2.new(1, 0, 0, 32)
rateRow.LayoutOrder = 2.5

local rateLabel = Instance.new("TextLabel", rateRow)
rateLabel.BackgroundTransparency = 1
rateLabel.Size = UDim2.new(0.55, 0, 1, 0)
rateLabel.Font = Enum.Font.GothamSemibold
rateLabel.TextSize = 12
rateLabel.TextColor3 = Color3.fromRGB(170, 225, 190)
rateLabel.TextXAlignment = Enum.TextXAlignment.Left
rateLabel.Text = "الفاصل بين الرسائل (ثانية):"

local spamDelayBox = Instance.new("TextBox", rateRow)
spamDelayBox.Position = UDim2.new(0.58, 0, 0, 0)
spamDelayBox.Size = UDim2.new(0.42, 0, 1, 0)
spamDelayBox.BackgroundColor3 = Color3.fromRGB(12, 42, 22)
spamDelayBox.BackgroundTransparency = 0.1
spamDelayBox.BorderSizePixel = 0
spamDelayBox.ClearTextOnFocus = false
spamDelayBox.Font = Enum.Font.GothamBold
spamDelayBox.Text = "0.20"
spamDelayBox.TextSize = 13
spamDelayBox.TextColor3 = Color3.fromRGB(220, 255, 230)
spamDelayBox.TextXAlignment = Enum.TextXAlignment.Center
Instance.new("UICorner", spamDelayBox).CornerRadius = UDim.new(0, 8)
local rateStroke = Instance.new("UIStroke", spamDelayBox)
rateStroke.Color = Color3.fromRGB(0, 200, 100)
rateStroke.Transparency = 0.45

local statusLbl = Instance.new("TextLabel", copyPage)
statusLbl.BackgroundTransparency = 1
statusLbl.Position = UDim2.new(0, 10, 1, -28); statusLbl.Size = UDim2.new(1, -20, 0, 22)
statusLbl.Font = Enum.Font.GothamSemibold; statusLbl.TextSize = 13
statusLbl.TextColor3 = Color3.fromRGB(150, 220, 170); statusLbl.Text = ""

local function setStatus(txt, persistent)
    statusLbl.Text = txt; statusLbl.TextTransparency = 0
    if not persistent then
        task.delay(2.5, function()
            if statusLbl.Text == txt then
                TweenService:Create(statusLbl, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
            end
        end)
    end
end

local function updateSilentBtn()
    if silentMode then
        TweenService:Create(silentBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 30, 180), BackgroundTransparency = 0.0, TextColor3 = Color3.fromRGB(255, 235, 80)}):Play()
        silentStroke.Color = Color3.fromRGB(180, 120, 255); silentStroke.Thickness = 2.0; silentStroke.Transparency = 0.0
        silentBtn.Text = "ارجاع للنسخ الظاهر"
    else
        TweenService:Create(silentBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 10, 38), BackgroundTransparency = 0.05, TextColor3 = Color3.fromRGB(180, 150, 255)}):Play()
        silentStroke.Color = Color3.fromRGB(100, 60, 200); silentStroke.Thickness = 1.6; silentStroke.Transparency = 0.3
        silentBtn.Text = "تشغيل نسخ خفي"
    end
end

task.spawn(function()
    while silentBtn.Parent do
        if silentMode then
            TweenService:Create(silentStroke, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.55}):Play(); task.wait(0.65)
            TweenService:Create(silentStroke, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.0}):Play(); task.wait(0.65)
        else task.wait(0.2) end
    end
end)

silentBtn.MouseButton1Click:Connect(function()
    silentMode = not silentMode
    updateSilentBtn()
    if silentMode then
        setStatus("النسخ الخفي شغال — ادمن فقط", true)
        statusLbl.TextColor3 = Color3.fromRGB(200, 160, 255)
    else
        statusLbl.TextColor3 = Color3.fromRGB(150, 220, 170)
        setStatus("رجع للنسخ الظاهر — شات + ادمن")
    end
end)

local function makeSpamRow(order)
    local row = Instance.new("Frame", spamScroll)
    row.Size = UDim2.new(1, 0, 0, 42)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order
    return row
end

local function makeRowLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Position = UDim2.new(0, 0, 0, 0); lbl.Size = UDim2.new(0.34, -4, 1, 0)
    lbl.BackgroundColor3 = Color3.fromRGB(8, 25, 14); lbl.BackgroundTransparency = 0.3
    lbl.BorderSizePixel = 0; lbl.Font = Enum.Font.GothamBold
    lbl.Text = text; lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(200, 255, 215); lbl.TextXAlignment = Enum.TextXAlignment.Center
    Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 10)
    return lbl
end

local function makeStartBtn(parent)
    local b = Instance.new("TextButton", parent)
    b.Position = UDim2.new(0.35, 2, 0, 0); b.Size = UDim2.new(0.33, -2, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(180, 25, 25); b.BackgroundTransparency = 0.05
    b.BorderSizePixel = 0; b.AutoButtonColor = false
    b.Font = Enum.Font.GothamBold; b.Text = "تشغيل"; b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(255, 80, 80); s.Transparency = 0.2; s.Thickness = 1.8
    return b
end

local function makeStopBtn(parent)
    local b = Instance.new("TextButton", parent)
    b.Position = UDim2.new(0.69, 3, 0, 0); b.Size = UDim2.new(0.31, -3, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(55, 55, 65); b.BackgroundTransparency = 0.05
    b.BorderSizePixel = 0; b.AutoButtonColor = false
    b.Font = Enum.Font.GothamBold; b.Text = "ايقاف"; b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(210, 210, 225)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(55, 55, 65)}):Play() end)
    return b
end

local function setStartOn(btn)
    TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(0, 190, 75)}):Play()
    local s = btn:FindFirstChildOfClass("UIStroke")
    if s then s.Color = Color3.fromRGB(0, 255, 130) end
    btn.Text = "شغال"
end
local function setStartOff(btn)
    TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(180, 25, 25)}):Play()
    local s = btn:FindFirstChildOfClass("UIStroke")
    if s then s.Color = Color3.fromRGB(255, 80, 80) end
    btn.Text = "تشغيل"
end

local rowA = makeSpamRow(3)
makeRowLabel(rowA, "سبام")
local copySpamBtn = makeStartBtn(rowA)
local stopBtnA    = makeStopBtn(rowA)

local rowGhost = makeSpamRow(4)
makeRowLabel(rowGhost, "نسخ غامض")
local copyGhostBtn = makeStartBtn(rowGhost)
local stopBtnGhost = makeStopBtn(rowGhost)

local rowB = makeSpamRow(5)
makeRowLabel(rowB, "Logs")
local copyLogsBtn = makeStartBtn(rowB)
local stopBtnB    = makeStopBtn(rowB)

local rowC = makeSpamRow(6)
makeRowLabel(rowC, "Re")
local copyReBtn = makeStartBtn(rowC)
local stopBtnC  = makeStopBtn(rowC)

local rowD = makeSpamRow(7)
makeRowLabel(rowD, "سبام قوي")
local copyPowerBtn = makeStartBtn(rowD)
local stopBtnD     = makeStopBtn(rowD)

----------------------------------------------------------------
-- Remotes
----------------------------------------------------------------
local chatRemote, hdRemote, changeSettingRemote
pcall(function()
    local re = ReplicatedStorage:FindFirstChild("RemoteEvents")
    if re then chatRemote = re:FindFirstChild("ChatEvent") end
end)
pcall(function()
    local hd = ReplicatedStorage:FindFirstChild("HDAdminHDClient")
    if hd then
        local sig = hd:FindFirstChild("Signals")
        if sig then
            hdRemote            = sig:FindFirstChild("RequestCommandModification")
            changeSettingRemote = sig:FindFirstChild("ChangeSetting")
        end
    end
end)

local function applyPrefix(newPrefix)
    if newPrefix == "" then newPrefix = ";" end
    pcall(function()
        if changeSettingRemote then
            local args = {[1] = {[1] = "Prefix", [2] = newPrefix}}
            changeSettingRemote:InvokeServer(unpack(args))
        end
    end)
    setStatus("علامة الادمن: " .. newPrefix)
end

prefixBox.FocusLost:Connect(function()
    local val = prefixBox.Text
    if val == "" then val = ";"; prefixBox.Text = ";" end
    applyPrefix(val)
end)

local function sendOnce(message)
    if not silentMode then
        pcall(function()
            game:GetService("ReplicatedStorage").RemoteEvents.DataService:FireServer(message)
        end)
    end
    if hdRemote then
        task.spawn(function()
            pcall(function() hdRemote:InvokeServer(message) end)
        end)
    end
end

----------------------------------------------------------------
-- Spam builders
----------------------------------------------------------------
local function buildLogsCmd(name, prefix)
    prefix = prefix or ";"
    local parts = {}
    for i = 1, 26 do parts[i] = prefix.."logs "..name end
    return table.concat(parts, " ")
end

local function buildReCmd(name, prefix)
    prefix = prefix or ";"
    local parts = {}
    for i = 1, 26 do parts[i] = prefix.."re "..name end
    return table.concat(parts, " ")
end

local function buildSpamA(name, prefix)
    prefix = prefix or ";"
    local block = prefix.."re "..name.." "..prefix.."res "..name.." "..prefix.."logs "..name.." "..prefix.."clogs "..name.." "..prefix.."nv "..name.." "..prefix.."cmdbar "..name.." "..prefix.."jc "..name.." "..prefix.."ice "..name
    local parts = {}
    for i = 1, 8 do parts[i] = block end
    return table.concat(parts, " ")
end

local function buildGhostSpam(name, prefix)
    prefix = prefix or ";"
    local block = prefix.."explode "..name.." "..prefix.."warp "..name.." "..prefix.."logs "..name.." "..prefix.."clogs "..name.." "..prefix.."res "..name.." "..prefix.."ice "..name.." "..prefix.."jc "..name.." "..prefix.."dog "..name.." "..prefix.."char "..name.." miri "..prefix.."fling "..name.." "..prefix.."nv "..name.." "..prefix.."re "..name
    local parts = {}
    for i = 1, 5 do parts[i] = block end
    return table.concat(parts, " ")
end

local function buildPowerSpam(name, prefix)
    prefix = prefix or ";"
    local cmds = {
        "apparate "..name.." inf", "fling "..name, "jp "..name.." inf",
        "jc "..name, "ice "..name, "emotes "..name, "phase "..name,
        "cmdbar "..name, "nv "..name, "jump "..name, "re "..name,
        "res "..name, "kill "..name, "ping "..name,
    }
    local out = {}
    for i, c in ipairs(cmds) do out[i] = prefix..c end
    return table.concat(out, " ")
end

----------------------------------------------------------------
-- Spam control
----------------------------------------------------------------
local spamRunning = false
local spamThread
local spamARunning = false; local ghostSpamRunning = false
local logsSpamRunning = false; local reSpamRunning = false
local powerSpamRunning = false

local function stopSpam()
    spamRunning = false; spamThread = nil
    spamARunning = false; ghostSpamRunning = false
    logsSpamRunning = false; reSpamRunning = false; powerSpamRunning = false
    setStartOff(copySpamBtn); setStartOff(copyGhostBtn)
    setStartOff(copyLogsBtn); setStartOff(copyReBtn); setStartOff(copyPowerBtn)
    setStatus("تم ايقاف السبام")
end

local function startSpam(message)
    if spamRunning then stopSpam(); task.wait(0.05) end
    local delayValue = tonumber(spamDelayBox.Text) or 0.2
    delayValue = math.clamp(delayValue, 0.08, 2)
    spamDelayBox.Text = string.format("%.2f", delayValue)
    spamRunning = true
    setStatus("السبام شغال — الفاصل: " .. string.format("%.2f", delayValue) .. " ثانية", true)
    spamThread = task.spawn(function()
        while spamRunning do
            sendOnce(message)
            task.wait(delayValue)
        end
    end)
end

local function doStop(startBtn)
    stopSpam()
    if startBtn then setStartOff(startBtn) end
    return false
end

copySpamBtn.MouseButton1Click:Connect(function()
    if spamARunning then return end
    if #selectedNames == 0 then setStatus("اختر لاعب أو أكثر أولا") return end
    local prefix = (prefixBox.Text ~= "" and prefixBox.Text) or ";"
    startSpam(buildSpamA(getEffectiveName(), prefix))
    spamARunning = true; setStartOn(copySpamBtn)
end)
stopBtnA.MouseButton1Click:Connect(function()
    if spamARunning then spamARunning = doStop(copySpamBtn) end
end)

copyGhostBtn.MouseButton1Click:Connect(function()
    if ghostSpamRunning then return end
    if #selectedNames == 0 then setStatus("اختر لاعب أو أكثر أولا") return end
    local prefix = (prefixBox.Text ~= "" and prefixBox.Text) or ";"
    startSpam(buildGhostSpam(getEffectiveName(), prefix))
    ghostSpamRunning = true; setStartOn(copyGhostBtn)
end)
stopBtnGhost.MouseButton1Click:Connect(function()
    if ghostSpamRunning then ghostSpamRunning = doStop(copyGhostBtn) end
end)

copyLogsBtn.MouseButton1Click:Connect(function()
    if logsSpamRunning then return end
    if #selectedNames == 0 then setStatus("اختر لاعب أو أكثر أولا") return end
    local prefix = (prefixBox.Text ~= "" and prefixBox.Text) or ";"
    startSpam(buildLogsCmd(getEffectiveName(), prefix))
    logsSpamRunning = true; setStartOn(copyLogsBtn)
end)
stopBtnB.MouseButton1Click:Connect(function()
    if logsSpamRunning then logsSpamRunning = doStop(copyLogsBtn) end
end)

copyReBtn.MouseButton1Click:Connect(function()
    if reSpamRunning then return end
    if #selectedNames == 0 then setStatus("اختر لاعب أو أكثر أولا") return end
    local prefix = (prefixBox.Text ~= "" and prefixBox.Text) or ";"
    startSpam(buildReCmd(getEffectiveName(), prefix))
    reSpamRunning = true; setStartOn(copyReBtn)
end)
stopBtnC.MouseButton1Click:Connect(function()
    if reSpamRunning then reSpamRunning = doStop(copyReBtn) end
end)

copyPowerBtn.MouseButton1Click:Connect(function()
    if powerSpamRunning then return end
    if #selectedNames == 0 then setStatus("اختر لاعب أو أكثر أولا") return end
    local prefix = (prefixBox.Text ~= "" and prefixBox.Text) or ";"
    startSpam(buildPowerSpam(getEffectiveName(), prefix))
    powerSpamRunning = true; setStartOn(copyPowerBtn)
end)
stopBtnD.MouseButton1Click:Connect(function()
    if powerSpamRunning then powerSpamRunning = doStop(copyPowerBtn) end
end)

----------------------------------------------------------------
-- Page: تحكم
----------------------------------------------------------------
local ctrlInfo = Instance.new("TextLabel", controlPage)
ctrlInfo.BackgroundTransparency = 1
ctrlInfo.Position = UDim2.new(0, 10, 0, 10); ctrlInfo.Size = UDim2.new(1, -20, 0, 24)
ctrlInfo.Font = Enum.Font.GothamBold; ctrlInfo.Text = "لوحة التحكم — PeakRayan"
ctrlInfo.TextSize = 16; ctrlInfo.TextColor3 = Color3.fromRGB(0, 255, 130)
ctrlInfo.TextXAlignment = Enum.TextXAlignment.Left

local ctrlScroll = Instance.new("ScrollingFrame", controlPage)
ctrlScroll.Position = UDim2.new(0, 0, 0, 40)
ctrlScroll.Size = UDim2.new(1, 0, 1, -70)
ctrlScroll.BackgroundTransparency = 1; ctrlScroll.BorderSizePixel = 0
ctrlScroll.ScrollBarThickness = 4
ctrlScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 100)
ctrlScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ctrlScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local spamBtn      = makeBigBtn(ctrlScroll, "سبام", 4, Color3.fromRGB(255, 80, 80), Color3.fromRGB(170, 30, 30))
local skinsBtn     = makeBigBtn(ctrlScroll, "سكنات", 58, Color3.fromRGB(255, 90, 200), Color3.fromRGB(170, 30, 130))
local dancesBtn    = makeBigBtn(ctrlScroll, "رقصات", 112, Color3.fromRGB(230, 140, 30), Color3.fromRGB(160, 90, 10))
local loadBtn      = makeBigBtn(ctrlScroll, "تحكم الراديو", 166, Color3.fromRGB(0, 200, 110), Color3.fromRGB(0, 130, 70))
local hideBtn      = makeBigBtn(ctrlScroll, "اخفاء رسائل السبام", 220, Color3.fromRGB(30, 200, 200), Color3.fromRGB(15, 130, 130))
local spinStartBtn = makeBigBtn(ctrlScroll, "تشغيل الدوران", 274, Color3.fromRGB(140, 220, 40), Color3.fromRGB(80, 150, 20))
local spinStopBtn  = makeBigBtn(ctrlScroll, "ايقاف الدوران", 328, Color3.fromRGB(170, 30, 30), Color3.fromRGB(110, 15, 15))
local logsBtn      = makeBigBtn(ctrlScroll, "حماية من logs / clogs", 382, Color3.fromRGB(0, 130, 220), Color3.fromRGB(0, 70, 140))
local titleBtn     = makeBigBtn(ctrlScroll, "تقليد الشات", 436, Color3.fromRGB(170, 70, 220), Color3.fromRGB(100, 30, 150))
local allBtn       = makeBigBtn(ctrlScroll, "نسخ all", 490, Color3.fromRGB(30, 180, 255), Color3.fromRGB(10, 100, 180))
local blueBtn      = makeBigBtn(ctrlScroll, "نسخه معدلة من سكربت بلو", 544, Color3.fromRGB(0, 120, 255), Color3.fromRGB(0, 60, 160))
local afkBtn       = makeBigBtn(ctrlScroll, "تحكم في شات ال afk", 598, Color3.fromRGB(255, 160, 0), Color3.fromRGB(180, 90, 0))

local ctrlStatus = Instance.new("TextLabel", controlPage)
ctrlStatus.BackgroundTransparency = 1
ctrlStatus.Position = UDim2.new(0, 10, 1, -28); ctrlStatus.Size = UDim2.new(1, -20, 0, 22)
ctrlStatus.Font = Enum.Font.GothamSemibold; ctrlStatus.TextSize = 13
ctrlStatus.TextColor3 = Color3.fromRGB(150, 220, 170); ctrlStatus.Text = ""
ctrlStatus.TextXAlignment = Enum.TextXAlignment.Left

local function showBigNotice(text)
    local nGui = Instance.new("ScreenGui")
    nGui.Name = "PeakRayan_Notice"; nGui.ResetOnSpawn = false; nGui.IgnoreGuiInset = true
    nGui.DisplayOrder = 9998
    pcall(function() nGui.Parent = guiParent end)
    if not nGui.Parent then nGui.Parent = PlayerGui end

    local nFrame = Instance.new("Frame", nGui)
    nFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    nFrame.Position = UDim2.new(0.5, 0, 0.5, 0); nFrame.Size = UDim2.new(0, 520, 0, 220)
    nFrame.BackgroundColor3 = Color3.fromRGB(8, 18, 10); nFrame.BackgroundTransparency = 0.1
    nFrame.BorderSizePixel = 0
    Instance.new("UICorner", nFrame).CornerRadius = UDim.new(0, 16)
    local nStroke = Instance.new("UIStroke", nFrame)
    nStroke.Color = Color3.fromRGB(0, 255, 130); nStroke.Thickness = 2; nStroke.Transparency = 0.1

    local ntitle = Instance.new("TextLabel", nFrame)
    ntitle.BackgroundTransparency = 1
    ntitle.Position = UDim2.new(0, 12, 0, 14); ntitle.Size = UDim2.new(1, -24, 0, 32)
    ntitle.Font = Enum.Font.GothamBlack; ntitle.Text = "ملاحظة مهمة"
    ntitle.TextSize = 22; ntitle.TextColor3 = Color3.fromRGB(0, 255, 130)

    local body = Instance.new("TextLabel", nFrame)
    body.BackgroundTransparency = 1
    body.Position = UDim2.new(0, 16, 0, 56); body.Size = UDim2.new(1, -32, 1, -116)
    body.Font = Enum.Font.GothamSemibold; body.Text = text
    body.TextSize = 20; body.TextColor3 = Color3.fromRGB(230, 255, 235)
    body.TextWrapped = true; body.TextYAlignment = Enum.TextYAlignment.Top

    local okBtn = Instance.new("TextButton", nFrame)
    okBtn.AnchorPoint = Vector2.new(0.5, 1)
    okBtn.Position = UDim2.new(0.5, 0, 1, -14); okBtn.Size = UDim2.new(0, 160, 0, 38)
    okBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100); okBtn.BorderSizePixel = 0
    okBtn.Font = Enum.Font.GothamBold; okBtn.Text = "تمام"
    okBtn.TextSize = 18; okBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    Instance.new("UICorner", okBtn).CornerRadius = UDim.new(0, 10)
    okBtn.MouseButton1Click:Connect(function() pcall(function() nGui:Destroy() end) end)
    task.delay(12, function() pcall(function() nGui:Destroy() end) end)
end

local dancesLoaded = false
dancesBtn.MouseButton1Click:Connect(function()
    if dancesLoaded then ctrlStatus.Text = "الرقصات مفعلة بالفعل" return end
    ctrlStatus.Text = "جاري تشغيل الرقصات..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
        end)
        if ok then dancesLoaded = true; ctrlStatus.Text = "تم تشغيل الرقصات"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

local controlLoaded = false
loadBtn.MouseButton1Click:Connect(function()
    showBigNotice("البس الراديو يلا يشتغل السكربت")
    if controlLoaded then ctrlStatus.Text = "تحكم الراديو مفعل" return end
    ctrlStatus.Text = "جاري تشغيل الراديو..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/Raduooo/refs/heads/main/README.md"))()
        end)
        if ok then controlLoaded = true; ctrlStatus.Text = "تم تشغيل تحكم الراديو"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

local antiActive = false
hideBtn.MouseButton1Click:Connect(function()
    if antiActive then ctrlStatus.Text = "حماية الواجهة مفعلة بالفعل" return end
    antiActive = true
    local function hideSystemNotifications(obj)
        if obj:IsA("TextLabel") or obj:IsA("TextBox") then
            local ok, txt = pcall(function() return obj.Text end)
            if ok and txt and (txt:find("Sending commands") or txt:find("CommandLimit")) then
                local frame = obj.Parent
                if frame then pcall(function() frame.Visible = false; frame:Destroy() end) end
            end
        end
    end
    PlayerGui.DescendantAdded:Connect(function(d)
        task.wait(0.01); hideSystemNotifications(d)
    end)
    task.spawn(function()
        for _, v in ipairs(PlayerGui:GetDescendants()) do hideSystemNotifications(v) end
    end)
    ctrlStatus.Text = "تم تفعيل اخفاء رسائل السبام"
end)

local spinning = false
local spinSpeed = 50
local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
    if spinning then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
        end
    end
end)
spinStartBtn.MouseButton1Click:Connect(function() spinning = true; ctrlStatus.Text = "تم تشغيل الدوران" end)
spinStopBtn.MouseButton1Click:Connect(function() spinning = false; ctrlStatus.Text = "تم ايقاف الدوران" end)

local logsActive = false
logsBtn.MouseButton1Click:Connect(function()
    if logsActive then ctrlStatus.Text = "حماية logs مفعلة بالفعل" return end
    logsActive = true
    local function scanAndDestroy(obj)
        if obj:IsA("ScreenGui") or obj:IsA("Frame") then
            local nm = obj.Name:lower()
            if nm:find("log") or nm:find("admin") or nm:find("command") then
                pcall(function() obj:Destroy() end)
            end
        end
    end
    for _, g in ipairs(PlayerGui:GetDescendants()) do scanAndDestroy(g) end
    PlayerGui.DescendantAdded:Connect(function(d) scanAndDestroy(d) end)
    task.spawn(function()
        while logsActive and task.wait(0.1) do
            for _, g in ipairs(PlayerGui:GetChildren()) do
                if g:IsA("ScreenGui") and (g.Name:find("Log") or g.Name:find("Admin")) then
                    pcall(function() g.Enabled = false; g:Destroy() end)
                end
            end
        end
    end)
    ctrlStatus.Text = "تم تفعيل حماية logs / clogs"
end)

titleBtn.MouseButton1Click:Connect(function()
    ctrlStatus.Text = "جاري تشغيل مراقبة الشات..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/NAH/refs/heads/main/README.md"))()
        end)
        if ok then ctrlStatus.Text = "تم تشغيل مراقبة الشات"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

spamBtn.MouseButton1Click:Connect(function()
    ctrlStatus.Text = "جاري تشغيل السبام..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/SH_spam_neo/refs/heads/main/README.md"))()
        end)
        if ok then ctrlStatus.Text = "تم تشغيل السبام"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

skinsBtn.MouseButton1Click:Connect(function()
    ctrlStatus.Text = "جاري تشغيل السكنات..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/Skinn-neooo/refs/heads/main/README.md"))()
        end)
        if ok then ctrlStatus.Text = "تم تشغيل السكنات"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

allBtn.MouseButton1Click:Connect(function()
    ctrlStatus.Text = "جاري تشغيل نسخ all..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/All/refs/heads/main/README.md"))()
        end)
        if ok then ctrlStatus.Text = "تم تشغيل نسخ all"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

local blueLoaded = false
blueBtn.MouseButton1Click:Connect(function()
    if blueLoaded then ctrlStatus.Text = "نسخه معدلة مفعلة بالفعل" return end
    ctrlStatus.Text = "جاري تشغيل..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/Blsh/refs/heads/main/README.md"))()
        end)
        if ok then blueLoaded = true; ctrlStatus.Text = "تم التشغيل"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

local afkLoaded = false
afkBtn.MouseButton1Click:Connect(function()
    if afkLoaded then ctrlStatus.Text = "AFK مفعل بالفعل" return end
    ctrlStatus.Text = "جاري تشغيل AFK..."
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Shhd-code/Afk/refs/heads/main/README.md"))()
        end)
        if ok then afkLoaded = true; ctrlStatus.Text = "تم تشغيل AFK"
        else ctrlStatus.Text = "فشل: " .. tostring(err):sub(1, 60) end
    end)
end)

----------------------------------------------------------------
-- Page: سبام اكسترا
----------------------------------------------------------------
do
    local ex_GREEN_A = Color3.fromRGB(0, 255, 120)
    local ex_DARK2   = Color3.fromRGB(10, 32, 16)
    local ex_WHITE   = Color3.fromRGB(255, 255, 255)
    local ex_YELLOW  = Color3.fromRGB(255, 230, 60)
    local ex_LBLUE   = Color3.fromRGB(120, 210, 255)

    local ex_playersBar = Instance.new("ScrollingFrame", extraPage)
    ex_playersBar.Position = UDim2.new(0, 0, 0, 0)
    ex_playersBar.Size     = UDim2.new(1, 0, 0, 42)
    ex_playersBar.BackgroundColor3 = ex_DARK2; ex_playersBar.BackgroundTransparency = 0.4
    ex_playersBar.BorderSizePixel = 0; ex_playersBar.ScrollBarThickness = 3
    ex_playersBar.ScrollingDirection = Enum.ScrollingDirection.X
    ex_playersBar.AutomaticCanvasSize = Enum.AutomaticSize.X
    ex_playersBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    ex_playersBar.ScrollBarImageColor3 = ex_GREEN_A
    Instance.new("UICorner", ex_playersBar).CornerRadius = UDim.new(0, 8)
    local ex_pbLayout = Instance.new("UIListLayout", ex_playersBar)
    ex_pbLayout.FillDirection = Enum.FillDirection.Horizontal
    ex_pbLayout.Padding = UDim.new(0, 6); ex_pbLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ex_pbLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    local ex_pbPad = Instance.new("UIPadding", ex_playersBar)
    ex_pbPad.PaddingLeft = UDim.new(0, 8); ex_pbPad.PaddingRight = UDim.new(0, 8)

    local ex_selectedLabel = Instance.new("TextLabel", extraPage)
    ex_selectedLabel.BackgroundTransparency = 1
    ex_selectedLabel.Position = UDim2.new(0, 4, 0, 46); ex_selectedLabel.Size = UDim2.new(1, -8, 0, 18)
    ex_selectedLabel.Font = Enum.Font.GothamSemibold; ex_selectedLabel.TextSize = 13
    ex_selectedLabel.TextColor3 = ex_YELLOW; ex_selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    ex_selectedLabel.Text = "اختر لاعب من القائمة"

    local ex_settingsRow = Instance.new("Frame", extraPage)
    ex_settingsRow.Position = UDim2.new(0, 0, 0, 68)
    ex_settingsRow.Size     = UDim2.new(1, 0, 0, 30)
    ex_settingsRow.BackgroundTransparency = 1; ex_settingsRow.BorderSizePixel = 0

    local ex_prefixLbl = Instance.new("TextLabel", ex_settingsRow)
    ex_prefixLbl.Position = UDim2.new(0, 0, 0, 0); ex_prefixLbl.Size = UDim2.new(0, 70, 1, 0)
    ex_prefixLbl.BackgroundTransparency = 1; ex_prefixLbl.Font = Enum.Font.GothamBold; ex_prefixLbl.TextSize = 14
    ex_prefixLbl.TextColor3 = ex_WHITE; ex_prefixLbl.Text = "علامة:"; ex_prefixLbl.TextXAlignment = Enum.TextXAlignment.Left

    local ex_prefixBox = Instance.new("TextBox", ex_settingsRow)
    ex_prefixBox.Position = UDim2.new(0, 68, 0, 0); ex_prefixBox.Size = UDim2.new(0, 44, 1, 0)
    ex_prefixBox.BackgroundColor3 = ex_DARK2; ex_prefixBox.BackgroundTransparency = 0.1
    ex_prefixBox.BorderSizePixel = 0; ex_prefixBox.Font = Enum.Font.GothamBold
    ex_prefixBox.Text = ";"; ex_prefixBox.TextSize = 16
    ex_prefixBox.TextColor3 = ex_YELLOW; ex_prefixBox.ClearTextOnFocus = false
    Instance.new("UICorner", ex_prefixBox).CornerRadius = UDim.new(0, 8)
    local ex_pfStroke = Instance.new("UIStroke", ex_prefixBox)
    ex_pfStroke.Color = Color3.fromRGB(0,0,0); ex_pfStroke.Transparency = 0.0; ex_pfStroke.Thickness = 1.5

    local function ex_makeToggle(parent, text, xOffset)
        local b = Instance.new("TextButton", parent)
        b.Position = UDim2.new(0, xOffset, 0, 0); b.Size = UDim2.new(0, 100, 1, 0)
        b.BackgroundColor3 = Color3.fromRGB(25, 55, 30); b.BackgroundTransparency = 0.1
        b.BorderSizePixel = 0; b.AutoButtonColor = false
        b.Font = Enum.Font.GothamBold; b.Text = text; b.TextSize = 14; b.TextColor3 = ex_WHITE
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        local s = Instance.new("UIStroke", b)
        s.Color = Color3.fromRGB(0,0,0); s.Transparency = 0.0; s.Thickness = 1.5
        return b, s
    end

    local ex_fullNameBtn, ex_fnStroke = ex_makeToggle(ex_settingsRow, "اسم كامل", 122)
    local ex_threeBtn,   ex_tlStroke  = ex_makeToggle(ex_settingsRow, "3 حروف",   226)

    local ex_cmdLbl = Instance.new("TextLabel", extraPage)
    ex_cmdLbl.Position = UDim2.new(0, 4, 0, 104); ex_cmdLbl.Size = UDim2.new(1, -8, 0, 16)
    ex_cmdLbl.BackgroundTransparency = 1; ex_cmdLbl.Font = Enum.Font.GothamBold; ex_cmdLbl.TextSize = 14
    ex_cmdLbl.TextColor3 = ex_LBLUE; ex_cmdLbl.TextXAlignment = Enum.TextXAlignment.Left
    ex_cmdLbl.Text = "اكتب الامر او الكلام (يتكرر 35 مرة):"

    local ex_cmdBox = Instance.new("TextBox", extraPage)
    ex_cmdBox.Position = UDim2.new(0, 0, 0, 122); ex_cmdBox.Size = UDim2.new(1, 0, 0, 56)
    ex_cmdBox.BackgroundColor3 = Color3.fromRGB(12, 38, 20); ex_cmdBox.BackgroundTransparency = 0.05
    ex_cmdBox.BorderSizePixel = 0; ex_cmdBox.Font = Enum.Font.GothamBold
    ex_cmdBox.Text = ""; ex_cmdBox.TextSize = 15; ex_cmdBox.TextColor3 = ex_WHITE
    ex_cmdBox.PlaceholderText = ";re   او   ;re ;logs   او  كلام عربي"
    ex_cmdBox.PlaceholderColor3 = Color3.fromRGB(130, 190, 150)
    ex_cmdBox.ClearTextOnFocus = false; ex_cmdBox.MultiLine = false
    ex_cmdBox.TextXAlignment = Enum.TextXAlignment.Left
    local ex_cmdPad = Instance.new("UIPadding", ex_cmdBox)
    ex_cmdPad.PaddingLeft = UDim.new(0, 12); ex_cmdPad.PaddingRight = UDim.new(0, 12)
    Instance.new("UICorner", ex_cmdBox).CornerRadius = UDim.new(0, 10)
    local ex_cmdStroke = Instance.new("UIStroke", ex_cmdBox)
    ex_cmdStroke.Color = Color3.fromRGB(0,0,0); ex_cmdStroke.Transparency = 0.0; ex_cmdStroke.Thickness = 2

    local ex_btnsRow = Instance.new("Frame", extraPage)
    ex_btnsRow.Position = UDim2.new(0, 0, 0, 184); ex_btnsRow.Size = UDim2.new(1, 0, 0, 40)
    ex_btnsRow.BackgroundTransparency = 1; ex_btnsRow.BorderSizePixel = 0

    local ex_startBtn = Instance.new("TextButton", ex_btnsRow)
    ex_startBtn.Position = UDim2.new(0, 0, 0, 0); ex_startBtn.Size = UDim2.new(0.62, -4, 1, 0)
    ex_startBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 80); ex_startBtn.BackgroundTransparency = 0.0
    ex_startBtn.BorderSizePixel = 0; ex_startBtn.AutoButtonColor = false
    ex_startBtn.Font = Enum.Font.GothamBold; ex_startBtn.Text = "تشغيل السبام"; ex_startBtn.TextSize = 16
    ex_startBtn.TextColor3 = ex_WHITE
    Instance.new("UICorner", ex_startBtn).CornerRadius = UDim.new(0, 10)
    local ex_startStroke = Instance.new("UIStroke", ex_startBtn)
    ex_startStroke.Color = Color3.fromRGB(0,0,0); ex_startStroke.Transparency = 0.0; ex_startStroke.Thickness = 2

    local ex_stopBtn = Instance.new("TextButton", ex_btnsRow)
    ex_stopBtn.Position = UDim2.new(0.62, 4, 0, 0); ex_stopBtn.Size = UDim2.new(0.38, -4, 1, 0)
    ex_stopBtn.BackgroundColor3 = Color3.fromRGB(170, 30, 30); ex_stopBtn.BackgroundTransparency = 0.0
    ex_stopBtn.BorderSizePixel = 0; ex_stopBtn.AutoButtonColor = false
    ex_stopBtn.Font = Enum.Font.GothamBold; ex_stopBtn.Text = "ايقاف"; ex_stopBtn.TextSize = 16
    ex_stopBtn.TextColor3 = ex_WHITE
    Instance.new("UICorner", ex_stopBtn).CornerRadius = UDim.new(0, 10)
    local ex_stopStroke = Instance.new("UIStroke", ex_stopBtn)
    ex_stopStroke.Color = Color3.fromRGB(0,0,0); ex_stopStroke.Transparency = 0.0; ex_stopStroke.Thickness = 2

    local ex_spamRunning = false
    local ex_spamThread

    ex_startBtn.MouseEnter:Connect(function()
        if not ex_spamRunning then TweenService:Create(ex_startBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(0, 220, 100)}):Play() end
    end)
    ex_startBtn.MouseLeave:Connect(function()
        if not ex_spamRunning then TweenService:Create(ex_startBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(0, 175, 80)}):Play() end
    end)
    ex_stopBtn.MouseEnter:Connect(function() TweenService:Create(ex_stopBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play() end)
    ex_stopBtn.MouseLeave:Connect(function() TweenService:Create(ex_stopBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(170, 30, 30)}):Play() end)

    local ex_statusLbl = Instance.new("TextLabel", extraPage)
    ex_statusLbl.BackgroundTransparency = 1
    ex_statusLbl.Position = UDim2.new(0, 0, 1, -24); ex_statusLbl.Size = UDim2.new(1, 0, 0, 22)
    ex_statusLbl.Font = Enum.Font.GothamBold; ex_statusLbl.TextSize = 14
    ex_statusLbl.TextColor3 = ex_YELLOW; ex_statusLbl.TextTransparency = 1; ex_statusLbl.Text = ""

    local function ex_setStatus(txt, persistent)
        ex_statusLbl.Text = txt; ex_statusLbl.TextTransparency = 0
        if not persistent then
            task.delay(2.5, function()
                if ex_statusLbl.Text == txt then
                    TweenService:Create(ex_statusLbl, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
                end
            end)
        end
    end

    local ex_selectedNames = {}
    local ex_nameMode = "full"
    local ex_playerChips = {}

    local function ex_getEffectiveName()
        if #ex_selectedNames == 0 then return nil end
        local names = {}
        for _, selected in ipairs(ex_selectedNames) do
            table.insert(names, ex_nameMode == "three" and selected:sub(1, 3) or selected)
        end
        return table.concat(names, ",")
    end

    local function ex_isNameSelected(name)
        for _, selected in ipairs(ex_selectedNames) do
            if selected == name then return true end
        end
        return false
    end

    local function ex_toggleSelectedName(name)
        for i, selected in ipairs(ex_selectedNames) do
            if selected == name then
                table.remove(ex_selectedNames, i)
                return
            end
        end
        table.insert(ex_selectedNames, name)
    end

    local function ex_refreshPlayers()
        for _, c in ipairs(ex_playersBar:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        ex_playerChips = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local chip = Instance.new("TextButton", ex_playersBar)
                chip.Size = UDim2.new(0, 0, 1, -8); chip.AutomaticSize = Enum.AutomaticSize.X
                chip.BackgroundColor3 = ex_DARK2; chip.BackgroundTransparency = 0.2
                chip.BorderSizePixel = 0; chip.AutoButtonColor = false
                chip.Font = Enum.Font.GothamBold; chip.Text = "  " .. p.Name .. "  "
                chip.TextSize = 14; chip.TextColor3 = ex_WHITE
                Instance.new("UICorner", chip).CornerRadius = UDim.new(0, 8)
                local cs = Instance.new("UIStroke", chip)
                cs.Color = Color3.fromRGB(0,0,0); cs.Transparency = 0.0
                chip.MouseButton1Click:Connect(function()
                    ex_toggleSelectedName(p.Name)
                    if #ex_selectedNames == 0 then
                        ex_selectedLabel.Text = "اختر لاعب أو أكثر من القائمة"
                    else
                        ex_selectedLabel.Text = "المستهدفون: " .. table.concat(ex_selectedNames, ",")
                    end
                    for playerName, ch in pairs(ex_playerChips) do
                        local selected = ex_isNameSelected(playerName)
                        TweenService:Create(ch, TweenInfo.new(0.12), {
                            BackgroundColor3 = selected and Color3.fromRGB(0, 130, 60) or ex_DARK2,
                            TextColor3 = selected and ex_YELLOW or ex_WHITE
                        }):Play()
                    end
                end)
                chip.MouseEnter:Connect(function()
                    if not ex_isNameSelected(p.Name) then TweenService:Create(chip, TweenInfo.new(0.1), {BackgroundTransparency = 0.05}):Play() end
                end)
                chip.MouseLeave:Connect(function()
                    if not ex_isNameSelected(p.Name) then TweenService:Create(chip, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play() end
                end)
                ex_playerChips[p.Name] = chip
            end
        end
    end

    ex_refreshPlayers()
    Players.PlayerAdded:Connect(ex_refreshPlayers)
    Players.PlayerRemoving:Connect(function(player)
        for i = #ex_selectedNames, 1, -1 do
            if ex_selectedNames[i] == player.Name then
                table.remove(ex_selectedNames, i)
            end
        end
        if #ex_selectedNames == 0 then
            ex_selectedLabel.Text = "اختر لاعب أو أكثر من القائمة"
        else
            ex_selectedLabel.Text = "المستهدفون: " .. table.concat(ex_selectedNames, ",")
        end
        ex_refreshPlayers()
    end)

    local function ex_updateNameModeUI()
        if ex_nameMode == "full" then
            TweenService:Create(ex_fullNameBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 155, 70), BackgroundTransparency = 0.0, TextColor3 = ex_YELLOW}):Play()
            TweenService:Create(ex_threeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(25, 55, 30), BackgroundTransparency = 0.1, TextColor3 = ex_WHITE}):Play()
        else
            TweenService:Create(ex_fullNameBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(25, 55, 30), BackgroundTransparency = 0.1, TextColor3 = ex_WHITE}):Play()
            TweenService:Create(ex_threeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 155, 70), BackgroundTransparency = 0.0, TextColor3 = ex_YELLOW}):Play()
        end
    end

    ex_updateNameModeUI()
    ex_fullNameBtn.MouseButton1Click:Connect(function() ex_nameMode = "full"; ex_updateNameModeUI() end)
    ex_threeBtn.MouseButton1Click:Connect(function() ex_nameMode = "three"; ex_updateNameModeUI() end)

    ex_prefixBox.FocusLost:Connect(function()
        local val = ex_prefixBox.Text
        if val == "" then val = ";"; ex_prefixBox.Text = ";" end
        pcall(function()
            if changeSettingRemote then
                changeSettingRemote:InvokeServer({[1] = "Prefix", [2] = val})
            end
        end)
        ex_setStatus("علامة الادمن: " .. val)
    end)

    local function ex_buildCustomMsg(input, name, prefix)
        prefix = prefix and prefix ~= "" and prefix or ";"
        input  = input:match("^%s*(.-)%s*$")
        if input == "" then return nil end
        local tokens = {}
        for tok in input:gmatch("%S+") do table.insert(tokens, tok) end
        if #tokens == 0 then return nil end
        local hasCmd = false
        for _, t in ipairs(tokens) do
            if t:sub(1, #prefix) == prefix then hasCmd = true; break end
        end
        local block
        if hasCmd and name then
            local parts = {}
            for _, t in ipairs(tokens) do
                if t:sub(1, #prefix) == prefix then table.insert(parts, t .. " " .. name)
                else table.insert(parts, t) end
            end
            block = table.concat(parts, " ")
        else
            block = input
        end
        local result = {}
        for i = 1, 35 do result[i] = block end
        return table.concat(result, " ")
    end

    local function ex_stopSpam()
        ex_spamRunning = false; ex_spamThread = nil
        TweenService:Create(ex_startBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 175, 80)}):Play()
        ex_startBtn.Text = "تشغيل السبام"
        ex_setStatus("تم ايقاف السبام")
    end

    local function ex_startSpam()
        if ex_spamRunning then ex_stopSpam(); task.wait(0.05) end
        local prefix0 = (ex_prefixBox.Text ~= "" and ex_prefixBox.Text) or ";"
        local input0  = ex_cmdBox.Text:match("^%s*(.-)%s*$")
        if input0 == "" then ex_setStatus("اكتب امر او كلام في الصندوق اولا"); return end
        local hasCmd0 = false
        for tok in input0:gmatch("%S+") do
            if tok:sub(1, #prefix0) == prefix0 then hasCmd0 = true; break end
        end
        if hasCmd0 and not ex_getEffectiveName() then
            ex_setStatus("اختر لاعب من القائمة اولا"); return
        end
        ex_spamRunning = true
        TweenService:Create(ex_startBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 210, 95)}):Play()
        ex_startBtn.Text = "شغال..."
        ex_setStatus("السبام شغال — غير الصندوق وهو يتحدث فورا", true)
        ex_spamThread = task.spawn(function()
            while ex_spamRunning do
                local prefix = (ex_prefixBox.Text ~= "" and ex_prefixBox.Text) or ";"
                local input  = ex_cmdBox.Text
                local name   = ex_getEffectiveName()
                local msg    = ex_buildCustomMsg(input, name, prefix)
                if msg then sendOnce(msg) end
                local delayValue = tonumber(spamDelayBox.Text) or 0.2
                delayValue = math.clamp(delayValue, 0.08, 2)
                task.wait(delayValue)
            end
        end)
    end

    ex_startBtn.MouseButton1Click:Connect(function()
        if ex_spamRunning then return end
        ex_startSpam()
    end)
    ex_stopBtn.MouseButton1Click:Connect(function()
        if ex_spamRunning then ex_stopSpam() end
    end)
end

----------------------------------------------------------------
-- Default tab
----------------------------------------------------------------
pages["نسخ"].Visible = true
TweenService:Create(tabButtons["نسخ"], TweenInfo.new(0.15), {BackgroundTransparency = 0.1, TextColor3 = Color3.fromRGB(0, 255, 130)}):Play()

print("[PeakRayan Hub] Loaded — by 7aliv9 | 6767")
