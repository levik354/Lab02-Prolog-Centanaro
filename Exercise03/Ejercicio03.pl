dfs(Estado, _, Estado) :-
    length(Estado, 8).


dfs(EstadoActual, Visitados, SolucionFinal) :-
    sucesor(EstadoActual, NuevoEstado),
    \+ member(NuevoEstado, Visitados),
    dfs(NuevoEstado, [NuevoEstado|Visitados], SolucionFinal).

sucesor(EstadoActual, NuevoEstado) :-
    length(EstadoActual, ColumnaActual),
    ColumnaSiguiente is ColumnaActual + 1,
    between(1, 8, Fila),
    seguro(Fila, ColumnaSiguiente, EstadoActual),
    append(EstadoActual, [Fila], NuevoEstado).


seguro(_, _, []).

seguro(Fila, Columna, EstadoActual) :-
    verificar(Fila, Columna, EstadoActual, 1).

verificar(_, _, [], _).

verificar(Fila, Columna, [FilaExistente|Resto], ColumnaExistente) :-
    Fila =\= FilaExistente,
    abs(Fila - FilaExistente) =\= abs(Columna - ColumnaExistente),
    SiguienteColumna is ColumnaExistente + 1,
    verificar(Fila, Columna, Resto, SiguienteColumna).

solucion(Solucion) :-
    EstadoInicial = [],
    dfs(EstadoInicial, [EstadoInicial], Solucion).
