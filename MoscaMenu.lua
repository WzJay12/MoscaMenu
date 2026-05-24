local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GuiAntiga = PlayerGui:FindFirstChild("MoscaMenuGui")
if GuiAntiga then
	GuiAntiga:Destroy()
end

local NomeMapa = game.Name

local SucessoInfo, InfoMapa = pcall(function()
	return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if SucessoInfo and InfoMapa and InfoMapa.Name then
	NomeMapa = InfoMapa.Name
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoscaMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false
ScreenGui.Parent = PlayerGui

local Janela = Instance.new("Frame")
Janela.Name = "Janela"
Janela.AnchorPoint = Vector2.new(0.5, 0.5)
Janela.Position = UDim2.new(0.5, 0, 0.5, 0)
Janela.Size = UDim2.new(0, 350, 0, 250)
Janela.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Janela.BackgroundTransparency = 0.05
Janela.BorderSizePixel = 1
Janela.BorderColor3 = Color3.fromRGB(0, 0, 0)
Janela.Parent = ScreenGui

local IconeAbrir = Instance.new("TextButton")
IconeAbrir.Name = "IconeAbrir"
IconeAbrir.Size = UDim2.new(0, 38, 0, 38)
IconeAbrir.Position = UDim2.new(0, 15, 0.5, -19)
IconeAbrir.BackgroundColor3 = Color3.fromRGB(95, 55, 150)
IconeAbrir.BackgroundTransparency = 0.08
IconeAbrir.BorderSizePixel = 0
IconeAbrir.Text = "🦟"
IconeAbrir.TextColor3 = Color3.fromRGB(255, 255, 255)
IconeAbrir.Font = Enum.Font.GothamBold
IconeAbrir.TextSize = 22
IconeAbrir.Visible = false
IconeAbrir.Parent = ScreenGui

local IconeCanto = Instance.new("UICorner")
IconeCanto.CornerRadius = UDim.new(0, 8)
IconeCanto.Parent = IconeAbrir

local IconeBorda = Instance.new("UIStroke")
IconeBorda.Color = Color3.fromRGB(255, 255, 255)
IconeBorda.Transparency = 0
IconeBorda.Thickness = 1.5
IconeBorda.Parent = IconeAbrir

local IconeGradiente = Instance.new("UIGradient")
IconeGradiente.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 95, 205)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 40, 120))
})
IconeGradiente.Rotation = 90
IconeGradiente.Parent = IconeAbrir

local Sombra = Instance.new("ImageLabel")
Sombra.Name = "SombraRoxa"
Sombra.AnchorPoint = Vector2.new(0.5, 0.5)
Sombra.Position = UDim2.new(0.5, 0, 0.5, 8)
Sombra.Size = UDim2.new(1, 35, 1, 35)
Sombra.BackgroundTransparency = 1
Sombra.Image = "rbxassetid://1316045217"
Sombra.ImageColor3 = Color3.fromRGB(105, 45, 180)
Sombra.ImageTransparency = 0.55
Sombra.ScaleType = Enum.ScaleType.Slice
Sombra.SliceCenter = Rect.new(10, 10, 118, 118)
Sombra.ZIndex = 0
Sombra.Parent = Janela

local GradienteJanela = Instance.new("UIGradient")
GradienteJanela.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(32, 32, 32)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22))
})
GradienteJanela.Rotation = 90
GradienteJanela.Parent = Janela

local BarraTopo = Instance.new("Frame")
BarraTopo.Name = "BarraTopo"
BarraTopo.Size = UDim2.new(1, 0, 0, 32)
BarraTopo.Position = UDim2.new(0, 0, 0, 0)
BarraTopo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BarraTopo.BackgroundTransparency = 0.15
BarraTopo.BorderSizePixel = 0
BarraTopo.Parent = Janela

local GradienteTopo = Instance.new("UIGradient")
GradienteTopo.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 60, 90)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(55, 55, 55)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
})
GradienteTopo.Rotation = 0
GradienteTopo.Parent = BarraTopo

local Titulo = Instance.new("TextLabel")
Titulo.Name = "Titulo"
Titulo.Size = UDim2.new(1, -45, 1, 0)
Titulo.Position = UDim2.new(0, 8, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "MoscaMenu"
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.TextTransparency = 0
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextXAlignment = Enum.TextXAlignment.Left
Titulo.Parent = BarraTopo

local Fechar = Instance.new("TextButton")
Fechar.Name = "Fechar"
Fechar.Size = UDim2.new(0, 32, 1, 0)
Fechar.Position = UDim2.new(1, -34, 0, 0)
Fechar.BackgroundTransparency = 1
Fechar.Text = "X"
Fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
Fechar.Font = Enum.Font.GothamBold
Fechar.TextSize = 16
Fechar.Parent = BarraTopo

Fechar.MouseButton1Click:Connect(function()
	Janela.Visible = false
	IconeAbrir.Visible = true
end)

IconeAbrir.MouseButton1Click:Connect(function()
	Janela.Visible = true
	IconeAbrir.Visible = false
end)

local MenuLateral = Instance.new("Frame")
MenuLateral.Name = "MenuLateral"
MenuLateral.Size = UDim2.new(0, 98, 1, -42)
MenuLateral.Position = UDim2.new(0, 6, 0, 38)
MenuLateral.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
MenuLateral.BackgroundTransparency = 0.25
MenuLateral.BorderSizePixel = 0
MenuLateral.Parent = Janela

local ListaMenu = Instance.new("UIListLayout")
ListaMenu.FillDirection = Enum.FillDirection.Vertical
ListaMenu.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListaMenu.VerticalAlignment = Enum.VerticalAlignment.Top
ListaMenu.Padding = UDim.new(0, 5)
ListaMenu.Parent = MenuLateral

local PaddingMenu = Instance.new("UIPadding")
PaddingMenu.PaddingTop = UDim.new(0, 0)
PaddingMenu.Parent = MenuLateral

local Area = Instance.new("Frame")
Area.Name = "Area"
Area.Size = UDim2.new(1, -120, 1, -50)
Area.Position = UDim2.new(0, 110, 0, 38)
Area.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Area.BackgroundTransparency = 0.2
Area.BorderSizePixel = 0
Area.Parent = Janela

local PaginaHome = Instance.new("Frame")
PaginaHome.Name = "Home"
PaginaHome.Size = UDim2.new(1, 0, 1, 0)
PaginaHome.BackgroundTransparency = 1
PaginaHome.Visible = true
PaginaHome.Parent = Area

local PaginaMosca = Instance.new("ScrollingFrame")
PaginaMosca.Name = "MoscaMenu"
PaginaMosca.Size = UDim2.new(1, -4, 1, 0)
PaginaMosca.Position = UDim2.new(0, 0, 0, 0)
PaginaMosca.BackgroundTransparency = 1
PaginaMosca.BorderSizePixel = 0
PaginaMosca.ScrollBarThickness = 4
PaginaMosca.ScrollBarImageColor3 = Color3.fromRGB(130, 115, 160)
PaginaMosca.CanvasSize = UDim2.new(0, 0, 0, 0)
PaginaMosca.AutomaticCanvasSize = Enum.AutomaticSize.Y
PaginaMosca.Visible = false
PaginaMosca.Parent = Area

local LayoutScroll = Instance.new("UIListLayout")
LayoutScroll.FillDirection = Enum.FillDirection.Vertical
LayoutScroll.HorizontalAlignment = Enum.HorizontalAlignment.Center
LayoutScroll.VerticalAlignment = Enum.VerticalAlignment.Top
LayoutScroll.Padding = UDim.new(0, 7)
LayoutScroll.Parent = PaginaMosca

local PaddingScroll = Instance.new("UIPadding")
PaddingScroll.PaddingTop = UDim.new(0, 0)
PaddingScroll.PaddingLeft = UDim.new(0, 0)
PaddingScroll.PaddingRight = UDim.new(0, 6)
PaddingScroll.Parent = PaginaMosca

local function TrocarPagina(Nome)
	PaginaHome.Visible = Nome == "Home"
	PaginaMosca.Visible = Nome ~= "Home"
end

local function CriarBotaoMenu(Texto)
	local Botao = Instance.new("TextButton")
	Botao.Name = Texto
	Botao.Size = UDim2.new(1, -8, 0, 30)
	Botao.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	Botao.BackgroundTransparency = 0.08
	Botao.BorderSizePixel = 1
	Botao.BorderColor3 = Color3.fromRGB(22, 22, 22)
	Botao.Text = Texto
	Botao.TextColor3 = Color3.fromRGB(255, 255, 255)
	Botao.TextTransparency = 0.03
	Botao.Font = Enum.Font.GothamBold
	Botao.TextSize = 13
	Botao.Parent = MenuLateral

	local Gradiente = Instance.new("UIGradient")
	Gradiente.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(58, 58, 58)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 38, 38))
	})
	Gradiente.Rotation = 90
	Gradiente.Parent = Botao

	Botao.MouseButton1Click:Connect(function()
		TrocarPagina(Texto)
	end)

	return Botao
end

CriarBotaoMenu("Home")
CriarBotaoMenu("Player")
CriarBotaoMenu("TP")
CriarBotaoMenu("Visual")

local Infos = Instance.new("Frame")
Infos.Name = "Infos"
Infos.Size = UDim2.new(1, -8, 0, 190)
Infos.Position = UDim2.new(0, 0, 0, 0)
Infos.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Infos.BackgroundTransparency = 0.08
Infos.BorderSizePixel = 1
Infos.BorderColor3 = Color3.fromRGB(18, 18, 18)
Infos.Parent = PaginaHome

local InfosGradiente = Instance.new("UIGradient")
InfosGradiente.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(62, 62, 62)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(44, 44, 44)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 32, 42))
})
InfosGradiente.Rotation = 90
InfosGradiente.Parent = Infos

local InfosTitulo = Instance.new("TextLabel")
InfosTitulo.Name = "Titulo"
InfosTitulo.Size = UDim2.new(1, -12, 0, 30)
InfosTitulo.Position = UDim2.new(0, 6, 0, 5)
InfosTitulo.BackgroundTransparency = 1
InfosTitulo.Text = "Infos"
InfosTitulo.TextColor3 = Color3.fromRGB(255, 255, 255)
InfosTitulo.TextTransparency = 0.02
InfosTitulo.Font = Enum.Font.GothamBold
InfosTitulo.TextSize = 15
InfosTitulo.TextXAlignment = Enum.TextXAlignment.Left
InfosTitulo.Parent = Infos

local function CriarInfo(Texto, Ordem)
	local Label = Instance.new("TextLabel")
	Label.Name = "Info"
	Label.Size = UDim2.new(1, -12, 0, 22)
	Label.Position = UDim2.new(0, 6, 0, 38 + ((Ordem - 1) * 25))
	Label.BackgroundTransparency = 1
	Label.Text = Texto
	Label.TextColor3 = Color3.fromRGB(235, 235, 235)
	Label.TextTransparency = 0.05
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 12
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextWrapped = true
	Label.Parent = Infos
end

CriarInfo("Horario de criação: " .. os.date("%d/%m/%Y %H:%M:%S"), 1)
CriarInfo("Holders: Wzjay & Menddsz", 2)
CriarInfo("Mapa atual: " .. NomeMapa, 3)
CriarInfo("Id da place: " .. tostring(game.PlaceId), 4)
CriarInfo("Id do usuario: " .. tostring(Player.UserId), 5)

local function CriarCategoria(Nome, Quantidade)
	local Categoria = Instance.new("Frame")
	Categoria.Name = "MoscaMenu"
	Categoria.Size = UDim2.new(1, -8, 0, 0)
	Categoria.AutomaticSize = Enum.AutomaticSize.Y
	Categoria.BackgroundTransparency = 1
	Categoria.BorderSizePixel = 0
	Categoria.Parent = PaginaMosca

	local Layout = Instance.new("UIListLayout")
	Layout.FillDirection = Enum.FillDirection.Vertical
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Layout.VerticalAlignment = Enum.VerticalAlignment.Top
	Layout.Padding = UDim.new(0, 5)
	Layout.Parent = Categoria

	local TituloCategoria = Instance.new("TextLabel")
	TituloCategoria.Name = "MoscaMenu"
	TituloCategoria.Size = UDim2.new(1, 0, 0, 32)
	TituloCategoria.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	TituloCategoria.BackgroundTransparency = 0.08
	TituloCategoria.BorderSizePixel = 1
	TituloCategoria.BorderColor3 = Color3.fromRGB(18, 18, 18)
	TituloCategoria.Text = Nome
	TituloCategoria.TextColor3 = Color3.fromRGB(255, 255, 255)
	TituloCategoria.TextTransparency = 0.02
	TituloCategoria.Font = Enum.Font.GothamBold
	TituloCategoria.TextSize = 14
	TituloCategoria.Parent = Categoria

	local GradienteTitulo = Instance.new("UIGradient")
	GradienteTitulo.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(62, 62, 62)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(46, 46, 46)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 35, 45))
	})
	GradienteTitulo.Rotation = 90
	GradienteTitulo.Parent = TituloCategoria

	for i = 1, Quantidade do
		local Texto = Instance.new("TextLabel")
		Texto.Name = "MoscaMenu"
		Texto.Size = UDim2.new(1, 0, 0, 32)
		Texto.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Texto.BackgroundTransparency = 0.08
		Texto.BorderSizePixel = 1
		Texto.BorderColor3 = Color3.fromRGB(18, 18, 18)
		Texto.Text = "Mosca Menu"
		Texto.TextColor3 = Color3.fromRGB(255, 255, 255)
		Texto.TextTransparency = 0.03
		Texto.Font = Enum.Font.GothamBold
		Texto.TextSize = 14
		Texto.Parent = Categoria

		local GradienteTexto = Instance.new("UIGradient")
		GradienteTexto.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(44, 44, 44)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 32, 42))
		})
		GradienteTexto.Rotation = 90
		GradienteTexto.Parent = Texto
	end
end

CriarCategoria("MoscaMenu", 5)
CriarCategoria("MoscaMenu", 5)
