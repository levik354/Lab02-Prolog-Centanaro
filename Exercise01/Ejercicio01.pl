% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).
ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1, 2, 4).
ubicacion(piedra2, 5, 6).
ubicacion(piedra3, 8, 4).
ubicacion(piedra4, 5, 0).
ubicacion(orilla_final, 10, 5).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).

%Definir la regla siguiente_estado/2, que determine si es posible pasar de un estado
% a otro, esta puede definirse así, donde consultado ubicacion para LugarActual, 
% se obtienen las ubicaciones.
meta(pos(orilla_final)).

siguiente_estado(pos(LugarActual), pos(LugarSiguiente)) :-
    ubicacion(LugarActual, X1, Y1),
    ubicacion(LugarSiguiente, X2, Y2),
    salto_maximo(Max),
    %Distancia Euclidiana
    
    DX is X2 - X1,
    DY is Y2 - Y1,
    Distance is sqrt((DX)**2 + (DY)**2),
    Distance =< Max.

% --- REGLA DFS GENÉRICA ---
% Caso base: El estado actual es la meta.
dfs(Estado, _, [Estado]) :-
    meta(Estado).

% Caso recursivo:
dfs(EstadoActual, Visitados, [EstadoActual | CaminoRestante]) :-
    siguiente_estado(EstadoActual, SiguienteEstado),
    not(member(SiguienteEstado, Visitados)),
    dfs(SiguienteEstado, [SiguienteEstado | Visitados], CaminoRestante).

%Asi se puede iniciar la busqueda en el espacio de soluciones.
buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial),
    dfs(EstadoInicial, [EstadoInicial], Solucion). %dfs(Estado,Visitados, Solucion)
