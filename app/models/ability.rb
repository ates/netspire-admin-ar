class Ability
  include CanCan::Ability

  def initialize(user)
    can do |action, subject_class, subject|
      user.permissions.find_all_by_action(aliases_for_action(action)).any? do |permission|
        permission.subject_class == subject_class.to_s
      end
    end
  end
end
