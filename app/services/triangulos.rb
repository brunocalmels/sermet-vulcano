module Triangulos

  # param a(Hash {x: 1,  y: 1}): Punto A del triangulo
  # param b(Hash {x: -2, y: 3}): Punto B del triangulo
  # param c(Hash {x: -1, y: 2}): Punto C del triangulo
  # return (float): Perimetro del triangulo
  def perimetro(a, b, c)
    raise ArgumentError.new("Puntos repetidos") if a==b or b==c or c==a
    largo(a, b) + largo(b, c) + largo(c, a)
  end 
  
  # param a(Hash {x: 1,  y: 1}): Punto A del segmento
  # param b(Hash {x: -2, y: 3}): Punto B del segmento
  # return (float): Largo del segmento
  def largo(a, b)
    Math::sqrt((a[:x] - b[:x])**2 + (a[:y] - b[:y])**2)
  end 

  # param a(Array[Hash {x: 1,  y: 1}]): Array de puntos [A0, A1] sobre la recta en n y n+1 respectivamente
  # param b(Array[Hash {x: -2, y: 3}]): Array de puntos [B0, B1] sobre la recta en n y n+1 respectivamente
  # param c(Array[Hash {x: -1, y: 2}]): Array de puntos [C0, C1] a cheaquear
  # return (Float): Devuelve 1 si C0 y C1 se encuentran de lados distintos de la recta entre n y n+1. Devuelve 0.5 si uno de los puntos se encuentra exactamente sobre la recta. Sino, devuelve 0.
  def cruza_recta(a, b, c)
    c0 = c[0]
    c1 = c[1]

    y_0_ideal = y_sobre_recta(a[0], b[0], c0[:x])
    y_1_ideal = y_sobre_recta(a[1], b[1], c1[:x])
    # Para evitar sumar por cambio de signo de pendiente entre a y b (y ideal muy grande)
    return 0.0 if y_0_ideal > Math::sqrt(c0[:x]**2 + c0[:y]**2)
    return 0.0 if y_1_ideal > Math::sqrt(c0[:x]**2 + c0[:y]**2)

    raise ArgumentError.new("Recta vertical") if y_1_ideal == Float::INFINITY

    comp0 = c0[:y] - y_0_ideal
    comp1 = c1[:y] - y_1_ideal
    producto = comp0 * comp1
    
    return 0.5 if producto == 0.0 
    return 1.0 if producto < 0.0 
    return 0.0
  end

  # param a(Hash {x: 1,  y: 1}): Punto A del segmento
  # param b(Hash {x: -2, y: 3}): Punto B del segmento
  # param x(Float): Valor de x cuyo valor de y sobre la recta debe calcularse 
  # return (Float): Valor de y ideal sobre la recta para x
  def y_sobre_recta(a, b, x)
    (b[:y] - a[:y]) / (b[:x] - a[:x]) * (x - a[:x]) + a[:y]
  end

  # param a(Hash {x: 1,  y: 1}): Punto A del segmento
  # param b(Hash {x: -2, y: 3}): Punto B del segmento
  # return (Hash { x_pos: false, x_neg: false, y_pos: false, y_neg: false }): Con true en los semiejes que sean cruzados por dicho segmento
  def segm_x_semiejes(a, b)
    cruces = { x_pos: false, x_neg: false, y_pos: false, y_neg: false }
    cruza_x = false
    cruza_y = false
    # Chequeamos que eje se cruza
    cruza_y = (a[:x] * b[:x] <= 0)
    cruza_x = (a[:y] * b[:y] <= 0)
    # Chequeamos el punto por donde corta cada eje para saber el semieje
    if cruza_x
      x = a[:y] * (b[:x] - a[:x]) / (a[:y] - b[:y]) + a[:x]
      if x > 0
        cruces[:x_pos] = true
      else 
        cruces[:x_neg] = true
      end
    end 
    if cruza_y
      y = a[:x] * (b[:y] - a[:y]) / (a[:x] - b[:x]) + a[:y]
      if y > 0
        cruces[:y_pos] = true
      else 
        cruces[:y_neg] = true
      end
    end

    cruces
  end
  
  # param a(Hash {x: 1,  y: 1}): Punto A del triangulo
  # param b(Hash {x: -2, y: 3}): Punto B del triangulo
  # param c(Hash {x: -1, y: 2}): Punto C del triangulo
  # return: bool que indica si el origen de coordenadas esta contenido en el triangulo
  def contiene_origen?(a, b, c)
    ab = segm_x_semiejes(a, b)
    bc = segm_x_semiejes(b, c)
    ca = segm_x_semiejes(c, a)
    ab.merge!(bc) { |key, oldval, newval| oldval or newval}
    ab.merge!(ca) { |key, oldval, newval| oldval or newval}

    # Devuelve true su se cruzaron todos los semiejes
    return ab.values == [true]*4
  end 
end 