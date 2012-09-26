class TopicsController < ApplicationController
  respond_to :html, :json
  before_filter :load_data
  load_and_authorize_resource except: [:index, :show]

  def index
    @topics = @forum.topics
    respond_with @topics
  end

  def show
    @posts = @topic.posts.order(:created_at).includes(:user).paginate(page: params[:page])
    @topic.increment!(:views)
    respond_with @topic
  end

  def new
    @topic = Topic.new
    @post = @topic.posts.new
  end

  def edit
  end

  def create
    params[:topic][:posts_attributes].each do |k, v|
      params[:topic][:posts_attributes][k]["user_id"] = current_user.id
    end

    @topic = @forum.topics.new(params[:topic])
    @topic.user_id = current_user.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to [@forum, @topic], notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to [@forum, @topic], notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to forum_url(@topic.forum) }
      format.json { head :no_content }
    end
  end

  private
    def load_data
      @forum = Forum.find(params[:forum_id])
      @topic = @forum.topics.find(params[:id]) if params[:id]
    end

    def topic_params
      params.require(:topic).permit(:title, posts: [:content])
    end

end
