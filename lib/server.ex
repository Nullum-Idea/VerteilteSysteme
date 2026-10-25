defmodule Server do
  @path "/tmp/demo.sock"
  @opts [:binary, packet: 4, active: false]

  def start do
    # remove stale socket file
    File.rm(@path)
    {:ok, lsock} = :gen_tcp.listen(0, [{:ifaddr, {:local, @path}} | @opts])
    accept(lsock)
  end

  defp accept(lsock) do
    {:ok, sock} = :gen_tcp.accept(lsock)
    pid = spawn(fn -> handle(sock) end)
    :gen_tcp.controlling_process(sock, pid)
    accept(lsock)
  end

  defp handle(sock) do
    case :gen_tcp.recv(sock, 0) do
      {:ok, data} ->
        req = Demo.Request.decode(data)
        resp = Demo.Response.encode(%Demo.Response{reply: "echo: " <> req.text})
        :gen_tcp.send(sock, resp)
        handle(sock)

      {:error, :closed} ->
        :ok
    end
  end
end
