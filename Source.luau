local DrawingLibrary = {}

-- // Colors
DrawingLibrary.Theme = {
	Accent = Color3.fromRGB(170, 0, 255),
	AccentDark = Color3.fromRGB(90, 0, 135),
	AccentDarker = Color3.fromRGB(45, 0, 70),

	Text = Color3.fromRGB(255, 255, 255),
	TextShadow = Color3.fromRGB(0, 0, 0),

	HealthDark = Color3.fromRGB(90, 0, 135),
	Health = Color3.fromRGB(170, 0, 255),
	HealthBackground = Color3.fromRGB(25, 0, 40)
}

-- // Core
function DrawingLibrary:Create(Type)
	local Object = Drawing.new(Type)

	Object.Visible = false

	return Object
end

function DrawingLibrary:Destroy(Object)
	if not Object then
		return
	end

	Object.Visible = false
	Object:Remove()
end

function DrawingLibrary:SetVisible(Object, Visible)
	if Object then
		Object.Visible = Visible
	end
end

function DrawingLibrary:GetHealthColor(Alpha)
	return self.Theme.HealthDark:Lerp(self.Theme.Health, math.clamp(Alpha, 0, 1))
end

-- // Base
function DrawingLibrary:CreateObject()
	return { Visible = false }
end

-- // Box
function DrawingLibrary:CreateBox()
	local Object = self:CreateObject()

	Object.Outline = self:Create('Square')
	Object.Fill = self:Create('Square')

	Object.FillTransparency = 0.35

	Object.Outline.Color = self.Theme.Accent
	Object.Outline.Thickness = 1.5
	Object.Outline.Transparency = 1
	Object.Outline.Filled = false
	Object.Outline.ZIndex = 3

	Object.Fill.Color = self.Theme.AccentDark
	Object.Fill.Transparency = Object.FillTransparency
	Object.Fill.Filled = true
	Object.Fill.ZIndex = 1

	function Object:SetVisible(Visible)
		self.Visible = Visible

		self.Outline.Visible = Visible
		self.Fill.Visible = Visible
	end

	function Object:SetFillTransparency(Transparency)
		self.FillTransparency = math.clamp(Transparency, 0, 1)
		self.Fill.Transparency = self.FillTransparency
	end

	function Object:Remove()
		DrawingLibrary:Destroy(self.Outline)
		DrawingLibrary:Destroy(self.Fill)
	end

	return Object
end

-- // Circle
function DrawingLibrary:CreateCircle()
	local Object = self:CreateObject()

	Object.Outline = self:Create('Circle')
	Object.Fill = self:Create('Circle')

	Object.FillTransparency = 0.35

	Object.Outline.Color = self.Theme.Accent
	Object.Outline.Thickness = 1.5
	Object.Outline.Transparency = 1
	Object.Outline.Filled = false
	Object.Outline.ZIndex = 3

	Object.Fill.Color = self.Theme.AccentDark
	Object.Fill.Transparency = Object.FillTransparency
	Object.Fill.Filled = true
	Object.Fill.ZIndex = 2

	function Object:SetVisible(Visible)
		self.Visible = Visible

		self.Outline.Visible = Visible
		self.Fill.Visible = Visible
	end

	function Object:SetFillTransparency(Transparency)
		self.FillTransparency = math.clamp(Transparency, 0, 1)
		self.Fill.Transparency = self.FillTransparency
	end

	function Object:Remove()
		DrawingLibrary:Destroy(self.Outline)
		DrawingLibrary:Destroy(self.Fill)
	end

	return Object
end

-- // Triangle
function DrawingLibrary:CreateTriangle()
	local Object = self:CreateObject()

	Object.Outline = self:Create('Triangle')
	Object.Fill = self:Create('Triangle')

	Object.FillTransparency = 0.35

	Object.Outline.Color = self.Theme.Accent
	Object.Outline.Thickness = 1.5
	Object.Outline.Transparency = 1
	Object.Outline.Filled = false
	Object.Outline.ZIndex = 3

	Object.Fill.Color = self.Theme.AccentDark
	Object.Fill.Transparency = Object.FillTransparency
	Object.Fill.Filled = true
	Object.Fill.ZIndex = 2

	function Object:SetVisible(Visible)
		self.Visible = Visible

		self.Outline.Visible = Visible
		self.Fill.Visible = Visible
	end

	function Object:SetFillTransparency(Transparency)
		self.FillTransparency = math.clamp(Transparency, 0, 1)
		self.Fill.Transparency = self.FillTransparency
	end

	function Object:Remove()
		DrawingLibrary:Destroy(self.Outline)
		DrawingLibrary:Destroy(self.Fill)
	end

	return Object
end

-- // Tracer
function DrawingLibrary:CreateTracer()
	local Object = self:CreateObject()

	Object.Line = self:Create('Line')

	Object.Line.Color = self.Theme.Accent
	Object.Line.Thickness = 1.5
	Object.Line.Transparency = 1
	Object.Line.ZIndex = 3

	function Object:SetVisible(Visible)
		self.Visible = Visible
		self.Line.Visible = Visible
	end

	function Object:Remove()
		DrawingLibrary:Destroy(self.Line)
	end

	return Object
end

-- // Text
function DrawingLibrary:CreateText()
	local Object = self:CreateObject()

	Object.Text = self:Create('Text')

	Object.Text.Text = ''
	Object.Text.Color = self.Theme.Text
	Object.Text.Size = 13
	Object.Text.Font = 2
	Object.Text.Center = true
	Object.Text.Outline = true
	Object.Text.Transparency = 1
	Object.Text.ZIndex = 5

	function Object:SetText(Value)
		self.Text.Text = tostring(Value)
	end

	function Object:SetColor(Color)
		self.Text.Color = Color
	end

	function Object:SetSize(Size)
		self.Text.Size = Size
	end

	function Object:SetVisible(Visible)
		self.Visible = Visible
		self.Text.Visible = Visible
	end

	function Object:Remove()
		DrawingLibrary:Destroy(self.Text)
	end

	return Object
end

-- // Healthbar
function DrawingLibrary:CreateHealthbar()
	local Object = self:CreateObject()

	Object.Background = self:Create('Square')
	Object.Segments = {}

	Object.Width = 5
	Object.SegmentsCount = 30

	Object.Background.Color = self.Theme.HealthBackground
	Object.Background.Transparency = 0.5
	Object.Background.Filled = true
	Object.Background.ZIndex = 2

	for Index = 1, Object.SegmentsCount do
		local Segment = self:Create('Square')

		Segment.Filled = true
		Segment.Transparency = 1
		Segment.ZIndex = 4

		Object.Segments[Index] = Segment
	end

	function Object:SetVisible(Visible)
		self.Visible = Visible

		self.Background.Visible = Visible

		for Index, Segment in pairs(self.Segments) do
			Segment.Visible = Visible
		end
	end

	function Object:Update(Position, Height, Health, MaxHealth)
		local HealthAlpha = math.clamp(Health / math.max(MaxHealth, 1), 0, 1)

		local SegmentHeight = Height / self.SegmentsCount

		self.Background.Position = Position
		self.Background.Size = Vector2.new(self.Width, Height)

		for Index, Segment in pairs(self.Segments) do
			local SegmentBottom = (Index - 1) / self.SegmentsCount
			local SegmentTop = Index / self.SegmentsCount

			local GradientAlpha = 1 - ((Index - 1) / math.max(self.SegmentsCount - 1, 1))

			Segment.Color = DrawingLibrary:GetHealthColor(GradientAlpha)

			local SegmentY = Position.Y + Height - (Index * SegmentHeight)

			if HealthAlpha >= SegmentTop then
				Segment.Position = Vector2.new(Position.X, SegmentY)

				Segment.Size = Vector2.new(self.Width, SegmentHeight + 0.5)

				Segment.Transparency = 1
				Segment.Visible = true

			elseif HealthAlpha > SegmentBottom then
				local PartialAlpha = math.clamp((HealthAlpha - SegmentBottom) / (SegmentTop - SegmentBottom), 0, 1)

				local FilledHeight = SegmentHeight * PartialAlpha

				Segment.Position = Vector2.new(Position.X, SegmentY + SegmentHeight - FilledHeight)

				Segment.Size = Vector2.new(self.Width, math.max(FilledHeight, 0.1))

				Segment.Transparency = 1
				Segment.Visible = true
			else
				Segment.Visible = false
			end
		end
	end

	function Object:Remove()
		DrawingLibrary:Destroy(self.Background)

		for Index, Segment in pairs(self.Segments) do
			DrawingLibrary:Destroy(Segment)
		end
	end

	return Object
end

return DrawingLibrary
