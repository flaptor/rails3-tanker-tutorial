class PostsController < ApplicationController

  def search
    query = params[:query].nil? ? "" : params[:query] + '*'

    from_unit = params[:from_unit].nil? ? 1 : params[:from_unit].to_i
    from = params[:from].nil? || params[:from] == ""? "*" : params[:from].to_i * from_unit
    to_unit = params[:to_unit].nil? ? 1 : params[:to_unit].to_i
    to = params[:to].nil? || params[:to] == "" ? "*" : params[:to].to_i * to_unit

    if from != "*" or to != "*"
      @posts = Post.search_tank(query, :function => 1, 
        :filter_functions => {2 => [[from, to]]})
    else 
      @posts = Post.search_tank(query, :function => 1)
    end

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts
  # GET /posts.xml
  def index
    #@posts = Post.search_tank('123')
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # PUT /posts/:id/vote
  def vote
    post = Post.find(params[:id])
    post.votes = post.votes.nil? ? 1 : post.votes + 1
    post.save

    @posts = Post.all

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
