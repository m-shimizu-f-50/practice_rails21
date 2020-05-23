class BooksController < ApplicationController
	before_action :authenticate_user!

  def index 
    @user =current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id

		if @book.save
			redirect_to @book
		else
      @user =current_user
			@books = Book.all
			render :index
		end
	end

  def edit
    @book = Book.find(params[:id])
    screen_user(@book)
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  


	private
	def book_params
  		params.require(:book).permit(:title,:body,:user_id)
  	end

  	def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def screen_user(book)
      if book.user.id != current_user.id
        redirect_to books_path
      end
    end

end
