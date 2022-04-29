defmodule Absinthe.AsyncTest do
  use ExUnit.Case
  use Absinthe.Phoenix.ChannelCase

  setup_all do
    Absinthe.Test.prime(Schema)

    {:ok, _} = Absinthe.Phoenix.TestEndpoint.start_link()
    {:ok, _} = Absinthe.Subscription.start_link(Absinthe.Phoenix.TestEndpoint)
    :ok
  end

  defp get_socket(max_async_procs) do
    {:ok, _, socket} =
      "asdf"
      |> socket(
        absinthe: %{schema: Schema, opts: []},
        max_async_procs: max_async_procs
      )
      |> subscribe_and_join(Absinthe.Phoenix.Channel, "__absinthe__:control")

    socket
  end
end
