module Typus
  module Orm
    module ActiveRecord
      module User
        module InstanceMethods

          def to_label
            full_name = [first_name, last_name].delete_if { |s| s.blank? }
            full_name.any? ? full_name.join(" ") : email
          end

          def resources
            Typus::Configuration.roles[role].compact
          end

          def applications
            Typus.applications.delete_if { |a| application(a).empty? }
          end

          def application(name)
            Typus.application(name).delete_if { |r| !resources.keys.include?(r) }
          end

          def can?(action, resource, options = {})
            resource = resource.model_name if resource.is_a?(Class)

            return false if !resources.include?(resource)
            return true if resources[resource].include?("all")

            action = options[:special] ? action : action.acl_action_mapper

            resources[resource].extract_settings.include?(action)
          end

          def cannot?(*args)
            !can?(*args)
          end

          def is_root?
            role == Typus.master_role
          end

          def is_not_root?
            !is_root?
          end

          def role
            Typus.master_role
          end

          def locale
            ::I18n.locale
          end

        end
      end
    end
  end
end
