% Динамические предикаты для хранения данных фреймов
% frame(Имя, Слот, Значение) - хранит информацию о классах и экземплярах
:- dynamic frame/3.

% Функция получения значения слота с учетом наследования
% Ищет значение в текущем фрейме, затем в родительском, или вызывает IF-NEEDED
get_slot(Name, Slot, Value) :-
    frame(Name, Slot, Value), !;          % Если значение найдено в фрейме
    default_price(Name, Slot, Value).     % Если ничего нет, вызываем IF-NEEDED

% Функция установки значения слота с вызовом процедур
% Добавляет или заменяет значение, вызывая IF-DELETED и IF-ADDED при необходимости
set_slot(Name, Slot, Value) :-
    (frame(Name, Slot, OldValue) ->       % Если слот уже существует
        retract(frame(Name, Slot, OldValue)),  % Удаляем старое значение
        (Slot = shelf_life -> remove_expired(Name, OldValue); true)  % IF-DELETED для shelf_life
    ; true),
    assert(frame(Name, Slot, Value)),     % Добавляем новое значение
    (Slot = shelf_life -> remove_expired(Name, Value); true),  % IF-DELETED для shelf_life
    (Slot = price -> add_product(Name, Value, 300); true).  % IF-ADDED для price

% Иерархия классов через предикат parent(Подкласс, Родитель)
% Определяет структуру наследования для 10 классов
parent(food, product).          % Еда наследуется от продукта
parent(beverage, product).      % Напитки наследуются от продукта
parent(dairy_product, food).    % Молочные продукты наследуются от еды
parent(meat_product, food).     % Мясные продукты наследуются от еды
parent(vegetable, food).        % Овощи наследуются от еды
parent(fruit, food).            % Фрукты наследуются от еды
parent(soda, beverage).         % Газировки наследуются от напитков
parent(milk, dairy_product).    % Молоко наследуется от молочных продуктов
parent(cheese, dairy_product).  % Сыр наследуется от молочных продуктов

% Базовые фреймы классов с начальными значениями слотов
frame(product, category, 'product').    % Все продукты имеют категорию "product"
frame(food, category, 'food').          % Еда имеет категорию "food"
frame(beverage, category, 'beverage').  % Напитки имеют категорию "beverage"
frame(dairy_product, fat_content, unknown).  % У молочных по умолчанию жирность неизвестна
frame(meat_product, meat_type, unknown).     % У мяса по умолчанию тип неизвестен
frame(vegetable, category, unknown).  % У молочных по умолчанию жирность неизвестна
frame(fruit, category, unknown).     % У мяса по умолчанию тип неизвестен

% Экземпляры продуктов с конкретными значениями слотов
frame('Milk 3.2%', price, 100).         % Цена молока 100 руб.
frame('Milk 3.2%', shelf_life, 7).      % Срок годности молока 7 дней
frame('Milk 3.2%', fat_content, 3.2).   % Жирность молока 3.2%
frame('Cheddar Cheese', price, 500).    % Цена сыра 500 руб.
frame('Cheddar Cheese', shelf_life, 30). % Срок годности сыра 30 дней
frame('Beef', price, 800).              % Цена говядины 800 руб.
frame('Beef', shelf_life, -1).          % Говядина просрочена на 1 день

% --- Процедуры ---
% IF-ADDED: Уведомление о добавлении цены продукта
% Сравнивает цену с бюджетом 300 руб. и выводит сообщение
add_product(Name, Price, Budget) :-
    (Price =< Budget ->
        format('Продукт ~w добавлен, доступен (цена: ~w руб.).~n', [Name, Price]);
        format('Продукт ~w добавлен, но дорогой (цена: ~w руб.).~n', [Name, Price])).

% IF-DELETED: Реакция на удаление срока годности
% Проверяет, просрочен ли продукт, и выводит сообщение
remove_expired(Name, ShelfLife) :-
    (number(ShelfLife), ShelfLife =< 0 ->
        format('Продукт ~w просрочен и удален (срок: ~w дней).~n', [Name, ShelfLife]);
        format('Продукт ~w еще годен.~n', [Name])).

% IF-NEEDED: Установка цены по умолчанию
% Если цена не указана, задает значение 50 руб. и выводит сообщение
default_price(Name, price, Value) :-
    Value = 50,
    format('Цена для ~w не указана, установлена по умолчанию: ~w руб.~n', [Name, Value]).

% --- Запросы ---
% ?- get_slot('Milk 3.2%', fat_content, X).
% ?- set_slot('Salmon', price, 1000).
% ?- set_slot('Water', price, 30), get_slot('Water', price, X).
% ?- get_slot('Orange', price, X) 
% ?- set_slot('Beef', shelf_life, 10).