# Controller responsavel por lidar com as operacoes relacionadas as Analytics.
#
# HA001 - Eu como admin quero armazenar estatísticas como quantos usuários existem no sistema
module Api
    module V1
        class AnalyticController < ApplicationController
            #acts_as_token_authentication_handler_for User, only: []
            #before_action :admin_authentication, only: []
            
            
            # Cria uma nova analytic
            #
            # @param [String] título da analytic
            def create
                dado = Analytic.new(params[:title])

                dado.save!
                render json: dado, status: :created
                rescue StandardError => e
                render json: e, status: :bad_request
            end

            # Obtém dados de uma analytic
            #
            # @param [String] título da analytic a ser procurada
            # @return [JSON] objeto json contendo o valor amarzenado pela analytic
            def show
                data = Analytic.find(params[:title])
                puts data
                render json: data, status: :ok
            end

            # Incrementa o valor em um de uma analytic
            #
            # @param [String] título da analytic
            def add
                
            end
        end
    end
end
