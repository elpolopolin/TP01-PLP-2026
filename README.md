# TP01-PLP-2026


entender polo: 

Qué es recCircuito

Es el esquema de recursión primitiva sobre Circuito (ejercicio 1). La idea de un "esquema de recursión" es abstraer el patrón general de "recorrer la estructura del dato" para no tener que escribir la recursión a mano cada vez. En vez de eso, escribís una función para cada constructor del tipo, y el esquema se encarga de aplicar la recursión.

Circuito tiene tres constructores (Caja, Serie, Paralelo), así que recCircuito recibe tres funciones — una por cada uno — más el circuito a recorrer:

haskell
recCircuito :: (Caja -> a) 
            -> (a -> Circuito -> a -> Circuito -> a) 
            -> (Caja -> a -> Circuito -> a -> Circuito -> Caja -> a) 
            -> Circuito -> a
fCaja :: Caja -> a → qué hacer cuando el circuito es una caja sola (caso base, no hay recursión).
fSerie :: a -> Circuito -> a -> Circuito -> a → qué hacer cuando el circuito es un Serie.
fParalelo :: Caja -> a -> Circuito -> a -> Circuito -> Caja -> a → qué hacer cuando es un Paralelo.
Circuito -> a → el circuito de entrada, y el resultado final.
La particularidad de la recursión primitiva

A diferencia del fold (que solo te da los resultados ya calculados de las sub-partes), en recursión primitiva a cada función también le pasás el sub-circuito original, no solo el resultado de recursar sobre él. Por eso fSerie no recibe (a, a) sino (a, Circuito, a, Circuito): resultado de c1, c1 en sí, resultado de c2, c2 en sí. Eso te da más poder — podés decidir usar el resultado recursivo, o el circuito original, o ambos, según lo que necesites (por ejemplo, en invertido, en algún ejercicio te puede convenir mirar el circuito original y no solo lo ya calculado).

Línea por línea
haskell
recCircuito fCaja fSerie fParalelo circuito = case circuito of

Hacés un case sobre la forma que tiene circuito — mirás con qué constructor fue armado.

haskell
  Caja c -> fCaja c

Caso base. Si el circuito es simplemente una caja c, no hay nada que recorrer: le pasás esa caja directo a fCaja y listo.

haskell
  Serie c1 c2 -> fSerie (rec c1) c1 (rec c2) c2

Esta es la que preguntás. c1 y c2 son los dos sub-circuitos que arma el constructor Serie Circuito Circuito. Acá pasan dos cosas:

rec c1 → llamás recursivamente a recCircuito sobre c1 para conseguir su resultado ya procesado (de tipo a).
c1 (a secas) → le pasás también el circuito original, sin tocar.

Y repetís lo mismo con c2. Entonces fSerie recibe cuatro cosas en este orden: (resultado de c1) (c1 original) (resultado de c2) (c2 original) — que es justo lo que pide su tipo a -> Circuito -> a -> Circuito -> a.

haskell
  Paralelo caja1 c1 c2 caja2 -> fParalelo caja1 (rec c1) c1 (rec c2) c2 caja2

Mismo patrón, pero acá el constructor tiene 4 campos (Caja Circuito Circuito Caja), así que a fParalelo le llegan: la caja de entrada tal cual, resultado y original de c1, resultado y original de c2, y la caja de salida tal cual. Las cajas (caja1, caja2) no se recursan porque Caja no es un Circuito recursivo en este contexto — es el tipo simple Caja, hoja del árbol.

haskell
  where rec = recCircuito fCaja fSerie fParalelo

Este where es solo un atajo: en vez de escribir recCircuito fCaja fSerie fParalelo c1 cada vez, definís rec como esa misma función parcialmente aplicada, y después simplemente escribís rec c1, rec c2. Es la llamada recursiva propiamente dicha — es lo que hace que la función baje por toda la estructura del árbol hasta llegar a los casos base (Caja).

Resumen en una frase: por cada sub-circuito que aparece en un constructor, recCircuito te da tanto el resultado de haberlo procesado recursivamente como el circuito original sin procesar — a diferencia de foldCircuito, que solo te da lo primero.
