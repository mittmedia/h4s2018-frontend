class TopicsController < ApplicationController
  def index
  end

  def show
    @documents = Api::Document.all
  end
end
