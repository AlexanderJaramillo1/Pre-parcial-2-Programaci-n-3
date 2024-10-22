include "globals.mzn";
int: num_diciplinas = 4;
int: num_part = 6;
int: num_lugares = 2;

array[1..num_diciplinas] of var 1..num_part: Participantes;
array[1..num_diciplinas] of var 1..num_lugares: lugares;

array[1..num_diciplinas] of int: duracion= [2,3,1,2];
constraint alldifferent(Participantes);

array[1..num_lugares] of int: Cap_Lugares= [5,6];

array[1..num_diciplinas] of var int: Inicio;
array[1..num_diciplinas] of var int: Final;
constraint Inicio[1] = 0;
constraint forall(i in 2..num_diciplinas)(
Inicio[i] = Final[i-1]
);
constraint forall(i in 1..num_diciplinas)(
Final[i] = Inicio[i] + duracion[i]
);


constraint forall(i,j in 1..num_diciplinas   where i!=j)(
  lugares[i] = lugares[j] -> (Final[i] <= Inicio[j] \/ Final[j] <= Inicio[i])
);

constraint
  forall(l in 1..num_lugares)(
    sum(i in 1..num_diciplinas where lugares[i] == l)(duracion[i]) <= Cap_Lugares[l]
  );


var int: makespan = max([Final[i] | i in 1..num_diciplinas]);
solve minimize makespan;

output [
"Asignacion de luagres y Participantes a Disiplinas: \n",
"\t\t\t D1 D2 D3 D4\n",
"Participante asignado: \t", show(Participantes), " \n",
"Tiempos de inicio: \t", show(Inicio), " \n",
"Tiempos de fin: \t", show(Final), " \n",
"Lugar asignada: \t", show(lugares), "\n",
"Makespan (Tiempo total):", show(makespan), "\n"
];