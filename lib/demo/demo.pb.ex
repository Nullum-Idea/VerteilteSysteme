defmodule Demo.Request do
  @moduledoc false

  use Protobuf, full_name: "demo.Request", protoc_gen_elixir_version: "0.17.1", syntax: :proto3

  field :text, 1, type: :string
end

defmodule Demo.Response do
  @moduledoc false

  use Protobuf, full_name: "demo.Response", protoc_gen_elixir_version: "0.17.1", syntax: :proto3

  field :reply, 1, type: :string
end
