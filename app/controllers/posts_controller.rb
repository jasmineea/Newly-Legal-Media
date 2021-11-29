class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  require 'rss'
  require 'open-uri'

  # GET /posts or /posts.json
  def index
    rss_results = []
    rss = RSS::Parser.parse(open('http://feeds.feedburner.com/mjbizdaily/XdPJ').read, false).items[0..5]
    
 rss.each do |result|
      result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
      rss_results.push(result)
    end
      @news = rss_results

      culture_results = []
      culture_rss = RSS::Parser.parse(open('http://feeds.feedburner.com/hightimes/cvxv').read, false).items[0..5]

      culture_rss.each do |result|
        result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
        culture_results.push(result)
    end
      @culture = culture_results

   if params[:category].blank?
     @posts = Post.all.order("created_at DESC")
     pol_results = []
     pol_rss = RSS::Parser.parse(open('http://feeds.feedburner.com/marijuanamoment/Uffa').read, false).items[0..5]
     pol_rss.each do |result|
      result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
      pol_results.push(result)
    end
      @posts = pol_results

  else
    @category_id = Category.find_by(name: params[:category]).id
    @posts = Post.where(category_id: @category_id).order("created_at DESC")
  end

  
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :category_id, :image)
    end
end
