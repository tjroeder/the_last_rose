class BacheloretteContestantsController < ApplicationController
  def index
    @bach = Bachelorette.find(params[:bach_id])
    @conts = @bach.contestants
  end
end