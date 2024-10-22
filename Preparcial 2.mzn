include "globals.mzn";
int: num_product = 5;
int: num_Estanteria = 3;

array[1..num_product] of var 1..num_Estanteria: Producto;
array[1..num_Estanteria] of int: Cap_Max_Estanteria= [8,6,5];
array[1..num_Estanteria] of var int: Cap_Actual_Estanteria;

array[1..num_product] of var int: Volumen=[4,3,5,2,1];
array[1..num_product] of var int: Tiempo=[2,5,3,1,4];

constraint forall(i in 1..(num_product - 1)) (
  if Tiempo[i] > Tiempo[i + 1] then
    Producto[i] > Producto[i + 1]
  else
    true
  endif
);

constraint forall(i in 1..num_Estanteria)(
  Cap_Actual_Estanteria[i]=sum(x in 1..num_product)(if Producto[x]== i then Volumen[x] else 0 endif)
);
constraint forall(i in 1..num_Estanteria)(
  Cap_Actual_Estanteria[i]<=Cap_Max_Estanteria[i]
);
var int: makespan= sum(i in 1..num_Estanteria)(Cap_Actual_Estanteria[i]);

solve minimize makespan;


output [
    "Estanteria de los Productos:",show(Producto),"\n",
    "Tiempo de entrega de los Productos", show(Tiempo),"\n",
    "Capacidades de Estantería: ",show(Cap_Max_Estanteria),"\n",
    "Capacidad Final de las estanterias: ",show(Cap_Actual_Estanteria),"\n",
    "Cantidad de espacio ocupado: ",show(makespan),"\n"
];