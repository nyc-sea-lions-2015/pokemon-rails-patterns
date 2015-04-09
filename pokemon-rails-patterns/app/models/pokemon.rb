class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
    )

  validates_inclusion_of :type, in: TYPES

  validate :fewer_than_two_caught

  scope :free, -> { where(caught: false) }
  scope :caught, -> { where(caught: true) }

  def self.by_type(type=nil)
    if type
      where(type: type)
    else
      all
    end
  end

  def capture
    self.caught = true
    save
  end

  def release
    self.caught = false
    save
  end

  private 

  def fewer_than_two_caught
    if caught && Pokemon.caught.by_type(type).count >= 2
      errors.add(:caught, "too many caught")
    end
  end

end
