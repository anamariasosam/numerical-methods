% Se crea el array de tiempo con los datos ingresados por el usuario
tiempo = [];
t_length = input('Cuantos elementos quieres guardar en el vector de tiempo? ');
for i=1:t_length
  tiempo(i)=input(sprintf('Ingresa un valor para la posición %d :',i ));
end

% ordenamos el array
tiempo = sort(tiempo);
disp('Se ha creado el siguiente array de tiempo:');
disp(tiempo);

% Luego se crea el array de velocidad con los datos ingresados
disp('Ingresa los datos para el array de velocidad:');
velocidad = [];
for i=1:t_length
  velocidad(i)=input(sprintf('Ingresa un valor para la posición %d :',i ));
end

velocidad = sort(velocidad);
disp('Se ha creado el siguiente array de velocidad:');
disp(velocidad);

% Se recorre el array de tiempo y de manera progresiva se crea un array
% para luego con esos valores saber el patron de aumento
progressive_array = zeros(1, t_length);
for i=1:t_length
  if i < t_length
    progressive_array(i) = tiempo(i+1) - tiempo(i);
  else
    progressive_array(t_length) = tiempo(i) - tiempo(i-1);
  endif
end

% creo un array con las posiciones del valor que mas se repite del array progresivo
pattern_array = find(diff(progressive_array)==0);
% Guardo en una variable el patron para saber de cuanto en cuanto debo aumentar
pattern_value = progressive_array(pattern_array(1));
sprintf('El array de tiempo aumenta de %d en %d', pattern_value,pattern_value)

% creo un array con los tiempo a evaluar empezando con el numero minimo del array de
% tiempo y terminando en el maximo y lo voy aumentando con el patron que se halló
tiempo_evaluar = [];
tiempo_evaluar_first_position = min(min(tiempo));
tiempo_evaluar(1) = tiempo_evaluar_first_position;
for i=2:max(max(tiempo))
  tiempo_evaluar(i)= tiempo_evaluar(i-1) + pattern_value;
end

% Creo el array para empezar a recorrer de manera centrada
aceleracion = zeros(1,length(tiempo_evaluar));
isInside = false;

% Recorro el array para hallar las derivadas
for i=1:length(tiempo)
  for j=1:length(tiempo_evaluar)
    if j == tiempo(i)
      if j < length(tiempo_evaluar)
        % de manera progresiva porque se que esta la posicion en el array tiempo
        aceleracion(i) = velocidad(i+1) - velocidad(i);
        isInside = true;
      else
        % esta es la ultima posicion del array asi que le resto la primera posicion
        aceleracion(i) = velocidad(i) - velocidad(1);
        isInside = true;
      end
    end
  end

  % Como no tengo el valor de la velocidad en ese tiempo lo calculo con
  % la de sus alredeores
  if isInside == false
    aceleracion(i) = velocidad(i+1) - velocidad(i-1);
  end

  isInside = false;

  sprintf('Cuando han pasado tiempo(x) %d segundos el cuerpo ha acelerado(y) %d', tiempo_evaluar(i), aceleracion(i))
end

% Grafico la funcion de tiempo vs aceleracion
plot(tiempo_evaluar, aceleracion);
