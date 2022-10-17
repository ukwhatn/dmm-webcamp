class BooksController < ApplicationController
  # GET
  def index
    @books = Book.all
    @book = Book.new
  end
  
  # POST
  def create
    @book = Book.new(list_params)
    
    if  @book.save
      flash[:notice] = "'#{@book.title}' was successfully added."
      redirect_to book_path(@book.id)
    else
      # validation error => Error Msg
      @books = Book.all
      render :index
    end
  end
  
  # GET
  def edit
    @book = Book.find(params[:id])
  end
  
  # GET
  def show
    @book = Book.find(params[:id])
  end
  
  # PATCH
  def update
    @book = Book.find(params[:id])
    
    if @book.update(list_params)
      flash[:notice] = "'#{@book.title}' was successfully updated."
      redirect_to book_path(@book.id)
    else
      # validation error => Error Msg
      render :edit
    end
  end
  
  # DELETE
  def destroy
    book = Book.find(params[:id])
    
    # error => Flash Msg
    if book.destroy
      flash[:notice] = "'#{book.title}' was successfully deleted."
    else
      flash[:error] = "失敗時メッセージ"
    end
    
    redirect_to books_path
  end
  
  private
  def list_params
    params.require(:book).permit(:title, :body)
  end
end
