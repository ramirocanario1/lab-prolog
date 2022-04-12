tieneCualidad(carlos,   ["buena atencion", "logistica", "fuerza"]).
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

requiere("repartir", ["fuerza"]).
requiere("repartir larga distancia", ["fuerza", "movilidad"]).
requiere("realizar logistica", ["logistica"]).
requiere("clasificar paquetes", ["disponibilidad horaria"]).
requiere("atencion al publico", ["buena atencion"]).

