# encoding: UTF-8

require 'i18n'

module DataValidator
  class BaseValidator
    attr_accessor :name, :value, :options, :errors

    def initialize(name, value, options, errors)
      raise ArgumentError, 'Options must define' if options.blank?

      case options
      when Hash
        @options = options
      else
        @options = {}
      end

      @name   = name
      @value  = value
      @errors = errors
    end

    def check_validity!
    end

    def validate
      raise ArgumentError, 'Validate method is necessary'
    end

    def add_error(error_message_key, message_args = {})
      error_subject_key = "datavalidator.errors.subjects.#{name}"
      error_subject = ''
      begin
        error_subject = I18n.t! "datavalidator.errors.subjects.#{name}"
      rescue
        error_subject = name.to_s
      end

      if errors.key? name
        errors[name] << "#{error_subject} #{I18n.t("datavalidator.errors.messages.#{error_message_key.to_s}", message_args)}"
      else
        errors[name] = ["#{error_subject} #{I18n.t("datavalidator.errors.messages.#{error_message_key.to_s}", message_args)}"]
      end
    end
  end
end


