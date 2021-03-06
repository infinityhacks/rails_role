class Role::Admin::RulesController < Role::Admin::BaseController
  before_action :set_govern
  before_action :set_rule, only: [:show, :roles, :edit, :update, :move_higher, :move_lower, :destroy]

  def create
    @rule = @govern.rules.build(rule_params)

    unless @rule.save
      render :new, locals: { model: @rule }, status: :unprocessable_entity
    end
  end

  def sync
    @govern.sync_rules

    redirect_to admin_governs_url(anchor: "tr_#{@govern.id}")
  end

  def new
    @rule = @govern.rules.build
  end

  def show
  end

  def roles
    @roles = @rule.roles
  end

  def edit
  end

  def update
    @rule.assign_attributes(rule_params)
    

    unless @rule.save
      render :edit, locals: { model: @rule }, status: :unprocessable_entity
    end
  end

  def move_higher
    @rule.move_higher
    redirect_to admin_governs_url(params.to_h)
  end

  def move_lower
    @rule.move_lower
    redirect_to admin_governs_url(params.to_h)
  end

  def destroy
    @rule.destroy
  end

  private
  def set_govern
    @govern = Govern.find params[:govern_id]
  end

  def set_rule
    @rule = Rule.find(params[:id])
  end

  def rule_params
    params.fetch(:rule, {}).permit(
      :code,
      :name,
      :params,
      :position
    )
  end

end
