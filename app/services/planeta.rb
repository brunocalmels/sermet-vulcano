class Planeta
  def initialize(nombre, w_grados_dia, w_sentido, r_sol_km)
    raise ArgumentError.new("Sentido de giro debe ser 1 0 -1") unless [-1, 1].include?(w_sentido)
    raise ArgumentError.new("Radio no puede ser <= 0") unless r_sol_km > 0
    raise ArgumentError.new("Omega no puede ser <= 0") unless w_grados_dia > 0
    @nombre = nombre
    @w_grados_dia = w_grados_dia
    @w_sentido = w_sentido
    @r_sol_km = r_sol_km
  end

  def tita_t(t_dia)
    @w_sentido * @w_grados_dia * 2.0 * Math::PI / 360.0 * t_dia
  end 

  def x_t(t_dia)
    @r_sol_km * Math::cos(tita_t(t_dia))
  end

  def y_t(t_dia)
    @r_sol_km * Math::sin(tita_t(t_dia))
  end
end