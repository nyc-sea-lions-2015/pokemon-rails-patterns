class PokemonController < ApplicationController

  def index
    @captured_pokemon = Pokemon.caught.by_type(params[:type]).order(:type, :id)
    @free_pokemon = Pokemon.free.by_type(params[:type]).order(:type, :id)
    @types = Pokemon::TYPES
  end

  def catch
    target_pokemon = Pokemon.find(id: params[:id])

    if target_pokemon.capt
      NotificationService.tell_friends "I caught #{found_pokemon.name.upcase}!"
    else
      flash[:notice] = "damn Damn DAMN! #{found_pokemon.name.upcase} got away!"
    end

    redirect_with_type

  end

  def release
    found_pokemon = Pokemon.where(id: params[:id]).first
    found_pokemon.release

    release_message = "#{found_pokemon.name} was released back into the wild"
    flash[:notice] = release_message
    NotificationService.tell_friends release_message

    redirect_with_type
  end

  private

  def redirect_with_type
    if params[:type].present?
      redirect_to "/?type=#{params[:type]}"
    else
      redirect_to '/'
    end
  end
end
