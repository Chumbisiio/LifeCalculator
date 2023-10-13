#CODIGO HECHO POR JERONIMO BETANCUR Y JUAN MANUEL OCAMPO

class LifeCalculator
  def initialize
    # Inicializa un hash para almacenar variables por etapa de vida.
    @variables_by_stage = {}
    
    # Inicializa un arreglo para almacenar las etapas de la vida.
    @stages = []
    
    # Imprime un mensaje de bienvenida.
    print_welcome_message
    
  end

  def print_welcome_message
    # Imprime un mensaje de bienvenida al usuario.
    puts "================================================"
    puts " Bienvenido seas a la calculadora de la vida :)"
    puts " Puedes ingresar valores positivos/negativos :D"
    puts "================================================"
  end

  def get_valid_input(prompt)
    loop do
      # Solicita una entrada al usuario.
      print prompt
      input = gets.chomp
      # Convierte la entrada a un número entero si es válido.
      return input.to_i if valid_input?(input)

      # Si la entrada no es válida, muestra un mensaje de error.
      puts "Error: Ingresa un valor numérico válido."
    end
  end

  def valid_input?(input)
    # Verifica si la entrada es un número entero válido utilizando una expresión regular.
    input =~ /^-?\d+$/
  end

  def set_variable(stage, variable_name, value)
    # Convierte los nombres de etapa y variable a símbolos para su uso como claves en el hash.
    stage = stage.to_sym
    variable_name = variable_name.to_sym
    # Inicializa la estructura de datos si es necesario.
    @variables_by_stage[stage] ||= {}
    @variables_by_stage[stage][variable_name] ||= 0
    # Actualiza el valor de la variable en la etapa de vida especificada.
    @variables_by_stage[stage][variable_name] += value
  end

  def add_stage(stage_name)
    # Agrega una etapa de vida al arreglo de etapas.
    @stages << stage_name
  end

  def input_income_and_expenses(stage)
    puts "Ingresa los ingresos y gastos para la etapa de #{stage}:"
    variables = @variables_by_stage[stage] || {}
    variables.each_key do |variable|
      # Solicita y registra ingresos o gastos para cada variable en la etapa de vida.
      print "Ingreso o gasto de #{variable.capitalize}: "
      value = get_valid_input("")
      set_variable(stage, variable, value)
    end
  end

  def calculate_balance
    total_balance = 0
    @variables_by_stage.each_value do |variables|
      # Calcula el saldo total sumando todos los valores de ingresos y gastos.
      total_balance += variables.values.sum
    end
    total_balance
  end

  def custom_final_message(final_balance)
    case final_balance <=> 0
    when 1
      "Has ahorrado #{final_balance}$ a lo largo de tu vida, pero ahora estás demasiado viejo para disfrutar el dinero y habrás muerto al desperdiciar toda tu vida trabajando."
    when -1
      "Pasaste toda tu vida triste y con una deuda de #{final_balance}$"
    else
      "De alguna forma te las arreglaste para no ahorrar ni perder nada, bien por ti!"
    end
  end

  def simulate_life
    @stages.each { |stage| input_income_and_expenses(stage) }
    # Calcula el saldo final y muestra un mensaje personalizado en función de ese saldo.
    puts custom_final_message(calculate_balance)
  end

  def add_variables_for_stage
    loop do
      print "Ingresa el nombre de la etapa de la vida para agregar (o 'no' para terminar): "
      stage_name = gets.chomp
      break if stage_name.downcase == 'no'

      # Agrega una nueva etapa de vida al arreglo de etapas.
      add_stage(stage_name)

      loop do
        print "Deseas agregar una nueva fuente de ingreso o gasto para la etapa '#{stage_name}'? (Sí/No): "
        response = gets.chomp.downcase
        break if response != "sí" && response != "si"

        # Agrega una nueva variable de ingreso o gasto a la etapa de vida.
        print "Nombre del ingreso/gasto: "
        variable_name = gets.chomp
        @variables_by_stage[stage_name] ||= {}
        @variables_by_stage[stage_name][variable_name] = 0
      end
    end
  end
end

# Crea una instancia de la clase LifeCalculator.
calculator = LifeCalculator.new

# Permite al usuario agregar etapas de vida y sus variables de ingreso/gasto.
calculator.add_variables_for_stage

# Simula la vida y muestra el mensaje final.
calculator.simulate_life


#CODIGO HECHO POR JERONIMO BETANCUR Y JUAN MANUEL OCAMPO
