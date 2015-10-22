# Allows editors to create and update committees to group members in directory
class Editor::CommitteesController < Editor::EditorController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]

  # GET /committees
  def index
    @order = scrub_order(Committee, params[:order], 'committees.name')
    @committees = Committee.current.order(@order).page(params[:page]).per(40)
  end

  # GET /committees/1
  def show
  end

  # GET /committees/new
  def new
    @committee = Committee.new(position: Committee.current.count + 1)
  end

  # GET /committees/1/edit
  def edit
  end

  # POST /committees
  def create
    @committee = Committee.new(committee_params)
    if @committee.save
      redirect_to editor_committee_path(@committee), notice: 'Committee was successfully created.'
    else
      render :new
    end
  end

  # PATCH /committees/1
  def update
    if @committee.update(committee_params)
      redirect_to editor_committee_path(@committee), notice: 'Committee was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /committees/1
  def destroy
    @committee.destroy
    redirect_to editor_committees_path, notice: 'Committee was successfully destroyed.'
  end

  private

  def set_committee
    @committee = Committee.current.find_by_id params[:id]
    empty_response_or_root_path(editor_committees_path) unless @committee
  end

  def committee_params
    params.require(:committee).permit(:name, :slug, :position)
  end
end
