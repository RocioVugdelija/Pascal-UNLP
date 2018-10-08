program ORDENARBOL;
uses crt;
type
 lista = ^nodo1;
 nodo1 = record
         datos : integer;
       	 sig: lista;
 end;
  arbol = ^nodo;
  nodo = record
    HI : arbol;
    HD : arbol;
    dato : integer;
    end;
    listaNivel = ^nodo2;
  nodo2 = record
    sig : listaNivel;
    info : arbol;
    end;
Procedure CrearListaAgregarAdelante (var L:lista; NUM:integer);
Var nue:Lista;
Begin
     New(nue);
     nue^.datos:=num;
     nue^.sig:=L;
     L:=nue;
End;
procedure GenerarLista(var L:lista);
var
  n,i,ziEndo: integer;
begin
     randomize;
     ziEndo := 1;
     repeat
       write('Ingresar la cantidad deseada de elementos en la lista : ');
       readLn(ziEndo);
     until (ziEndo > 0);
     for i:= 1 to ziEndo do begin
       n := random(100);
       CrearListaAgregarAdelante (l,n);
     end;
     writeLn('Lista generada exitosamente.');
end;
procedure InsertarArbol(var a : arbol ;var d : integer);
var
   aux : arbol;
begin
  if (a = NIL) then begin
    new (aux);
    aux^.dato := d;
    aux^.HI := NIL;
    aux^.HD := NIL;
    a := aux;
  end
  else
      if (d < a^.dato) then         // Si el dato es menor al dato en arbol
         InsertarArbol(a^.HI,d)       // lo inserta en el hijo izquierdo
      else                            // si el dato es mayor al dato en arbol
         InsertarArbol(a^.HD,d);  // lo inserta en el hijo derecho
end;
procedure ArmarArbolito(var l : lista; var arb : arbol );
var
  aux : lista;
begin
  aux := l;
  while (aux <> NIL) do begin
          InsertarArbol(arb,aux^.datos);
          aux:= aux^.sig;
  end;
end;
Procedure ImprimirListaEnOrden (var l : lista);
var
pri : lista;
Begin
 pri := l;
 //if (pri <> nil) then writeLn(pri^.datos);
 if (pri <> NIL) then begin
   writeLn(pri^.datos);
   pri := pri^.sig;
   ImprimirListaEnOrden(pri);
 end;
end;
var
  pri : lista;
  arb : arbol;
begin
  arb := NIL;
  pri := NIL;
  textColor(30);
  GenerarLista(pri);
  writeLN('Lista en orden : ');
  ImprimirListaEnOrden(pri);
  writeLn();
  ArmarArbolito(pri,arb);
  readKey();
end.




