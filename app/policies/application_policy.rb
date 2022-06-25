class ApplicationPolicy
  attr_reader :member, :user, :record

  def initialize(context, record)
    @member = context.try(:member)
    @user = context.try(:user) || context
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end
