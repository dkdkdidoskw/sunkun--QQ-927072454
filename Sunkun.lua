local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- 语言系统定义
local LanguageSystem = {
    CurrentLanguage = "跟随系统",
    Translations = {
        ["跟随系统"] = {
            toggleButton = "打开/关闭",
            lockButton = "锁定UI",
            unlockButton = "取消锁定UI",
            title = "Sunkun",
            authorInfo = "作者: sunkun\n欢迎 %s 游玩本脚本",
            copyQQ = "复制QQ群聊号1",
            copied = "已复制!",
            languageSystem = "语言系统",
            switchLanguage = "切换",
            selectLanguage = "选择语言",
            followSystem = "跟随系统",
            chinese = "中文",
            english = "英文",
            german = "德语",
            russian = "俄语",
            spanish = "西班牙语"
        },
        ["中文"] = {
            toggleButton = "打开/关闭",
            lockButton = "锁定UI",
            unlockButton = "取消锁定UI",
            title = "Sunkun",
            authorInfo = "作者: sunkun\n欢迎 %s 游玩本脚本",
            copyQQ = "复制QQ群聊号1",
            copied = "已复制!",
            languageSystem = "语言系统",
            switchLanguage = "切换",
            selectLanguage = "选择语言",
            followSystem = "跟随系统",
            chinese = "中文",
            english = "英文",
            german = "德语",
            russian = "俄语",
            spanish = "西班牙语"
        },
        ["英文"] = {
            toggleButton = "Open/Close",
            lockButton = "Lock UI",
            unlockButton = "Unlock UI",
            title = "Sunkun",
            authorInfo = "Author: sunkun\nWelcome %s to this script",
            copyQQ = "Copy QQ Group 1",
            copied = "Copied!",
            languageSystem = "Language System",
            switchLanguage = "Switch",
            selectLanguage = "Select Language",
            followSystem = "Follow System",
            chinese = "Chinese",
            english = "English",
            german = "German",
            russian = "Russian",
            spanish = "Spanish"
        },
        ["德语"] = {
            toggleButton = "Öffnen/Schließen",
            lockButton = "UI sperren",
            unlockButton = "UI entsperren",
            title = "Sunkun",
            authorInfo = "Autor: sunkun\nWillkommen %s zu diesem Skript",
            copyQQ = "Kopiere QQ Gruppe 1",
            copied = "Kopiert!",
            languageSystem = "Sprachsystem",
            switchLanguage = "Wechseln",
            selectLanguage = "Sprache auswählen",
            followSystem = "System folgen",
            chinese = "Chinesisch",
            english = "Englisch",
            german = "Deutsch",
            russian = "Russisch",
            spanish = "Spanisch"
        },
        ["俄语"] = {
            toggleButton = "Открыть/Закрыть",
            lockButton = "Заблокировать UI",
            unlockButton = "Разблокировать UI",
            title = "Sunkun",
            authorInfo = "Автор: sunkun\nДобро пожаловать %s в этот скрипт",
            copyQQ = "Копировать QQ группу 1",
            copied = "Скопировано!",
            languageSystem = "Языковая система",
            switchLanguage = "Переключить",
            selectLanguage = "Выбрать язык",
            followSystem = "Следовать системе",
            chinese = "Китайский",
            english = "Английский",
            german = "Немецкий",
            russian = "Русский",
            spanish = "Испанский"
        },
        ["西班牙语"] = {
            toggleButton = "Abrir/Cerrar",
            lockButton = "Bloquear UI",
            unlockButton = "Desbloquear UI",
            title = "Sunkun",
            authorInfo = "Autor: sunkun\nBienvenido %s a este script",
            copyQQ = "Copiar Grupo QQ 1",
            copied = "¡Copiado!",
            languageSystem = "Sistema de Idioma",
            switchLanguage = "Cambiar",
            selectLanguage = "Seleccionar Idioma",
            followSystem = "Seguir Sistema",
            chinese = "Chino",
            english = "Inglés",
            german = "Alemán",
            russian = "Ruso",
            spanish = "Español"
        }
    }
}

-- 全局语言更新函数
local function updateAllTexts()
    local lang = LanguageSystem.CurrentLanguage
    local t = LanguageSystem.Translations[lang]
    
    -- 更新控制按钮文本
    toggleButton.Text = t.toggleButton
    if lockButton.Text == t.unlockButton then
        lockButton.Text = t.unlockButton
    else
        lockButton.Text = t.lockButton
    end
    
    -- 更新主UI文本
    titleLabel.Text = t.title
    languageTitle.Text = t.languageSystem
    switchLanguageButton.Text = t.switchLanguage
    popupTitleLabel.Text = t.selectLanguage
    
    -- 更新欢迎信息
    local playerName = Player.Name
    infoLabel.Text = string.format(t.authorInfo, playerName)
    
    -- 更新复制按钮文本
    if copyQqButton.Text ~= t.copied then
        copyQqButton.Text = t.copyQQ
    end
    
    -- 更新语言选项文本
    for i, button in ipairs(languageButtons) do
        local langName = languages[i]
        button.Text = t[string.lower(langName):gsub(" ", "")]
    end
end

-- 创建控制按钮UI（独立于主UI）
local controlGui = Instance.new("ScreenGui")
controlGui.Name = "ControlButtons"
controlGui.ResetOnSpawn = false
controlGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 控制按钮容器
local controlFrame = Instance.new("Frame")
controlFrame.Name = "ControlFrame"
controlFrame.Size = UDim2.new(0, 80, 0, 90)
controlFrame.Position = UDim2.new(0, 10, 0.5, -45)
controlFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
controlFrame.BackgroundTransparency = 0.3
controlFrame.BorderSizePixel = 0

-- 添加圆角效果
local controlCorner = Instance.new("UICorner")
controlCorner.CornerRadius = UDim.new(0, 8)
controlCorner.Parent = controlFrame

-- 添加彩虹边框效果
local controlStroke = Instance.new("UIStroke")
controlStroke.Color = Color3.new(1, 0, 0) -- 初始颜色
controlStroke.Thickness = 2
controlStroke.Parent = controlFrame

-- 彩虹颜色动画
local rainbowColors = {
    Color3.new(1, 0, 0),    -- 红
    Color3.new(1, 0.5, 0),  -- 橙
    Color3.new(1, 1, 0),    -- 黄
    Color3.new(0, 1, 0),    -- 绿
    Color3.new(0, 0.5, 1),  -- 蓝
    Color3.new(0.5, 0, 1),  -- 紫
    Color3.new(1, 0, 1)     -- 粉
}

local colorIndex = 1
local rainbowConnection
local function startRainbowEffect()
    if rainbowConnection then
        rainbowConnection:Disconnect()
    end
    
    rainbowConnection = RunService.Heartbeat:Connect(function(delta)
        colorIndex = (colorIndex + delta * 2) % #rainbowColors
        local idx = math.floor(colorIndex) + 1
        local nextIdx = (idx % #rainbowColors) + 1
        local t = colorIndex - math.floor(colorIndex)
        
        local currentColor = rainbowColors[idx]
        local nextColor = rainbowColors[nextIdx]
        
        controlStroke.Color = currentColor:Lerp(nextColor, t)
    end)
end

startRainbowEffect()

-- 打开/关闭按钮
toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(1, -10, 0, 35)
toggleButton.Position = UDim2.new(0, 5, 0, 5)
toggleButton.Text = "打开/关闭"
toggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
toggleButton.BackgroundTransparency = 0.3
toggleButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
toggleButton.TextStrokeTransparency = 0.7
toggleButton.TextStrokeColor3 = Color3.new(0, 0, 0)
toggleButton.BorderSizePixel = 0
toggleButton.ZIndex = 2
toggleButton.Parent = controlFrame

-- 锁定UI按钮
lockButton = Instance.new("TextButton")
lockButton.Name = "LockButton"
lockButton.Size = UDim2.new(1, -10, 0, 35)
lockButton.Position = UDim2.new(0, 5, 0, 50)
lockButton.Text = "锁定UI"
lockButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
lockButton.BackgroundTransparency = 0.3
lockButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
lockButton.TextStrokeTransparency = 0.7
lockButton.TextStrokeColor3 = Color3.new(0, 0, 0)
lockButton.BorderSizePixel = 0
lockButton.ZIndex = 2
lockButton.Parent = controlFrame

controlFrame.Parent = controlGui

-- 创建主UI容器
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainApp"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 主窗口框架
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- 添加圆角效果 
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- 添加彩虹边框效果
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.new(1, 0, 0)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- 标题栏
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
titleBar.BackgroundTransparency = 0.1
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

-- 标题文本
titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -10, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.Text = "Sunkun"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
titleLabel.TextStrokeTransparency = 0.7
titleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- 分界线
local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 0, 30)
divider.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
divider.BackgroundTransparency = 0.5
divider.BorderSizePixel = 0
divider.Parent = mainFrame

-- 内容区域容器
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, 0, 1, -31)
contentArea.Position = UDim2.new(0, 0, 0, 31)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

-- 左侧分类导航
local categoryFrame = Instance.new("ScrollingFrame")
categoryFrame.Name = "CategoryFrame"
categoryFrame.Size = UDim2.new(0, 120, 1, 0)
categoryFrame.Position = UDim2.new(0, 0, 0, 0)
categoryFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
categoryFrame.BackgroundTransparency = 0.3
categoryFrame.BorderSizePixel = 0
categoryFrame.ScrollBarThickness = 4
categoryFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
categoryFrame.Parent = contentArea

-- 右侧内容显示区域
local displayFrame = Instance.new("Frame")
displayFrame.Name = "DisplayFrame"
displayFrame.Size = UDim2.new(1, -120, 1, 0)
displayFrame.Position = UDim2.new(0, 120, 0, 0)
displayFrame.BackgroundTransparency = 1
displayFrame.Parent = contentArea

-- 创建分类按钮
local categories = {"首页类"}
local categoryButtons = {}

for i, categoryName in ipairs(categories) do
    local categoryButton = Instance.new("TextButton")
    categoryButton.Name = categoryName
    categoryButton.Size = UDim2.new(1, -10, 0, 35)
    categoryButton.Position = UDim2.new(0, 5, 0, 5 + (i-1)*40)
    categoryButton.Text = categoryName
    categoryButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    categoryButton.BackgroundTransparency = 0.3
    categoryButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
    categoryButton.TextStrokeTransparency = 0.7
    categoryButton.TextStrokeColor3 = Color3.new(0, 0, 0)
    categoryButton.BorderSizePixel = 0
    categoryButton.Parent = categoryFrame
    
    table.insert(categoryButtons, categoryButton)
end

-- 更新滚动区域大小
categoryFrame.CanvasSize = UDim2.new(0, 0, 0, #categories * 40)

-- 创建首页类内容
local homePage = Instance.new("Frame")
homePage.Name = "HomePage"
homePage.Size = UDim2.new(1, 0, 1, 0)
homePage.BackgroundTransparency = 1
homePage.Visible = true
homePage.Parent = displayFrame

-- 信息框
local infoFrame = Instance.new("Frame")
infoFrame.Name = "InfoFrame"
infoFrame.Size = UDim2.new(1, -10, 0, 80)
infoFrame.Position = UDim2.new(0, 5, 0, 5)
infoFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
infoFrame.BackgroundTransparency = 0.2
infoFrame.BorderSizePixel = 0
infoFrame.Parent = homePage

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoFrame

infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Size = UDim2.new(1, -10, 1, -10)
infoLabel.Position = UDim2.new(0, 5, 0, 5)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "作者: sunkun\n欢迎玩家游玩本脚本"
infoLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
infoLabel.TextStrokeTransparency = 0.7
infoLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
infoLabel.TextSize = 14
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.TextWrapped = true
infoLabel.Parent = infoFrame

-- 复制QQ群按钮
copyQqButton = Instance.new("TextButton")
copyQqButton.Name = "CopyQQButton"
copyQqButton.Size = UDim2.new(1, -10, 0, 35)
copyQqButton.Position = UDim2.new(0, 5, 0, 95)
copyQqButton.Text = "复制QQ群聊号1"
copyQqButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
copyQqButton.BackgroundTransparency = 0.3
copyQqButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
copyQqButton.TextStrokeTransparency = 0.7
copyQqButton.TextStrokeColor3 = Color3.new(0, 0, 0)
copyQqButton.BorderSizePixel = 0
copyQqButton.Parent = homePage

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = copyQqButton

-- 语言系统
local languageSystem = Instance.new("Frame")
languageSystem.Name = "LanguageSystem"
languageSystem.Size = UDim2.new(1, -10, 0, 70)
languageSystem.Position = UDim2.new(0, 5, 0, 140)
languageSystem.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
languageSystem.BackgroundTransparency = 0.2
languageSystem.BorderSizePixel = 0
languageSystem.Parent = homePage

local languageCorner = Instance.new("UICorner")
languageCorner.CornerRadius = UDim.new(0, 8)
languageCorner.Parent = languageSystem

-- 语言系统标题
languageTitle = Instance.new("TextLabel")
languageTitle.Name = "LanguageTitle"
languageTitle.Size = UDim2.new(1, -10, 0, 20)
languageTitle.Position = UDim2.new(0, 5, 0, 5)
languageTitle.BackgroundTransparency = 1
languageTitle.Text = "语言系统"
languageTitle.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
languageTitle.TextStrokeTransparency = 0.7
languageTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
languageTitle.TextSize = 16
languageTitle.Font = Enum.Font.GothamBold
languageTitle.TextXAlignment = Enum.TextXAlignment.Left
languageTitle.Parent = languageSystem

-- 当前语言显示和切换按钮
local currentLanguage = Instance.new("TextLabel")
currentLanguage.Name = "CurrentLanguage"
currentLanguage.Size = UDim2.new(0.6, -5, 0, 30)
currentLanguage.Position = UDim2.new(0, 5, 0, 30)
currentLanguage.BackgroundTransparency = 1
currentLanguage.Text = "跟随系统"
currentLanguage.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
currentLanguage.TextStrokeTransparency = 0.7
currentLanguage.TextStrokeColor3 = Color3.new(0, 0, 0)
currentLanguage.TextSize = 14
currentLanguage.Font = Enum.Font.Gotham
currentLanguage.TextXAlignment = Enum.TextXAlignment.Left
currentLanguage.Parent = languageSystem

switchLanguageButton = Instance.new("TextButton")
switchLanguageButton.Name = "SwitchLanguageButton"
switchLanguageButton.Size = UDim2.new(0.4, -5, 0, 30)
switchLanguageButton.Position = UDim2.new(0.6, 0, 0, 30)
switchLanguageButton.Text = "切换"
switchLanguageButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
switchLanguageButton.BackgroundTransparency = 0.3
switchLanguageButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
switchLanguageButton.TextStrokeTransparency = 0.7
switchLanguageButton.TextStrokeColor3 = Color3.new(0, 0, 0)
switchLanguageButton.BorderSizePixel = 0
switchLanguageButton.Parent = languageSystem

local switchButtonCorner = Instance.new("UICorner")
switchButtonCorner.CornerRadius = UDim.new(0, 6)
switchButtonCorner.Parent = switchLanguageButton

-- 语言选择弹窗
local languagePopup = Instance.new("Frame")
languagePopup.Name = "LanguagePopup"
languagePopup.Size = UDim2.new(0, 200, 0, 220)
languagePopup.Position = UDim2.new(0.5, -100, 0.5, -110)
languagePopup.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
languagePopup.BackgroundTransparency = 0.1
languagePopup.BorderSizePixel = 0
languagePopup.Visible = false
languagePopup.ZIndex = 10
languagePopup.Parent = screenGui

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0, 8)
popupCorner.Parent = languagePopup

local popupStroke = Instance.new("UIStroke")
popupStroke.Color = Color3.new(1, 1, 1)
popupStroke.Thickness = 2
popupStroke.Parent = languagePopup

-- 弹窗标题栏
local popupTitle = Instance.new("Frame")
popupTitle.Name = "PopupTitle"
popupTitle.Size = UDim2.new(1, 0, 0, 25)
popupTitle.Position = UDim2.new(0, 0, 0, 0)
popupTitle.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
popupTitle.BackgroundTransparency = 0.1
popupTitle.BorderSizePixel = 0
popupTitle.ZIndex = 11
popupTitle.Parent = languagePopup

popupTitleLabel = Instance.new("TextLabel")
popupTitleLabel.Name = "PopupTitleLabel"
popupTitleLabel.Size = UDim2.new(1, -10, 1, 0)
popupTitleLabel.Position = UDim2.new(0, 5, 0, 0)
popupTitleLabel.BackgroundTransparency = 1
popupTitleLabel.Text = "选择语言"
popupTitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
popupTitleLabel.TextStrokeTransparency = 0.7
popupTitleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
popupTitleLabel.TextSize = 14
popupTitleLabel.Font = Enum.Font.GothamBold
popupTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
popupTitleLabel.ZIndex = 11
popupTitleLabel.Parent = popupTitle

-- 语言选项滚动框
local languageOptions = Instance.new("ScrollingFrame")
languageOptions.Name = "LanguageOptions"
languageOptions.Size = UDim2.new(1, -10, 1, -35)
languageOptions.Position = UDim2.new(0, 5, 0, 30)
languageOptions.BackgroundTransparency = 1
languageOptions.BorderSizePixel = 0
languageOptions.ScrollBarThickness = 4
languageOptions.CanvasSize = UDim2.new(0, 0, 0, 0)
languageOptions.ZIndex = 11
languageOptions.Parent = languagePopup

-- 语言选项
local languages = {
    "跟随系统",
    "中文",
    "英文",
    "德语",
    "俄语",
    "西班牙语"
}

local languageButtons = {}

for i, language in ipairs(languages) do
    local languageButton = Instance.new("TextButton")
    languageButton.Name = language
    languageButton.Size = UDim2.new(1, 0, 0, 30)
    languageButton.Position = UDim2.new(0, 0, 0, (i-1)*35)
    languageButton.Text = language
    languageButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    languageButton.BackgroundTransparency = 0.3
    languageButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- 金黄色
    languageButton.TextStrokeTransparency = 0.7
    languageButton.TextStrokeColor3 = Color3.new(0, 0, 0)
    languageButton.BorderSizePixel = 0
    languageButton.ZIndex = 12
    languageButton.Parent = languageOptions
    
    table.insert(languageButtons, languageButton)
    
    languageButton.MouseButton1Click:Connect(function()
        LanguageSystem.CurrentLanguage = language
        currentLanguage.Text = language
        languagePopup.Visible = false
        updateAllTexts()
    end)
end

-- 更新语言选项滚动区域大小
languageOptions.CanvasSize = UDim2.new(0, 0, 0, #languages * 35)

-- 控制按钮拖动功能
local controlDragging = false
local controlDragInput, controlDragStart, controlStartPos

local function updateControlDrag(input)
    local delta = input.Position - controlDragStart
    controlFrame.Position = UDim2.new(
        controlStartPos.X.Scale, 
        controlStartPos.X.Offset + delta.X, 
        controlStartPos.Y.Scale, 
        controlStartPos.Y.Offset + delta.Y
    )
end

-- 主UI拖动功能
local mainDragging = false
local mainDragInput, mainDragStart, mainStartPos
local uiLocked = false

local function updateMainDrag(input)
    if not uiLocked then
        local delta = input.Position - mainDragStart
        mainFrame.Position = UDim2.new(
            mainStartPos.X.Scale, 
            mainStartPos.X.Offset + delta.X, 
            mainStartPos.Y.Scale, 
            mainStartPos.Y.Offset + delta.Y
        )
    end
end

-- 语言弹窗拖动功能
local popupDragging = false
local popupDragInput, popupDragStart, popupStartPos

local function updatePopupDrag(input)
    local delta = input.Position - popupDragStart
    languagePopup.Position = UDim2.new(
        popupStartPos.X.Scale, 
        popupStartPos.X.Offset + delta.X, 
        popupStartPos.Y.Scale, 
        popupStartPos.Y.Offset + delta.Y
    )
end

-- 控制按钮拖动处理
controlFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        controlDragging = true
        controlDragStart = input.Position
        controlStartPos = controlFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                controlDragging = false
            end
        end)
    end
end)

controlFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        controlDragInput = input
    end
end)

-- 主UI拖动处理
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not uiLocked then
        mainDragging = true
        mainDragStart = input.Position
        mainStartPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                mainDragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        mainDragInput = input
    end
end)

-- 语言弹窗拖动处理
popupTitle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        popupDragging = true
        popupDragStart = input.Position
        popupStartPos = languagePopup.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                popupDragging = false
            end
        end)
    end
end)

popupTitle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        popupDragInput = input
    end
end)

-- 输入变化处理
UserInputService.InputChanged:Connect(function(input)
    if input == controlDragInput and controlDragging then
        updateControlDrag(input)
    elseif input == mainDragInput and mainDragging then
        updateMainDrag(input)
    elseif input == popupDragInput and popupDragging then
        updatePopupDrag(input)
    end
end)

-- 锁定/解锁功能
lockButton.MouseButton1Click:Connect(function()
    uiLocked = not uiLocked
    local t = LanguageSystem.Translations[LanguageSystem.CurrentLanguage]
    if uiLocked then
        lockButton.Text = t.unlockButton
        lockButton.BackgroundColor3 = Color3.new(0.3, 0.2, 0.2)
    else
        lockButton.Text = t.lockButton
        lockButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    end
end)

-- 显示/隐藏功能（只控制主UI，不影响控制按钮）
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- 语言切换按钮功能
switchLanguageButton.MouseButton1Click:Connect(function()
    languagePopup.Visible = not languagePopup.Visible
end)

-- 复制QQ群号功能
copyQqButton.MouseButton1Click:Connect(function()
    local qqGroupNumber = "927072454"
    print("QQ群号已复制: " .. qqGroupNumber)
    
    -- 视觉反馈
    local t = LanguageSystem.Translations[LanguageSystem.CurrentLanguage]
    local originalText = copyQqButton.Text
    copyQqButton.Text = t.copied
    copyQqButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.2)
    
    wait(1.5)
    
    copyQqButton.Text = t.copyQQ
    copyQqButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
end)

-- 初始化
controlGui.Parent = PlayerGui
screenGui.Parent = PlayerGui
updateAllTexts()

-- 玩家角色加载时更新信息
Player.CharacterAdded:Connect(function()
    updateAllTexts()
end)
