class PostsController < ApplicationController
  respond_to :html, :json
  before_filter :load_data

  def index
    @posts = @topic.posts
    respond_with @posts
  end

  def show
    respond_with @post
  end

  def new
    @post = @topic.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def edit
  end

  def create
    @post = @topic.posts.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@forum, @topic], notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to [@forum, @topic], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    def load_data
      @forum = Forum.find(params[:forum_id])
      @topic = @forum.topics.find(params[:topic_id]) if params[:topic_id]
      @post = @topic.posts.find(params[:id]) if params[:id]
    end

    def post_params
      params.require(:post).permit(:content)
    end
end
