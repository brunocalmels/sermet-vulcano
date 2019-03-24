class GalaxiaService
  require 'planeta'
  require 'triangulos'
  include Triangulos
  DIAS = 10*360

  def initialize
    @ferengi   = @fer = Planeta.new('Ferengi',   1.0, -1,  500.0)
    @vulcano   = @vul = Planeta.new('Vulcano',   5.0,  1, 1000.0)
    @betasoide = @bet = Planeta.new('Betasoide', 3.0, -1, 2000.0)
  
    @dias = 1..DIAS+1
  end

  # =====================================
  def prediccion(n)
    sol = {x: 0.0, y: 0.0}
    fer_tn = { x: @fer.x_t(n), y: @fer.y_t(n) }
    vul_tn = { x: @vul.x_t(n), y: @vul.y_t(n) }
    bet_tn = { x: @bet.x_t(n), y: @bet.y_t(n) }
    fer_tn1 = { x: @fer.x_t(n), y: @fer.y_t(n) }
    vul_tn1 = { x: @vul.x_t(n), y: @vul.y_t(n) }
    bet_tn1 = { x: @bet.x_t(n), y: @bet.y_t(n) }
    resultado = {
                  clima: 'consulte con su meteorologo vulcano amigo',
                  posiciones: {
                    ferengi:   fer_tn,
                    vulcano:   vul_tn,
                    betasoide: bet_tn
                  }
                }

    if cruza_recta([fer_tn, fer_tn1], [vul_tn, vul_tn1], [bet_tn, bet_tn1]) != 0.0
      if cruza_recta([fer_tn, fer_tn1], [vul_tn, vul_tn1], [sol, sol]) != 0.0
        resultado[:clima] = 'sequia'
        return resultado
      else
        resultado[:clima] = 'condiciones optimas'
        return resultado
      end
    end
    if contiene_origen?(fer_tn, vul_tn, bet_tn)
      resultado[:clima] = 'lluvia'
      return resultado
    end
    resultado
  end 
  
  # =====================================
  def colineales
    optimas_count = 0
    sequias_count = 0
    sol = {x: 0.0, y: 0.0}
    fer_tn = { x: @fer.x_t(0), y: @fer.y_t(0) }
    vul_tn = { x: @vul.x_t(0), y: @vul.y_t(0) }
    bet_tn = { x: @bet.x_t(0), y: @bet.y_t(0) }

    # Cuenta cantidad de veces de colinealidad de 3 planetas
    @dias.each do |n|
      fer_tn1 = { x: @fer.x_t(n), y: @fer.y_t(n) }
      vul_tn1 = { x: @vul.x_t(n), y: @vul.y_t(n) }
      bet_tn1 = { x: @bet.x_t(n), y: @bet.y_t(n) }
      begin
        cruza = cruza_recta([fer_tn, fer_tn1], [vul_tn, vul_tn1], [bet_tn, bet_tn1])
      rescue # Recta vertical
        fer_tn1 = { x: @fer.x_t(n+0.01), y: @fer.y_t(n+0.01) }
        vul_tn1 = { x: @vul.x_t(n+0.01), y: @vul.y_t(n+0.01) }
        bet_tn1 = { x: @bet.x_t(n+0.01), y: @bet.y_t(n+0.01) }
        cruza = cruza_recta([fer_tn, fer_tn1], [vul_tn, vul_tn1], [bet_tn, bet_tn1])
      end 
      optimas_count += cruza
      
      # Chequea si el sol tambien se cruza
      if cruza != 0
        cruza_sol = cruza_recta([fer_tn, fer_tn1], [vul_tn, vul_tn1], [sol, sol])
        sequias_count += cruza_sol
      end

      fer_tn = fer_tn1
      vul_tn = vul_tn1
      bet_tn = bet_tn1
    end

    # optimas_count puede tener 0.5 de mas correspondientes al 1er punto solamente
    puts "La galaxia sufrirá #{optimas_count.floor} períodos de condiciones óptimas"
    puts "La galaxia sufrirá #{sequias_count.floor} períodos de sequía"
    return { optimas: optimas_count.floor, sequias: sequias_count.floor}
  end 
  
  # =====================================
  def triangular
    lluvias_count = 0
    dentro = [nil]*DIAS
    fer_t = { x: @fer.x_t(0), y: @fer.y_t(0) }
    vul_t = { x: @vul.x_t(0), y: @vul.y_t(0) }
    bet_t = { x: @bet.x_t(0), y: @bet.y_t(0) }
    s0 = (contiene_origen?(fer_t, vul_t, bet_t) ? 1 : -1)
    perim = {
      max: perimetro(fer_t, vul_t, bet_t),
      dia: 0
    }

    # Pruba de inclusion del Sol en triangulo para cada dia y compara con anterior
    dentro = @dias.map do |n|
      fer_t = { x: @fer.x_t(n), y: @fer.y_t(n) }
      vul_t = { x: @vul.x_t(n), y: @vul.y_t(n) }
      bet_t = { x: @bet.x_t(n), y: @bet.y_t(n) }
      s1 = (contiene_origen?(fer_t, vul_t, bet_t) ? 1 : -1)
      if s1 - s0 == 2
        lluvias_count += 1
      end
      s0 = s1

      perim_dia = perimetro(fer_t, vul_t, bet_t)
      if perim_dia > perim[:max]
        perim[:max] = perim_dia
        perim[:dia] = n
      end
    end

    puts "La galaxia sufrirá #{lluvias_count} períodos de lluvia"
    puts "El máximo perímetro será de #{perim[:max].round(2)} km, y ocurrirá el día #{perim[:dia]}"

    return { lluvias: lluvias_count, perimetro: perim }

  end
end