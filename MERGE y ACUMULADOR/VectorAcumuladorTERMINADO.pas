program VectorAcumuladorTERMINADO;
const
  dimF=2;
type
    gastosInd = record
      tipoConsumo : integer;
      fecha : string[11];
      Monto : real;
    end;
    gastosTot = record
      tipoConsumo : integer;
      Monto : real;
    end;
 //Creamos la lista gastoIND
    listaI = ^nodoI;
    nodoI = record
         datos : gastosInd;
         sig : listaI;
    end;
     //Creamos la lista gastoTOT
    listaT = ^nodoT;
    nodoT = record
         datos : gastosTot;
         sig : listaT;
    end;
     vectorlistasI= array[1..dimF] of listaI;
procedure InicializarVector(var v : vectorlistasI);
var
  i : integer;
begin
   for i:= 1 to dimF do
       v[i] := NIL;
end;
   Procedure CrearListaOrdenada ( var pri: listaI; g: gastosInd);
   var
      ant, nue, act: listaI;
   begin
     new (nue);
     nue^.datos := g;
     act := pri;
     ant := pri;
   {Recorro mientras no se termine la lista y no encuentro la posicion correcta}
     while (act<>NIL) and (act^.datos.tipoConsumo< g.tipoConsumo) do
         begin
           ant := act;
           act := act^.sig ;
         end;
     if (ant = act)  then pri := nue   {el dato va al principio}
                     else  ant^.sig  := nue; {va entre otros dos o al final}
     nue^.sig := act ;
   end;
Procedure AgregarAlFinal(var p, Ult: listaT; var g: gastosTot );
Var
nue : listaT;
begin
 new (nue);
 nue^.datos:= g;
 nue^.sig := NIL;
 if p <> Nil then
    ult^.sig := nue
 else
     p := nue;
 ult := nue;
end;
procedure CargarGastos(var g:gastosInd);
begin
 //Randomize;
 //g.tipoConsumo := random(6);
 writeLn('Ingresar tipo de consumo (0 para finalizar esta lista)');
 readLn(g.tipoConsumo);
 if (g.tipoConsumo <> 0) then begin
   write('Ingresar fecha : ');
   readln(g.fecha);
   write('Ingresar monto : ');
   readln(g.Monto);
 end;
end;

Procedure CrearVectorListas (var v: vectorlistasI);
var
   g : gastosInd;
   i : integer;
begin

       for i:= 1 to dimf do
       begin
         Writeln('Cargando lista ', i);
         writeln(' ');
         CargarGastos(g);
         while (g.tipoConsumo <> 0) do
           begin
             CrearListaOrdenada(v[i],g);
             CargarGastos(g);
           end;
       end;


end;
procedure DeterminarMinimo(var v: vectorlistasI; var g:gastosInd;
                      var posmin:integer;var hayConsumos:boolean);
var
   min, i: integer;
Begin
 if ((v[1] = nil) AND (V[2] = nil)) then hayconsumos := false
     else hayconsumos:=true;
 min := MAXINT;
 posmin := 999;
 for i:= 1 to dimF do
    begin
       if v[i] <> nil then begin
         if(v[i]^.datos.tipoConsumo <= min) then begin
                  min:= V[i]^.datos.tipoConsumo ;
                  posMin:= i;
         end;
       end;
    end;
 if (posmin <> 999) then begin
    g := v[posmin]^.datos;
 end;
 if (v[posmin] <> nil) then begin
    v[posmin] := v[posmin]^.sig;      //reacomodo de lista
 end
 else

end;
procedure MergeAcumulador(var v : vectorListasI; var ln : listaT );
var
   aux : listaT;
   posmin : integer;
   g : gastosInd;
   gt : gastosTot;
   act : integer;
   montoTot,montoConsumoAct : real;
   hayConsumos : boolean;
begin
 aux := nil;
 montoTot := 0;
 DeterminarMinimo(v,g,posmin,hayConsumos);
 if not(hayConsumos) then
    writeln('No hay gastos para acumular.');
 while(HayConsumos)do
    begin
      montoConsumoAct := 0;
      act := g.tipoConsumo;
      gt.tipoConsumo:= g.tipoConsumo;
      while(act = g.tipoConsumo)do
         begin
	   if not(hayConsumos) then act := 0
           else begin
           montoConsumoAct := montoConsumoAct + g.Monto;
           DeterminarMinimo(v,g,posmin,hayConsumos);
           end;
         end;
           gt.Monto := montoConsumoAct;
           AgregarAlFinal(ln,aux,gt);
    end;
 end;
procedure ImprimirListaNueva(pri:listaT);
begin
  while (pri <> NIL) do begin
   writeln ('Monto : ',pri^.datos.Monto:5:2) ;
   writeln ('Tipo de consumo : ',pri^.datos.tipoConsumo) ;
   writeln ();
   pri:= pri^.sig;
  end;
end;
procedure ImprimirListaIndividual(pri:listaI);
begin
  if (pri=NIL) then
   writeln('No hay lista');
  while (pri <> NIL) do begin
   writeln ('Monto : ',pri^.datos.Monto:5:2) ;
   writeln ('Tipo de consumo : ',pri^.datos.tipoConsumo) ;
   writeln ('Fecha :', pri^.datos.fecha);
   writeln ();
   pri:= pri^.sig;
  end;
end;
Procedure Imprimir2Listas(v:vectorListasI);
var
   i : integer;
begin
 writeLn(' ');
 writeln('Imprimiendo listas de gastos sin acumular...');
 writeLn(' ');
 for i:=1 to dimF do begin
   writeln ('Imprimiendo lista ', i, ' : ');
   ImprimirListaIndividual(v[i]);
   writeLn('Lista ', i, ' impresa...');
   writeLn(' ');
 end;
end;
var
   lt : listaT;
   v : vectorListasI;
begin
  lt := NIL;
  InicializarVector(v);
  CrearVectorListas(v);
  Imprimir2Listas(v);
  writeLn(' ');
  MergeAcumulador(v,lt);
  writeLn(' ');
  writeLn('Imprimiendo Lista Nueva de gastos acumulados...');
  writeLn(' ');
  ImprimirListaNueva(lt);
  writeLn('Lista de gastos acumulados impresa...');
  writeLn(' ');
  readLn();
end.
