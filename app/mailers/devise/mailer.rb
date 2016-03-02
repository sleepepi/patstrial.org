# frozen_string_literal: true

module Devise
  # Sends out emails generated by devise to users
  class Mailer < ApplicationMailer
    include Devise::Mailers::Helpers

    # def confirmation_instructions(record, token, opts={})
    #   setup_email
    #   @token = token
    #   devise_mail(record, :confirmation_instructions, opts)
    # end

    def reset_password_instructions(record, token, opts = {})
      setup_email
      @email_to = record.email
      @token = token
      devise_mail(record, :reset_password_instructions, opts)
    end

    # def unlock_instructions(record, token, opts={})
    #   setup_email
    #   @token = token
    #   devise_mail(record, :unlock_instructions, opts)
    # end
  end
end
