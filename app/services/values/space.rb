class Space
  attr_reader :coordinates, :status, :ship

  def initialize(coordinates)
    @coordinates = coordinates
    @ship    = nil
    @status      = "Not Attacked"
  end

  def attack!
    @status = if ship && not_attacked?
                ship.attack!
                "Hit"
              else
                "Miss"
              end
  end

  def occupy!(ship)
    @ship = ship
  end

  def occupied?
    !@ship.nil?
  end

  def not_attacked?
    status == "Not Attacked"
  end
end
