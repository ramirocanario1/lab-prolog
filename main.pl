% ------------- BASE DE CONOCIMIENTO ------------- % 
tieneCualidad(carlos,   ["disponibilidad horaria", "fuerza"]).
tieneCualidad(marisa,   ["buena atencion", "fuerza"]).
tieneCualidad(juan,     ["movilidad", "disponibilidad horaria"]).
tieneCualidad(jimena,   ["logistica", "disponibilidad horaria"]).
tieneCualidad(hector,   ["logistica", "buena atencion", "fuerza"]).
tieneCualidad(betty,    ["movilidad", "buena atencion", "disponibilidad horaria"]).
tieneCualidad(lucia,    ["buena atencion"]).
tieneCualidad(axel,     ["fuerza", "movilidad"]).
tieneCualidad(eva,      ["movilidad", "logistica"]).
tieneCualidad(miguel,   ["buena atencion", "disponibilidad horaria"]).
tieneCualidad(clara,    ["fuerza"]).
tieneCualidad(luis,     ["logistica"]).

requiere("repartir",                  ["fuerza"]).
requiere("repartir larga distancia",  ["fuerza", "movilidad"]).
requiere("realizar logistica",        ["logistica"]).
requiere("clasificar paquetes",       ["disponibilidad horaria"]).
requiere("atencion al publico",       ["buena atencion"]).
% ------------- BASE DE CONOCIMIENTO ------------- %


% ------------- PRIMER ITEM ------------- %
% dado un empleado y un tipo de trabajo, verifica que el 
% empleado esté capacitado para hacerlo

verifica(Empleado, TipoTrabajo) :-
    requiere(TipoTrabajo, Requisitos),
    verificaAux(Empleado, TipoTrabajo, Requisitos).
    
verificaAux(_, _, []).
verificaAux(Empleado, TipoTrabajo, [Requisito|Requisitos]) :-
    empleadoTiene(Empleado, Requisito),
    verificaAux(Empleado, TipoTrabajo, Requisitos).

empleadoTiene(Empleado, Requisito):-
    tieneCualidad(Empleado, Cualidades),
    member(Requisito, Cualidades).
% ------------- PRIMER ITEM ------------- %


% ------------- SEGUNDO ITEM ------------- %
% dado un identificador de trabajo a realizar permite determinar la lista de 
% empleados capacitados para hacerlo.

puedenRealizar(IdTrabajo, Empleados) :-
    findall(Empleado, verifica(Empleado, IdTrabajo), Empleados). 
% ------------- SEGUNDO ITEM ------------- %


% ------------- TERCER ITEM ------------- %
% dada una lista de trabajos a realizar,
% permite obtener todas las combinaciones posibles de lista de asignaciones, donde cada
% elemento relaciona cada trabajo con un empleado que puede realizarlo, teniendo en cuenta
% sus capacidades y que se le puede asignar sólo un trabajo por vez.

asignarTrabajos(Trabajos, Asignaciones):-
    asignarTrabajosAux(Trabajos, Asignaciones, []).

asignarTrabajosAux([], [], _).
asignarTrabajosAux([Trabajo|RestoTrabajos], [a(Empleado, Trabajo)|RestoAsignaciones], EmpleadosAsignados):-
    asignarTrabajo(Trabajo, a(Empleado, Trabajo)),
    noMember(Empleado, EmpleadosAsignados),
    asignarTrabajosAux(RestoTrabajos, RestoAsignaciones, [Empleado|EmpleadosAsignados]).

asignarTrabajo(Trabajo, a(Empleado, Trabajo)):-
    verifica(Empleado, Trabajo).

noMember(Elemento, Lista):-
        member(Elemento, Lista), !, fail.
noMember(_, _).

% ------------- TERCER ITEM ------------- %
