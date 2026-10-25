defmodule Client do
  @path "/tmp/demo.sock"

  def send_msg(text) do
    {:ok, sock} = :gen_tcp.connect({:local, @path}, 0, [:binary, packet: 4, active: false])
    :ok = :gen_tcp.send(sock, Demo.Request.encode(%Demo.Request{text: text}))
    {:ok, data} = :gen_tcp.recv(sock, 0)
    :gen_tcp.close(sock)
    Demo.Response.decode(data)
  end
end
