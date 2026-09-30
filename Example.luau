local DrawingLibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/n8ptr/Drawing/refs/heads/main/Source.luau'))()

local Box = DrawingLibrary:CreateBox()

Box.Outline.Position = Vector2.new(500, 300)
Box.Outline.Size = Vector2.new(100, 200)

Box.Fill.Position = Vector2.new(500, 300)
Box.Fill.Size = Vector2.new(100, 200)

Box:SetFillTransparency(0.5)
Box:SetVisible(true)
