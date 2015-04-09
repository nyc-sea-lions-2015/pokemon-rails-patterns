class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI
  
  scope :free, -> { where(caught: false) }
  scope :caught, -> { where(caught: true) }

  def self.by_type(type=nil)
    if type
      where(type: type)
    else
      all
    end
  end


end
