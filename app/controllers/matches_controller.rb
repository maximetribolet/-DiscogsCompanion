class MatchesController < ApplicationController
  def index
    @matches = Match.joins(:alert).where(alerts: {user: current_user})
  end
end
