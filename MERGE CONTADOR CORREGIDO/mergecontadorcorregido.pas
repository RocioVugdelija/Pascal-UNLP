program mergecontadorcorregido;
const
  dimF=5;
  direccion_random='45 numero 555';
  fecha_random='4/6/2017';
type
    emergencia = record
         tipoE:integer;
         fecha: string;
         direccion: string;
         codCliente: integer;
    end;
    atencion= record
         tipoE:integer;
         ATot: integer;
    end;

    listaE = ^nodo1;
    nodo1 = record
         datos : emergencia;
         sig : listaE;
  end;
    listaT = ^nodo2;
    nodo2 = record
         datos : atencion;
         sig : listaT;
  end;
    vectorE= array[1..dimF] of listaE;

procedure InicializarVector(var v : vectorE);
var
  i : integer;
begin
   for i:= 1 to dimF do
       v[i] := nil;
end;
Procedure CrearListaOrdenada ( var pri: listaE; e : emergencia);
var
   ant, nue, act: listaE;
begin
  new (nue);
  nue^.datos := e;
  act := pri;
  ant := pri;
{Recorro mientras no se termine la lista y no encuentro la posicion correcta}
  while (act<>NIL) and (act^.datos.tipoE < e.tipoE) do begin
      ant := act;
      act := act^.sig ;
  end;
  if (ant = act)  then pri := nue   {el dato va al principio}
                  else  ant^.sig  := nue; {va entre otros dos o al final}
  nue^.sig := act ;
end;

Procedure AgregarAlFinal(var p, Ult: listaT; var a: atencion);
Var
nue : listaT;

begin
 new (nue);
 nue^.datos:= a;
 nue^.sig := NIL;
 if p <> Nil then
    ult^.sig := nue
 else
     p := nue;
 ult := nue;
 end;
procedure CargarInfoEmergencia( var e: emergencia);
begin
     Randomize();
  writeln('Ingrese el tipo de emergencia del 1 al 9 (0 para finalizar): ');
  readln(e.tipoE);
  //e.tipoE:=random(3);
  if(e.tipoE <>0) then begin
    //writeln('Ingrese la fecha (dd/mm/aaaa): ');
    //readln(e.fecha);
    e.fecha:=fecha_random;
    //readln();
    //Writeln('Ingrese la direccion: ');
    e.direccion:=direccion_random;
    //readln();
    //Writeln('Ingrese el codigo de cliente: ');
    //read(e.CodCliente);
    e.CodCliente:=random(5);
    //readln();
  end;
end;

Procedure CrearVectorListas (var v:vectorE);
var
   e:emergencia;
   i:integer;
begin
 writeln('entro a crear vector con listas');
 for i := 1 to dimF do
     begin
       CargarInfoEmergencia(e);
       while (e.tipoE<>0) do
          begin
           CrearListaOrdenada(v[i],e);
           CargarInfoEmergencia(e);
          end;
     end;
 writeln('vector creado');
end;

//Procedure BuscarMinimoParaListaTotal(var v:vectorE; var e: emergencia;
//var emin: integer; hayAtenciones:boolean);

Procedure BuscarMinimoParaListaTotal(var v:vectorE; var a: atencion);

var
   posMin,i: integer;
   actual:integer;
   cuenta: integer;
begin
 writeln('entro a buscar minimo');
//if ((v[1] = nil) AND (V[2] = nil)AND (V[3] = nil)AND (V[4] = nil) AND (V[5] = nil))then
//  hayAtenciones := false
//   else hayAtenciones:=true;

a.tipoE:=MAXINT;
 for i:= 1 to dimF do
    begin
       if v[i] <> nil then begin
         if(v[i]^.datos.tipoE < a.tipoE) then begin
                  a.tipoE:= V[i]^.datos.tipoE ;
                  //posMin:= i;
         end;
       end;
    end;



    // esta bien que te quedes con el m�nimo, lo que pasa es que despu�s tenes que recorrer
    //las demas listas para encontrar todas las ocurrencias de ese mismo numero
    // ahora tu minimo es tu actual, vamos a cambiarle el nombre solo para que se entienda

    actual:=a.tipoE;
    cuenta:=0;

    // aca recorremos todas las listas, por ejemplo si tu minimo es el tipo 3, el 3 tambi�n puede estar
    // en las dem�s listas, entonces buscas en las dem�s mientras el dato que tengan sea igual a ese 3
    for i:=1 to dimF do begin
        while (v[i] <> nil) and (v[i]^.datos.tipoE = actual) do begin
              cuenta:= cuenta + 1;
              v[i]:= v[i]^.sig;
       end;
    end;


 if (a.tipoE <> MAXINT) then
    a.Atot := cuenta;
end;


//procedure MergeAcumulador(var v : vectorE; var ln : listaT );
procedure MergeAcumulador( v : vectorE; var ln : listaT );
var
   aux : listaT;
   e:emergencia;
   a: atencion;
   act : integer;
   cantAt : integer;
   hayAtenciones : boolean;
   emin: integer;
begin
 aux := nil;
// BuscarMinimoParaListaTotal(v,e,emin,hayAtenciones);
  BuscarMinimoParaListaTotal(v,a);
 writeln('salio del primer buscar minimo');
// if not(hayAtenciones) then
if a.tipoE=MAXINT then
    writeln('No hay atenciones para acumular.')
else
 while(a.tipoE <> MAXINT)do begin
               agregaralfinal(ln, aux, a);
               buscarminimoparalistatotal(v,a);
 end;
end;

 {
    begin
      cantAt:= 0;
      act := e.tipoE;
      a.tipoE:= e.tipoE;
      while(act = e.tipoE)do
         begin
	   if not(hayAtenciones) then act := 0
           else begin
           CantAt := CantAt + 1;
           BuscarMinimoParaListaTotal(v,e);
           end;
         end;
           a.aTot := CantAt;
           AgregarAlFinal(ln,aux,a);
    end;
 end;
  }



{procedure Merge5(var v : vectorE; var ln : listaE );
var
   aux : listaE;
   emin : integer;
   e:emergencia;
begin
 DeterminarMinimo(v,e,emin);
 while(emin <> MAXINT) do begin
   AgregarAlFinal(ln,aux, e );
   DeterminarMinimo(v,e,emin);
 end;
end;
Procedure ImprimirListaE ( pri : listaE);
Begin
 while (pri <> NIL) do begin
   writeLn(pri^.datos.ISBM) ;
          pri:= pri^.sig;
 end;
end;}
procedure ImprimirListaNueva(pri:listaT);
begin
  while (pri <> NIL) do begin
   writeln ('Tipo de emergencia : ',pri^.datos.tipoE) ;
   writeln ('Cantidad de atenciones de este tipo : ',pri^.datos.ATot) ;
   writeln ();
   pri:= pri^.sig;
  end;
end;

procedure BuscarMin(l : listaT ;var min : integer; var datomin: integer);
begin
  if (l <> nil) then
    if(l^.datos.ATot <= min ) then begin
       min:= l^.datos.ATot;
       datomin:= l^.datos.tipoE;
       buscarMin(l^.sig,min,datomin);
    end
  else
     min := -1;
end;


procedure imprimirvectorlistas(v: vectorE);
var i:integer;
begin

for i:=1 to dimF do begin
    while v[i]<>nil do begin
        writeln('tipo:', v[i]^.datos.tipoE, 'cliente:', v[i]^.datos.CodCliente);
        v[i]:=v[i]^.sig;
    end;
end;
end;
var
  vEmerg : vectorE;
  lNueva : listaT;
  min,dmin: integer;
begin
  min:=MAXINT;
  lNueva := NIL;
  InicializarVector(vEmerg);
  CrearVectorListas(vEmerg);
  imprimirvectorlistas(vEmerg);
  MergeAcumulador(vEmerg, lNueva);
  writeln('Imprimiendo lista acumuladora: ');
  ImprimirListaNueva(lNueva);
   BuscarMin(lNueva,min,dmin);
Writeln('El tipo de emergencia con menos atenciones es el ',dmin);
  readln();
end.

