class PhotosController < ApplicationController

  before_action :require_login

  def index
  end

  def new
    @photo = Photo.new()
  end

end

