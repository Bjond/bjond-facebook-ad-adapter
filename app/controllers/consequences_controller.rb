class ConsequencesController < ApplicationController

  def createOffer
    svc = BjondService.find_by_group_id(params[:groupid])
    puts 'Received consequence callback form Bjond server'
  end
end
