class QueryController < ApplicationController
  def submit
    render json: params

  end
end
