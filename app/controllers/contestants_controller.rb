class ContestantsController < ApplicationController
  def show
    @cont = Contestant.find(params[:id])
  end
end