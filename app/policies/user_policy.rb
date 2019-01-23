class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.where(index: true)
      end
    end
  end

  def index?
    return true
  end

  def destroy?
    if user.admin
      return true
    else
      return false
    end
  end

  def create?
    if user.admin
      return false
    else 
      return true
    end
  end

  def show?
    if user.admin
      return true
    else
      return true
    end
  end

  def download?
    if user.admin
      return true
    else
      return false
    end
  end

  def excel?
    if user.admin
      return true
    else
      return false
    end
  end

end
