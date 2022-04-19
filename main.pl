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
empleadoTiene(Empleado, Requisito):-
    tieneCualidad(Empleado, Cualidades),
    member(Requisito, Cualidades).

% dado un empleado y un tipo de trabajo, verifica que el empleado esté capacitado para hacerlo
verifica(_, _, []). % TODO: realmente es necesario?
verifica(Empleado, TipoTrabajo, [Requisito|Requisitos]) :-
    empleadoTiene(Empleado, Requisito),
    verifica(Empleado, TipoTrabajo, Requisitos).  % TODO: se podría mejorar la solución para no repetir estas dos líneas?
verifica(Empleado, TipoTrabajo) :-
    requiere(TipoTrabajo, [Requisito|Requisitos]),
    empleadoTiene(Empleado, Requisito),
    verifica(Empleado, TipoTrabajo, Requisitos).
% ------------- PRIMER ITEM ------------- %


% ------------- SEGUNDO ITEM ------------- %
% dado un identificador de trabajo a realizar permite determinar la lista de empleados capacitados para hacerlo.
puedenRealizar(IdTrabajo, Empleados) :-
    findall(Empleado, verifica(Empleado, IdTrabajo), Empleados). 
% ------------- SEGUNDO ITEM ------------- %


% ------------- TERCER ITEM ------------- %
% dada una lista de trabajos a realizar,
% permite obtener todas las combinaciones posibles de lista de asignaciones, donde cada
% elemento relaciona cada trabajo con un empleado que puede realizarlo, teniendo en cuenta
% sus capacidades y que se le puede asignar sólo un trabajo por vez.
% asignarTrabajos([], [], []).
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


% ------------- CUARTO ITEM ------------- %
% tal que dada una lista de trabajos grupales a realizar, donde cada uno determina además la
% cantidad de empleados requeridos para su realización, permite obtener todas las combinaciones
% posibles de la lista de grupos asignados. Cada elemento de la lista de grupos asignados relaciona
% cada trabajo con los empleados que pueden realizarlo teniendo en cuenta sus capacidades, que se
% le puede asignar sólo un trabajo por vez a cada empleado, y que se debe contar con la cantidad
% de empleados necesaria. La lista de trabajos a rechazar determina los trabajos que no sería
% posible realizar.

asignarTrabajosGrupales(TrabajosGrupales, GruposAsignados, TrabajosARechazar):-


% ------------- CUARTO ITEM ------------- %