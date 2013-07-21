class ForumsController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource except: [:index, :show]

  def index
    @forums = Forum.order(:name).includes(:topics)
    respond_with @forums
  end

  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.order("created_at DESC").paginate(page: params[:page])
    respond_with @forum
  end

  def new
    @forum = Forum.new
  end

  def edit
  end

  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
        format.json { render json: @forum, status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :no_content }
    end
  end

  private

    def forum_params
      params.require(:forum).permit(:name, :description)
    end
end
