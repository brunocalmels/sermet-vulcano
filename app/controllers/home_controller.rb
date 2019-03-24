class HomeController < ApplicationController
  def index
    if params[:dia].to_f > 10000.0
      redirect_to root_path, alert: "¿Para qué quiere saber algo tan lejos en el futuro? Relájese y disfrute de la vida." and return
    end
    @params_in = params
    @dia = params[:dia].to_i || 0
    @galaxia = GalaxiaService.new
    @prediccion = @galaxia.prediccion(@dia)
    colineales = @galaxia.colineales
    @sequias = colineales[:sequias]
    @optimas = colineales[:optimas]
    triangular = @galaxia.triangular
    @lluvias = triangular[:lluvias]
    @perimetro = triangular[:perimetro]
    @clima = @prediccion[:clima]
    @posiciones = @prediccion[:posiciones]
    render 'home/index'
  end

  # def dia

  #   index
  # end 

  def show_json
    if params[:dia].to_f > 10000.0
      render json: {
        status: 403,
        message: "¿Para qué quiere saber algo tan lejos en el futuro? Relájese y disfrute de la vida."
      } and return
    end
    @params_in = params
    @dia = params[:dia].to_i || 0
    @galaxia = GalaxiaService.new
    @dia = params[:dia]
    @prediccion = @galaxia.prediccion(@dia.to_f)
    render json: {
      'dia': @dia.to_i,
      'clima': @prediccion[:clima],
      'posiciones': {
        'Ferengi': @prediccion[:posiciones][:ferengi],
        'Vulcano': @prediccion[:posiciones][:vulcano],
        'Betasoide': @prediccion[:posiciones][:betasoide]
      },
      status: 200,
    }
  end
end
