% --- Экстенсиональная сеть (конкретные факты) ---

% Отношение "является частью"
is_part_of(solar_system, space).       % Солнечная система является частью космоса
is_part_of(planet, solar_system).      % Планета является частью солнечной системы
is_part_of(star, galaxy).              % Звезда является частью галактики
is_part_of(satellite, mission).        % Спутник является частью миссии

% Отношение "использует"
uses(spaceship, astronaut).            % Космический корабль использует астронавта
uses(nasa, telescope).                 % NASA использует телескоп
uses(mission, spaceship).              % Миссия использует космический корабль
uses(nasa, satellite).                 % NASA использует спутник

% Отношение "находится в"
is_located_in(planet, orbit).          % Планета находится в орбите
is_located_in(spaceship, orbit).       % Космический корабль находится в орбите
is_located_in(satellite, orbit).       % Спутник находится в орбите
is_located_in(solar_system, galaxy).   % Солнечная система находится в галактике

% --- Интенсиональная сеть (правила и логические выводы) ---

% Транзитивное правило "находится в"
is_located_in_indirectly(X, Z) :- 
    is_located_in(X, Y), 
    is_located_in(Y, Z).

% Транзитивное правило "является частью"
is_part_of_indirectly(X, Z) :- 
    is_part_of(X, Y), 
    is_part_of(Y, Z).

% Дополнительное правило: если объект используется агентом, то он может находиться там, где находится агент
is_used_in_location(Object, Location) :-
    uses(Agent, Object), 
    is_located_in(Agent, Location).

% --- Запросы для семантической сети ---

% 1. Проверить, находится ли объект в другой структуре напрямую
% ?- is_located_in(planet, orbit).

% 2. Проверить, находится ли объект косвенно в другой структуре
% ?- is_located_in_indirectly(solar_system, galaxy).

% 3. Найти, какие объекты использует NASA
% ?- uses(nasa, What).

% 4. Определить, является ли что-то частью чего-то
% ?- is_part_of(satellite, What).

% 5. Найти все объекты, которые являются частью солнечной системы
% ?- is_part_of(What, solar_system).