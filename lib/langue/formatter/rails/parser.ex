defmodule Langue.Formatter.Rails.Parser do
  @behaviour Langue.Formatter.Parser

  alias Langue.Utils.{NestedParserHelper, InterpolationsParserHelper}

  def parse(%{render: render}) do
    {:ok, [content]} = :fast_yaml.decode(render)

    entries =
      content
      |> Enum.at(0)
      |> elem(1)
      |> NestedParserHelper.parse()
      |> InterpolationsParserHelper.parse(~r/%{[^}]*}/)

    %Langue.Formatter.ParserResult{entries: entries}
  end
end
