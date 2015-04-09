module PokemonsHelper
  def form_action(pokemon)
    pokemon.caught ?  pokemon_release_path(pokemon) :  pokemon_catch_path(pokemon)
  end

  def action_word(pokemon)
    pokemon.caught ? "Release!" : "Catch!"
  end
end
