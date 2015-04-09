class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  scope :caught, -> { where(caught: true) }
  scope :free, -> { where(caught: false) }

  def self.by_type(type = nil)
    if type
      where(type:type)
    else
      all
    end
  end

  def catch
    self.caught = true
    save
  end

  def release
    self.caught = false
    save
  end

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
    )

end
