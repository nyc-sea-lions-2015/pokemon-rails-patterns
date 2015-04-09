module PokemonsHelper
  def action(pokemon)
    pokemon.caught ? 'release' : 'catch'
  end

  def action_label(pokemon)
    action(pokemon).camelize + "!"
  end

end
