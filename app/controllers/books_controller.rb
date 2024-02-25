class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
    @book_detail = Book.find(params[:id])
    unless ReadCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.read_counts.create(book_id: @book_detail.id)
    end
  end

  def index
    @book = Book.new
    @books = Book.all

    if params[:book].present? && params[:book][:scope].present?
      @books = @books.send(params[:book][:scope])
    end
  # if params[:latest]
  #   @books = Book.latest
  # elsif params[:old]
  #   @books = Book.old
  # elsif params[:star_count]
  #   @books = Book.star_count
  # else
  #   @books = Book.all
  # end

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :tag)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
  end

end
