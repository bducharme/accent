defmodule Langue.Formatter.JavaProperties.Parser do
  @behaviour Langue.Formatter.Parser

  alias Langue.Utils.{LineByLineHelper, InterpolationsParserHelper}

  @prop_line_regex ~r/^(?<key>.+)=(?<value>.*)$/

  def parse(%{render: render}) do
    entries =
      render
      |> LineByLineHelper.Parser.lines(@prop_line_regex)
      |> Enum.map(&InterpolationsParserHelper.parse(&1, :java_properties))

    %Langue.Formatter.ParserResult{entries: entries}
  end
end
