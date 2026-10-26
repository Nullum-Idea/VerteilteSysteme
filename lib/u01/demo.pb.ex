defmodule U01.Request do
  @moduledoc false

  use Protobuf, full_name: "u01.Request", protoc_gen_elixir_version: "0.17.1", syntax: :proto3

  field :text, 1, type: :string
end

defmodule U01.Response do
  @moduledoc false

  use Protobuf, full_name: "u01.Response", protoc_gen_elixir_version: "0.17.1", syntax: :proto3

  field :reply, 1, type: :string
end
