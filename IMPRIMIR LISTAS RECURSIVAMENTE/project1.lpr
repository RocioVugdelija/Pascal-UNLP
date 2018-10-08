program project1;
Type
 lista = ^nodo;
 nodo = record
         datos: integer;
       	 sig: lista;
 end;

Procedure CrearListaAgregarAtras(var L, Ult: lista; per:integer);
Var
nue : lista;
begin
 new (nue);
 nue^.datos:= per;
 nue^.sig := NIL;
 if l <> Nil then
    ult^.sig := nue
 else
     l := nue;
 ult := nue;
end;
procedure CargarDatos(var l:lista);
var
n : integer;
ult : lista;
begin
 ult := NIL;
 write('Ingresar un numero entero : ');
 readLn(n);
 while (n <> 0)do begin
   CrearListaAgregarAtras(l,ult,n);
   write('Ingresar un numero entero : ');
   readLn(n);
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
Procedure ImprimirListaEnOrdenInverso ( pri : lista);
var
aux : lista;
Begin
 if (pri <> NIL) then begin
   pri := pri^.sig;
   ImprimirListaEnOrdenInverso(pri);
   if (pri <> NIL) then writeLn (pri^.datos) ;
 end;
end;
var
l : lista;
begin
  l := NIL;
  CargarDatos(l);
  WriteLn('Lista en orden ');
  ImprimirListaEnOrden(l);
  WriteLn('Lista en orden INVERSO ');
  ImprimirListaEnOrdenInverso(l);
  if (l<> NIL)then writeLn(l^.datos);
  readLn();
end.


