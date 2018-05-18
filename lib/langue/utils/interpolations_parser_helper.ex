defmodule Langue.Utils.InterpolationsParserHelper do
  def parse(entry = %Entry, format) do
    interpolations =
      format
      |> regex()
      |> IO.inspect
      |> Regex.scan(entry.value, capture: :first)
      |> IO.inspect
      |> List.flatten()
      |> IO.inspect

    %{entry | interpolations: interpolations}
  end

  def parse(value, format) do
    interpolations =
      format
      |> regex()
      |> IO.inspect
      |> Regex.scan(value, capture: :first)
      |> IO.inspect
      |> List.flatten()
      |> IO.inspect

    %{entry | interpolations: interpolations}
  end

  defp regex(format) do
    case format do
      :android -> ~r/%(\d\$)?@/
      :es6_module -> ~r/{{[^}]*}}/
      :gettext -> ~r/%{[^}]*}/
      :java_properties -> ~r/\${[^}]*}/
      :java_properties_xml -> ~r/\${[^}]*}/
      :json -> ~r/{{[^}]*}}/
      :rails_yml -> ~r/%{[^}]*}/
      :strings -> ~r/%(\d\$)?s/
    end
  end
end
