class HomeController < ApplicationController
  def index
    @galaxia = GalaxiaService.new
    colineales = @galaxia.colineales
    @sequias = colineales[:sequias]
    @optimas = colineales[:optimas]
    triangular = @galaxia.triangular
    @lluvias = triangular[:lluvias]
    @perimetro = triangular[:perimetro]
    render 'home/index'
  end

  def dia
    @galaxia = GalaxiaService.new
    @dia = params[:dia]
    @prediccion = @galaxia.prediccion(@dia.to_f)
    @clima = @prediccion[:clima]
    @posiciones = @prediccion[:posiciones]

    index
  end 

  def show_json
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
      }
    }
  end
end
