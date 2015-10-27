# Allows editors to create and update members in the directory
# Members are purely listings, and are not related to user logins
class Editor::MembersController < Editor::EditorController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  def index
    @order = scrub_order(Member, params[:order], 'members.last_name')
    @members = Member.current.order(@order).page(params[:page]).per(40)
  end

  # GET /members/1
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to editor_member_path(@member), notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  # PATCH /members/1
  def update
    if @member.update(member_params)
      redirect_to editor_member_path(@member), notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to editor_members_path, notice: 'Member was successfully destroyed.'
  end

  private

  def set_member
    @member = Member.current.find_by_id params[:id]
    empty_response_or_root_path(editor_members_path) unless @member
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :email, :phone, :role, :site_id)
  end
end
