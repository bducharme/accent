defmodule Langue.Utils.InterpolationsParserHelper do
  def parse(entries, regex) do
    entries
    |> Enum.map(&parse_entry(&1, regex))
  end

  defp parse_entry(entry, regex) do
    IO.puts(entry.value)
    interpolations =
      entry.value
      |> (&Regex.scan(regex, &1, capture: :first)).()
      |> List.flatten()

    IO.puts(interpolations)

    %{entry | interpolations: interpolations}
  end
end
