local barang = require(game.ReplicatedStorage.Shared.barang)

local order = {}

order.daftar = {}

-- angka sementara, nanti diatur pas balancing
local maxOrder = 3
local jedaSpawn = 5
local peluang = 0.5

-- jalur siaran daftar order ke semua client
local orderUpdate = Instance.new("RemoteEvent")
orderUpdate.Name = "orderUpdate"
orderUpdate.Parent = game.ReplicatedStorage

local function siarkan()
	orderUpdate:FireAllClients(order.daftar)
end

function order.buat()
	local b = barang[math.random(#barang)]
	local semuaRumah = workspace.map.pemukiman:GetChildren()
	local rumah = semuaRumah[math.random(#semuaRumah)]

	table.insert(order.daftar, {
		barang = b,
		rumah = rumah,
		alamat = rumah:GetAttribute("alamat") or rumah.Name,
	})
	siarkan()
end

function order.mulai()
	task.spawn(function()
		while true do
			task.wait(jedaSpawn)
			if #order.daftar < maxOrder and math.random() < peluang then
				order.buat()
			end
		end
	end)
end

return order
