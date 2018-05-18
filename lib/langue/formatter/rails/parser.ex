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
      |> Enum.map(&InterpolationsParserHelper.parse(&1, :rails_yml))

    %Langue.Formatter.ParserResult{entries: entries}
  end
end
