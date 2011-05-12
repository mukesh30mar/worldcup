class Player < ActiveRecord::Base

  PLAYER_TYPES = ["Batsman","Bowler","WicketKeeper"]
  belongs_to :coach
  validates :email ,:type, :presence => true
  before_create :playerscount,:checkbowler,:checkwicketkeeper,:checkbatsman

  def playerscount
    totalplayers = Player.count(:conditions => {:coach_id => coach_id})
    if totalplayers >= 15 
      self.errors[:base] = 'Every coach can add only 15 players'
      return false
    end
  end

  def checkbowler

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

  def self.activate(hash={})
    b=0
    w=0
    bat=0
    a = Array.new
    hash["status"].collect do |k,v|
      if v[:status] =="1"
        a.push(k)
      end
    end
    b= Player.count(:conditions => {:type => "Bowler" , :id => a})
    bat= Player.count(:conditions => {:type => "Batsman" , :id => a})
    w= Player.count(:conditions => {:type => "WicketKeeper" , :id => a})
    p "bowler #{b}"
    p "wicketKeeper #{w}"
    p "Batsman #{bat}" 
    if b < 3 || bat < 5 || w< 1 || (b+bat+w) >11
      return false
    else
      return true
    end  
  end
end


