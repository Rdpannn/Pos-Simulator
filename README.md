# Pos Simulator

Game Roblox bergenre simulator. Player jadi tukang pos: nganter barang ke berbagai zona, sekaligus punya dan ngembangin kantor pos sendiri — upgrade gedung, beli kendaraan, rekrut kurir.

## Development

Project ini pakai [Rojo](https://rojo.space) buat sinkronisasi kode ke Roblox Studio.

```bash
rojo serve
```

Lalu connect lewat plugin Rojo di Roblox Studio.

## Struktur

- `src/server` — script server (ServerScriptService)
- `src/client` — script client (StarterPlayerScripts)
- `src/shared` — module bersama (ReplicatedStorage)
