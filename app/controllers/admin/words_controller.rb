class Admin::WordsController < ApplicationController
  before_action :require_admin

  def index
    @words = Word.paginate page: params[:page], per_page: 20
  end
end