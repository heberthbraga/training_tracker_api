# frozen_string_literal: true

module Api
  module V1
    class AccountController < ApplicationController
      skip_before_action :authorize_request, only: :create

      api :POST, '/api/v1/account/create', 'Creates a new user account'
      param :account, Hash, desc: 'New account data', required: true do
        param :first_name, String, desc: 'User first name', required: true
        param :last_name, String, desc: 'User last name', required: true
        param :gender, String, desc: 'User gender', required: true
        param :birthdate, String, desc: 'User birthdate', required: true
        param :height, Hash, desc: 'User height info', required: true do
          param :value, Integer, desc: 'Height value', required: true
          param :symbol, String, desc: 'Height unit symbol', required: true
        end
        param :weight, Hash, desc: 'User weight info', required: true do
          param :value, Integer, desc: 'Weight value', required: true
          param :symbol, String, desc: 'Weight unit symbol', required: true
        end
        param :identity, Hash, desc: 'User creation identity', required: true do
          param :provider, String, desc: 'Identity Provider (email, social network)', required: true
          param :email, String, desc: 'User email', required: false
          param :password, String, desc: 'User encrypted password', required: false
        end
      end
      def create
        validate_identity(account_params[:identity])

        height = account_params[:height]
        weight = account_params[:weight]

        validate_height(height)
        validate_weight(weight)

        account_create_command = Api::V1::Account::Create.call account_params

        render json: account_create_command.result
      end

      private

      def validate_height(height)
        unless height.present? || (height.present? && height[:value].blank? && height[:symbol].blank?)
          raise Errors::HeightRequired
        end
      end

      def validate_weight(weight)
        unless weight.present? || (weight.present? && weight[:value].blank? && weight[:symbol].blank?)
          raise Errors::WeightRequired
        end
      end

      def validate_identity(identity)
        raise Errors::IdentityNotFound if identity.blank?
        raise Errors::ProviderNotFound if identity[:provider].blank?
      end

      def account_params
        params.require(:account).permit(
          :first_name,
          :last_name,
          :gender,
          :birthdate,
          {
            height: %i[value symbol]
          },
          {
            weight: %i[value symbol]
          },
          {
            identity: %i[provider email password]
          }
        )
      end
    end
  end
end
