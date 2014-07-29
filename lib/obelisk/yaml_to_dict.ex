defmodule Obelisk.YamlToDict do

  def convert(dictionary, []) do
    dictionary
  end

  def convert(dictionary, [head|tail]) do
    key = String.to_atom(to_string(elem(head, 0)))
    value = to_string(elem(head, 1))
    n = Dict.put dictionary, key, value
    convert n, tail
  end

end
