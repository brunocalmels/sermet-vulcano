class HomeController < ApplicationController
  def index
    @galaxia = GalaxiaService.new
    colineales = @galaxia.colineales
    @sequias = colineales[:sequias]
    @optimas = colineales[:optimas]
    triangular = @galaxia.triangular
    @lluvias = triangular[:lluvias]
    @perimetro = triangular[:perimetro]
  end
end
