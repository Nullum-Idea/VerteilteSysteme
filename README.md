# VerteilteSysteme

Exercise repo for VerteilteSysteme.

## Install

```bash
apt install elixir
apt install erlang
mix escript.install hex protobuf
mix deps.get

protoc --elixir_out=lib demo.proto
```

Add `export PATH="$HOME/.mix/escripts:$PATH"` to ~/.bashrc

## Run

```bash
# Terminal 1: server (keeps running)
mix run --no-halt -e "Server.start()"

# Terminal 2: client
iex -S mix
iex> Client.send_msg("hi")
```
