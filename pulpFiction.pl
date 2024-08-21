personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% Punto 1

esPeligroso(Personaje) :- 
    empleaChorros(Personaje),
    haceFechorias(Personaje).

empleaChorros(Personaje) :- 
    trabajaPara(Personaje, Empleado),
    haceFechorias(Empleado). 

haceFechorias(Personaje) :-
     esMaton(Personaje). 
    
haceFechorias(Personaje) :- 
    personaje(Personaje, ladron(Objetivos)),
    meber(licorerias, Objetivos). 

esMaton(Personaje, mafioso(maton)). 


%Punto 2

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTerrible(Personaje, Acompaniante) :- 
    sonPeligrosos(Personaje, Acompaniante),
    sonDuo(Personje, Acompaniante). 

sonPeligrosos(Personaje, Acompaniante) :- 
    esPeligroso(Personaje),
    esPeligroso(Acompaniante).

sonDuo(Personaje, Acompaniante) :-
    amigo(Personaje, Acompaniante). 

sonDuo(Personaje, Acompaniante) :- 
    pareja(Personaje, Acompaniante). 


% Punto 3

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


estaEnProblemas(Personaje) :- 
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe), 
    encargo(Jefe, Personaje, cuidar(Pareja)),
    pareja(Jefe, Pareja). 

estaProblemas(Personaje) :- 
    encargo(_, Personaje, buscar(Buscado, _))
    personaje(Buscado, boxeador). 

% Punto 4 

sanCayetano(Personaje) :- 
    tieneCerca(Personaje,_), 
    forall(tieneCerca(Personaje, Solicitante), encargo(Personaje,Solicitante,_)).

tieneCerca(Personaje, Solicitante) :- 
    amigo(Personjae, Solicitante).

tieneCerca(Personaje, Solicitante) :-
    trabajaPara(Personaje, Solicitante). 

% Punto 5

masAtareado(Personaje) :- 
    cantCargos(Personaje, Cantidad),
    forall(cantCargos(OtroPersonaje, OtraCantidadDeCargos), Cantidad > CantidadDeCargos). 

cantCargos(Personaje, CantidadDeCargos) :-
    personaje(Personaje, _), 
    findall(Encargo, encargo(Personaje, _, Encargo), CantCargos),
    length(CantCargos, CantidadDeCargos).


%Punto 6 

% nivelDeRespeto(Cargo, nivel).

nivelDeRespeto(actriz(Peliculas), NivelDeRespeto) :-
    length(Peliculas, CantPeliculas),
    NivelDeRespeto is CantPeliculas / 10. 

nivelDeRespeto(mafiosos(resuelveProblemas), 10).
nivelDeRespeto(mafiosos(maton), 1).
nivelDeRespeto(mafiosos(capo), 20).

personajesRespetables(Personajes) :-
    findall(Personaje, profesionConRespeto(Personaje), Personajes).

profesionConRespeto(Personaje, Nivel) :- 
    personaje(Personaje, Profesion),
    nivelDeRespeto(Profesion, Nivel),
    Nivel > 9.  
    

% Punto 7 

hartoDe(Personaje, OtroPersonaje) :- 
    encargo(_, Personaje, Tarea), 
    personaje(OtroPersonaje,_),
    forall(encargo(_, Personaje, Tarea), interactua(OtroPersonaje, Tarea)).

interactua(OtroPersonaje, Tarea) :-
    involucrado(Tarea, OtroPersonaje).

interactua(OtroPersonaje, Tarea) :- 
    amigo(OtroPersonaje, Otro),
    involucrado(Tarea, Otro). 

involucrado(ayudar(Personaje), Personaje).
involucrado(cuidar(Personaje), Personaje).
involucrado(buscar(Personaje,_), Personaje). 



