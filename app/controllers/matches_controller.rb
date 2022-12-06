class MatchesController < ApplicationController
  def index
    @matches = Match.where(user: current_user)
  end

  def create
    
  end
end
