class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI
  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
    )


  scope :caught, -> { where(caught: true) }
  scope :free, -> { where(caught: false) }

  validates_inclusion_of :type, in: Pokemon::TYPES
  validate :not_too_many_caught

  def not_too_many_caught
    if caught && Pokemon.caught.by_type(type).count >= 2
      errors.add(:caught, "too many caught")
    end
  end

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


end
