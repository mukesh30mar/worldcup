class Player < ActiveRecord::Base

  PLAYER_TYPES = ["Batsman","Bowler","WicketKeeper"]
  belongs_to :coach
  # attr_accessible :type,:coach_id, :email
  validates :email ,:type, :presence => true
  before_create :playerscount,:checkbowler,:checkwicketkeeper,:checkbatsman


  def playerscount
    totalplayers = Player.count(:conditions => {:coach_id => coach_id})
    # p Batsman.count
    #    p Bowler.count
    #    p WicketKeeper.count
    if totalplayers >= 15 
      self.errors[:base] = 'Every coach can add only 15 players'
      return false
    end

  end

  def checkbowler
#debugger
   if type== "Bowler" && Bowler.count(:conditions => {:coach_id => coach_id}) > 5
      self.errors[:base] = "u Cant add more than 6 bowler"
      return false
    end
  end

  def checkwicketkeeper
     if type== "WicketKeeper" && WicketKeeper.count(:conditions => {:coach_id => coach_id}) > 1
      self.errors[:base] = "u Cant add more than 2 wicketkeeper"
      return false
    end
  end

  def checkbatsman
  if type== "Batsman" && Batsman.count(:conditions => {:coach_id => coach_id}) > 6
      self.errors[:base] = "u Cant add more than 7 Batsman"
      return false
    end
  end
end


class Batsman < Player
  

end

class Bowler < Player
  

end

class WicketKeeper < Player


end
