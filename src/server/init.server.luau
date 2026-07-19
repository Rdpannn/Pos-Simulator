local order = require(script.order)

-- isi teks billboard tiap rumah dari nama rumahnya
for _, rumah in workspace.map.pemukiman:GetChildren() do
	local titik = rumah:FindFirstChild("titikAntar")
	if titik then
		titik.BillboardGui.TextLabel.Text = rumah.Name
	end
end

order.mulai()
