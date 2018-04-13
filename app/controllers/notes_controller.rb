class NotesController < ApplicationController

  parent_resources :property

  before_filter :find_parent

  def index
    @notes = @parent.notes
  end

  def new
    #FIXME this is not so good
    @index_path = request.path.gsub(/\/new$/, '')
  end

  def create
    @parent.notes.create(params[:note])
    redirect_to index_path
  end

  def show
    find_the_thing
  end

  def edit
    find_the_thing
  end

  def update
    find_the_thing
    @note.update_attributes(params[:note])
    redirect_to index_path
  end

  def destroy
    @parent.notes.find(params[:id]).destroy
    flash[:notice] = 'Note deleted'
    redirect_to index_path
  end

  private

  def note_path
    "#{index_path}/#{@note.id}"
  end

  def index_path
    "#{parent_path}/notes"
  end

  def parent_path
    request.path.gsub(/\/notes.*/, '')
  end

  def find_the_thing
    @note = @parent.notes.find(params[:id])
    @note_path = note_path
  end

end
