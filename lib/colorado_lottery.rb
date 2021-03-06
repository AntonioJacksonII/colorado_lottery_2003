class ColoradoLottery

  attr_reader :registered_contestants, :winners, :current_contestants

  def initialize
    @registered_contestants = {}
    @winners = []
    @current_contestants = {}
  end

  def interested_and_18?(contestant, game)
    contestant.age >= 18 && contestant.game_interests.include?(game.name)
  end

  def can_register?(contestant, game)
    interested_and_18?(contestant, game) && (contestant.out_of_state? == false || game.national_drawing? == true)
  end

  def register_contestant(contestant, game)
    if can_register?(contestant, game)
      if @registered_contestants[game.name] == nil
        @registered_contestants[game.name] = [contestant]
      else
        @registered_contestants[game.name] << contestant
      end
    end
  end

  def eligible_contestants(game)
    contestants_eligible = []
    registered_contestants[game.name].each do |contestant|
      if contestant.spending_money > game.cost
        contestants_eligible << contestant
      end
    end
  end

  def charge_contestants(game)
    eligible_contestants(game).each do |contestant|
      contestant.spending_money -= game.cost
    end
  end

end
