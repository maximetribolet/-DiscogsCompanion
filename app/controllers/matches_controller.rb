class MatchesController < ApplicationController
  def index
    @matches = Match.joins(:alerts).where(alerts: {user: current_user})
  end
end
