class AdminSettingPolicy < ApplicationPolicy
  SETTINGS_ROLES = %w(superadmin support tag_wrangling policy_and_abuse).freeze

  def self.user_has_correct_role?(user, role)
    self.new(user, nil).user_has_correct_role?(role)
  end

  def user_has_correct_role?(role)
    user_has_roles?([role]) || user.roles.include?('superadmin')
  end

  def self.can_update_settings?(user)
    self.new(user, nil).can_update_settings?
  end

  def can_update_settings?
    user_has_roles?(SETTINGS_ROLES)
  end

  def permitted_attributes
    permitted = []
    if user.roles.include?('superadmin')
      permitted = permitted + [
        :account_creation_enabled, :invite_from_queue_enabled, :invite_from_queue_number,
        :invite_from_queue_frequency, :days_to_purge_unactivated,
        :invite_from_queue_at, :suspend_filter_counts, :suspend_filter_counts_at,
        :enable_test_caching, :cache_expiration, :tag_wrangling_off,
        :request_invite_enabled, :creation_requires_invite, :downloads_enabled,
        :hide_spam, :disable_support_form, :disabled_support_form_text
      ]
    elsif user.roles.include?('tag_wrangling')
      permitted = permitted + [:tag_wrangling_off]
    elsif user.roles.include?('support')
      permitted = permitted + [:disable_support_form]
    elsif user.roles.include?('policy_and_abuse')
      permitted = permitted + [:hide_spam]
    end

    permitted
  end

  alias_method :index?, :can_update_settings?
  alias_method :update?, :can_update_settings?
end
