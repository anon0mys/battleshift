class Ship
  attr_reader :length, :damage, :start_space,
              :end_space

  def initialize(length, start_space, end_space)
    @length = length
    @damage = 0
    @start_space = start_space
    @end_space = end_space
  end

  def attack!
    @damage += 1
  end

  def is_sunk?
    @damage == @length
  end
end
