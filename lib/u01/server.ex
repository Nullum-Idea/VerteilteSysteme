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
        req = U01.Request.decode(data)

        resp =
          case req.text do
            "time" ->
              U01.Response.encode(%U01.Response{
                reply: "time: " <> Calendar.strftime(DateTime.utc_now(), "%Y-%m-%d %H:%M:%S")
              })

            _ ->
              U01.Response.encode(%U01.Response{reply: "echo: " <> req.text})
          end

        :gen_tcp.send(sock, resp)
        handle(sock)

      {:error, :closed} ->
        :ok
    end
  end
end
