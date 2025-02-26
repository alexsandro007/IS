% Признаки проблем у компьютеров
sign(pc1, blue_screen).
sign(pc1, random_restarts).
sign(pc1, overheating).
sign(pc2, slow_performance).
sign(pc2, high_cpu_usage).
sign(pc3, no_internet).
sign(pc3, network_adapter_error).
sign(pc3, wifi_disconnected).
sign(pc4, boot_failure).
sign(pc4, beeping_sounds).
sign(pc4, black_screen).

% Возможные проблемы компьютера
issue(PC, hardware_failure) :-
    sign(PC, blue_screen),
    sign(PC, random_restarts),
    sign(PC, overheating).

issue(PC, performance_issue) :-
    sign(PC, slow_performance),
    sign(PC, high_cpu_usage).

issue(PC, network_issue) :-
    sign(PC, no_internet),
    sign(PC, network_adapter_error),
    sign(PC, wifi_disconnected).

issue(PC, boot_issue) :-
    sign(PC, boot_failure),
    sign(PC, beeping_sounds),
    sign(PC, black_screen).

% 10 различных запросов:

% 1. Поиск проблемы у конкретного компьютера
% ?- issue(pc1, Problem).

% 2. Поиск всех компьютеров, у которых есть проблемы
% ?- findall(PC, issue(PC, _), PCs).

% 3. Проверка наличия конкретного признака у компьютера
% ?- sign(pc1, blue_screen).

% 4. Поиск всех компьютеров с конкретным признаком
% ?- sign(X, wifi_disconnected).

% 5. Поиск всех компьютеров с конкретной проблемой
% ?- issue(X, hardware_failure).

% 6. Проверка, есть ли у компьютера проблема (любая)
% ?- issue(pc1, _).

% 7. Поиск всех проблем, которые могут быть у компьютера
% ?- findall(I, issue(pc1, I), List).

% 8. Поиск компьютеров с более чем одной проблемой
% ?- findall(C, (issue(C, I1), issue(C, I2), I1 \= I2), PCs).

% 9. Подсчет количества признаков у компьютера
% ?- findall(S, sign(pc1, S), List), length(List, N).

% 10. Поиск всех возможных проблем в системе
% ?- findall(I, issue(_, I), Issues).
