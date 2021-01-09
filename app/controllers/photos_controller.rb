class PhotosController < ApplicationController

  before_action :require_login

  def index
    @photos = @current_user.photos.with_attached_image
                          .order(created_at: :desc)
  end

  def new
    @photo = Photo.new()
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = @current_user.id
    if @photo.save
      flash[:success] = "写真のアップロードに成功しました。"
      redirect_to root_url
    else
      flash.now[:danger] = '写真のアップロードに失敗しました。'
      render :new
    end
  end

  private

  def photo_params
    params.fetch(:photo).permit(:title, :image)
  end

end

