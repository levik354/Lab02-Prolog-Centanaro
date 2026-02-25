%Poderes de Batman
power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).
%Villanos
villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

%Solo si no hay villanos
dfs(estado([], _, _), _).
%Cuando si hay...
dfs(EstadoActual, Visitados) :-
    aplicar_poder(EstadoActual, NuevoEstado),
    \+ member(NuevoEstado, Visitados),
    dfs(NuevoEstado, [NuevoEstado|Visitados]).

aplicar_poder(
    estado(Villanos, Poderes, Energia),
    estado(NuevosVillanos, Poderes, NuevaEnergia)
) :-
    member(villain(Nombre, Vida, _), Villanos),
    member(power(_, Danio, Costo), Poderes),
    Energia >= Costo,
    Danio >= Vida,
    NuevaEnergia is Energia - Costo,
    delete(Villanos, villain(Nombre, Vida, _), NuevosVillanos).

batman_can_win(EnergiaMaxima) :-
    power_list(Superpoderes),
    villain_list(Villanos),
    % El estado inicial contiene todos los villanos, todos los poderes y la energía máxima.
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]). %dfs(Estado,Visitados)
