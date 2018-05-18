defmodule Langue.Formatter.Strings.Parser do
  @behaviour Langue.Formatter.Parser

  alias Langue.Utils.{LineByLineHelper, InterpolationsParserHelper}

  @prop_line_regex ~r/^(?<comment>.+)?"(?<key>.+)" ?= ?"(?<value>.*)"$/sm

  def parse(%{render: render}) do
    entries =
      render
      |> LineByLineHelper.Parser.lines(@prop_line_regex, ";\n")
      |> Enum.map(&InterpolationsParserHelper.parse(&1, :strings))

    %Langue.Formatter.ParserResult{entries: entries}
  end
end
