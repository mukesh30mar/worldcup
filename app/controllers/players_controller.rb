class PlayersController < ApplicationController

  before_filter :authorize
  def index
    @players = Player.all(:conditions => {:coach_id => coach_id})
    @totalteammember = Player.count(:conditions => {:coach_id => coach_id, :status => 1})
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end


  def show
    @player = Player.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  def new
    @player = Player.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    coach = coach_id 
    @player = Player.new(params[:player].merge(:coach_id => coach_id))
    @player.type=params[:player][:type]
   
    respond_to do |format|
            if @player.save
              format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
              format.xml  { render :xml => @player, :status => :created, :location => @player }
            else
              format.html { render :action => "new" }
              format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
            end
          end
  end


  def update
    @player = Player.find(params[:id])
    respond_to do |format|
      if @player.update_attributes(params[:player])
        p @player
        format.html { redirect_to(player_path(@player), :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end


  def activate
    if Player.activate(params)
      Player.update(params[:status].keys, params[:status].values)
      flash[:notice] = 'Selected Players are active now.'
      redirect_to :action => "index"
    else
      flash[:notice] = 'Selected Players cannot be made active. Please select alteast 3 bowler, 5 batsmr and 1 wicketkeeper'
      redirect_to :action => "index"
    end

  end

  def batsmen
    @players = Batsman.all(:include => [:coach])
    render 'players'
  end

  def bowlers
    @players = Bowler.all(:include => [:coach])
    render 'players'
  end

  def wicketkeepers
    @players = WicketKeeper.all(:include => [:coach])
    render 'players'
  end

end
