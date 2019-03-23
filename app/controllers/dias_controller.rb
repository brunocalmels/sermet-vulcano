class DiasController < ApplicationController

  # GET /dia/1
  # GET /dia/1.json
  def show_json
    @galaxia = Galaxia.new
    render json: {
      'dia': params[:dia].to_i,
      'clima': 'lluvia'
    }
  end

end
