# frozen_string_literal: true

# Enzo
module Api
  module V1
    class ListGroupsController < ApplicationController
      def index
        list_group = ListGroupUser.all
        render json: array_serializer(list_group), status: :ok
      end

      def user_groups
        list_group = ListGroupUser.where('user_id = ?', params[:user_id])
        return_http = :ok
        return_http = :not_found if list_group.empty?
        render json: array_serializer(list_group), status: return_http
      rescue StandardError => e
        render json: e, status: :not_found
      end

      def group_users
        list_group = ListGroupUser.where('group_id = ?', params[:group_id])
        return_http = :ok
        return_http = :not_found if list_group.empty?
        render json: array_serializer(list_group), status: return_http
      rescue StandardError => e
        render json: e, status: :not_found
      end

      def create
        list_group = ListGroupUser.new(list_group_params)
        list_group.save!
        render json: list_group, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      def delete
        list_group = ListGroupUser.find(params[:id])
        list_group.destroy!
        render json: list_group, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(group)
        Panko::ArraySerializer.new(group, each_serializer: ListGroupsSerializer).to_json
      end

      def serializer(group)
        ListGroupsSerializer.new.serialize_to_json(group)
      end

      def list_group_params
        params.require(:list_group_user).permit(:user_id, :group_id)
      end
    end
  end
end
