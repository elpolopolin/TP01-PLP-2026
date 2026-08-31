# **Trabajo Pr´actico 1 Programaci´on Funcional** 

Paradigmas ~~de Lenguajes~~ de Programaci´on 

´Unico cuatrimestre de 2026 

Fecha de entrega: 15 de Septiembre 

## **Control de circuitos el´ectricos** 

Los circuitos presentes en una edificaci´on pueden ser tan simples como una lamparita, o una compleja red de circuitos en serie y en paralelo. En nuestro caso, nos podemos encontrar con esto mismo: 

Bombilla: una simple lamparita, puede estar prendida o apagada. 

- Caja: el circuito m´as elemental que consiste ´unicamente en una caja. Puede tener una bombilla o estar vac´ıa. 

- Serie: un circuito compuesto de dos circuitos en serie. 

- Paralelo: un circuito que parte de una caja y se divide en dos circuitos que luego se vuelven a unir en otra caja. 

Se cuenta con las siguientes definiciones de tipos y expresiones: 

```
dataCaja=BombillaBool|Nada
```

```
derivingEq
```

```
dataCircuito=CajaCaja
|SerieCircuitoCircuito
|ParaleloCajaCircuitoCircuitoCaja
derivingEq
```

```
on=BombillaTrue
```

```
off=BombillaFalse
```

```
cajaOn=Cajaon
cajaOff=Cajaoff
cajaNada=CajaNada
```

Por ejemplo, el siguiente circuito 



<!-- Start of picture text -->
on<br>off<br>on on off<br>on<br>on<br>on<br>1<br><!-- End of picture text -->

se define como: 

```
Serie
```

```
(Paralelo
on
(ParalelooffcajaNadacajaOnon)
(ParaleloNadacajaOncajaOffNada)
on
)
cajaOn
```

### **Ejercicio 1** 

Definir y dar el tipo del esquema de recursi´on primitiva sobre `Circuito` . **Este es el ´unico ejercicio en el que se permite utilizar recursi´on expl´ıcita** . 

### **Ejercicio 2** 

Definir y dar el tipo del esquema de recursi´on estructural sobre `Circuito` . Se debe reutilizar el esquema definido en el ejercicio anterior. 

### **Ejercicio 3** 

Definir la funci´on `invertido :: Circuito -> Circuito` que dado un circuito describe una versi´on invertida del mismo (en la que todo el cableado cambia de direcci´on). Por ejemplo, si se le aplica la funci´on al circuito de ejemplo queda: 



<!-- Start of picture text -->
on<br>on<br>on<br>off on on<br>off<br>on<br><!-- End of picture text -->

que se define como: 

```
Serie
```

```
cajaOn
(Paralelo
on
(ParaleloNadacajaOffcajaOnNada)
(ParalelooncajaOncajaNadaoff)
on
)
```

### **Ejercicio 4** 

Definir la funci´on `hayCaminoIluminado :: Circuito -> Bool` que dado un circuito indica si en el mismo existe un camino desde la primera hasta la ´ultima caja pasando ´unicamente por cajas con bombillas encendidas. Entendemos por “camino” en un circuito una secuencia de cajas (ya sea que tengan bombilla o no) de forma que cada una est´e conectada inmediatamente a la siguiente sin haber cajas intermedias. 

2 

### **Ejercicio 5** 

Definir la funci´on `cantidadPrendidas :: Circuito -> Int` que dado un circuito describe la cantidad de luces prendidas que tiene. 

### **Ejercicio 6** 

Definir la funci´on `cajasDeCircuito :: Circuito -> [Caja]` que dado un circuito describe una lista con todas sus cajas en orden de aparici´on. En el caso de los circuitos paralelos, deben aparecer primero todas las cajas del circuito izquierdo (siguiendo el mismo orden) y luego las del derecho. Por ejemplo, si se le aplica la funci´on al circuito de ejemplo el resultado ser´ıa `[on, off, Nada, on, on, Nada, on, off, Nada, on, on]` . 

### **Ejercicio 7** 

Mientras escrib´ıamos el tp nos dimos cuenta de que un circuito con varias cajas en serie se puede representar de varias formas distintas. Por ejemplo, los circutios `Serie (Serie cajaOn cajaOff) cajaOn` y `Serie cajaOn (Serie cajaOff CajoOn)` describen el mismo circuito (que consta de 3 cajas en serie). Definir la funci´on `esCircuitoProlijo :: Circuito -> Bool` que dado un circuito indica si el mismo es prolijo. Decimos que un circuito es prolijo si para cada subcircuito que es Serie, el segundo subcircuito del mismo no es Serie. Por ejemplo, el circuito `Serie (Serie cajaOn cajaOff) cajaOn` es prolijo pero el circuito `Serie cajaOn (Serie cajaOff cajaOn)` no. La imagen de la figura 1 muestra c´omo se ver´ıan gr´aficamente los ejemplos. 



Figura 1: Ejemplos de circuitos que representan el mismo circuito. El de la izquierda es prolijo pero el de la derecha no. 

### **Ejercicio 8** 

Definir la funci´on `circuitoEmprolijado :: Circuito -> Circuito` que dado un circuito describe uno equivalente pero prolijo. Por ejemplo, si se le aplica la funci´on a `Serie cajaOn (Serie cajaOff CajoOn)` el resultado deber´ıa ser `Serie (Serie cajaOn cajaOff) cajaOn` . 

Nota: Para testear este ejercicio conviene modificar la l´ınea 18 del archivo `tp1.hs` de “show = showDeCircuito” a “show = showDeCircuitoConEstructura”. De esa forma, podr´an distinguir la estructura de los circuitos en serie (el `show` convencional de circuitos no distingue entre dos circuitos en serie con estructura distinta por lo que podr´ıa ser dif´ıcil interpretar correctamente la salida del test). 

3 

### **Ejercicio 9** 

Definir la funci´on `tienenLaMismaEstructura :: Circuito -> Circuito -> Bool` que dados dos circuitos prolijos indica si tienen la misma estructura, m´as all´a de lo que haya en las cajas. 

### **Ejercicio 10** 

Suponiendo que est´a definida la funci´on `resistenciaCircuito :: Circuito -> Float` que describe la resistencia de una caja en Ohms, definir la funci´on `subCircuitoM´asResistente :: Circuito -> Circuito` que dado un circuito describe su subcircuito m´as resistente.Tener en cuenta que todo circuito es subcircuito de s´ı mismo. 

### **Ejercicio 11** 

Demostrar la siguiente propiedad: 

```
alternado.alternado=id
```

Para este ejercicio se cuenta con las siguientes definiciones: 

```
alternado::Circuito->Circuito
{AC}alternado(Cajacaja)=Caja(cajaAlternadacaja)
{AS}alternado(Seriecicf)=Serie(alternadoci)(alternadocf)
{AP}alternado(Paralelocecicdcs)=
```

```
Paralelo(cajaAlternadace)(alternadoci)(alternadocd)(cajaAlternadacs)
```

```
cajaAlternada::Caja->Caja
{CAN}cajaAlternadaNada=Nada
{CAB}cajaAlternadaBombillabooleano=Bombillanotbooleano
```

```
(.)::(b->c)->(a->b)->a->c
{C}(f.f)x=f(fx)
```

```
id::a->a
{I}idx=x
```

```
not::Bool->Bool
{NT}notTrue=False
{NF}notFalse=True
```

Tener en cuenta que: 

Todos los pasos de la demostraci´on deben estar debidamente justificados usando las herramientas que vimos en clase. 

No se pueden asumir demostradas propiedades sobre booleanos ni enteros. 

- Se pueden definir y demostrar lemas auxiliares. 

## **Pautas de Entrega** 

Se debe entregar a trav´es del campus un ´unico archivo llamado “tp1.zip” conteniendo el c´odigo con la implementaci´on de las funciones pedidas (“TP1.hs” y “tests.hs”). Para eso, ya se encuentra disponible la entrega “TP1 - Programaci´on Funcional” en la solapa “TPs” (configurada de forma grupal para que s´olo una persona haga la entrega en nombre del grupo). El c´odigo entregado **debe** incluir tests que permitan probar las funciones definidas. El c´odigo debe poder ser ejecutado en Haskell2010. No es necesario entregar un informe sobre el trabajo, alcanza con que el c´odigo est´e 

4 

**adecuadamente** comentado (son comentarios adecuados los que ayudan a entender lo que no es evidente o explican decisiones tomadas; no son adecuadas las traducciones al castellano del c´odigo). Los objetivos a evaluar son: 

Correcci´on. 

- Declaratividad. 

- Prolijidad: evitar repetir c´odigo innecesariamente y usar adecuadamente las funciones previamente definidas (tener en cuenta tanto las funciones definidas en el enunciado como las definidas por ustedes mismos). 

- Uso adecuado de funciones de alto orden, currificaci´on y esquemas de recursi´on: Es necesario para los ejercicios que usen las funciones que vimos en clase y aquellas disponibles en la secci´on Util del campus y aprovecharlas, por ejemplo, usar zip, map, filter, take, takeWhile,<sup>´</sup> dropWhile, foldr, foldl, listas por comprensi´on, etc, cuando sea necesario y no volver a implementarlas. 

Salvo donde se indique lo contrario, **no se permite utilizar recursi´on expl´ıcita** , dado que la idea del TP es aprender a aprovechar las caracter´ısticas enumeradas en el ´ıtem anterior. Se permite utilizar listas por comprensi´on y esquemas de recursi´on definidos en el preludio de Haskell y los m´odulos `Prelude` , `List` , `Maybe` , `Data.Char` , `Data.List` , `Data.Map` , `Data.Function` , `Data.Maybe` , `Data.Ord` y `Data.Tuple` . Las sugerencias de los ejercicios pueden ayudar, pero no es obligatorio seguirlas. Pueden escribirse todas las funciones auxiliares que se requieran, pero estas no pueden usar recursi´on expl´ıcita (ni mutua, ni simulada con `fix` ). 

**Tests:** cada ejercicio debe contar con uno o m´as ejemplos que muestren que exhibe la funcionalidad solicitada. Para esto se recomienda la codificaci´on de tests usando el paquete HUnit `https://hackage.haskell.org/package/HUnit` . El esqueleto provisto incluye algunos ejemplos de c´omo utilizarlo para definir casos de test para cada ejercicio. 

Para ejecutar los tests ejecutar `ghci tests.hs` y dentro del int´erprete ejecutar `main` . 

**Importante:** Se espera que la elaboraci´on de este trabajo sea 100 % de los estudiantes del grupo que realiza la entrega. As´ı que, m´as all´a de que pueden tomar informaci´on de lo visto en las clases o consultar informaci´on en la documentaci´on de Haskell o disponible en Internet, <u>no</u> se podr´an utilizar herramientas para generar parcial o totalmente en forma autom´atica la resoluci´on del TP (e.g., chat-GPT, copilot, etc). En caso de detectarse esto, el trabajo ser´a considerado como un plagio, por lo que ser´a gestionado de la misma forma que se resuelven las copias en los parciales u otras instancias de evaluaci´on. 

## **Referencias del lenguaje Haskell** 

Como principales referencias del lenguaje de programaci´on Haskell, mencionaremos: 

- **The Haskell 2010 Language Report:** el reporte oficial de la versi´on del lenguaje Haskell al 2010, disponible online en `https://www.haskell.org/onlinereport/haskell2010` . 

- **Learn You a Haskell for Great Good!** : libro accesible, para todas las edades, cubriendo todos los aspectos del lenguaje, notoriamente ilustrado, disponible online en `https:// learnyouahaskell.com/chapters` . 

- **Real World Haskell** : libro apuntado a zanjar la brecha de aplicaci´on de Haskell, enfoc´andose principalmente en la utilizaci´on de estructuras de datos funcionales en la “vida real”, disponible online en `https://book.realworldhaskell.org/read` . 

- **Hoogle** : buscador que acepta tanto nombres de funciones y m´odulos, como signaturas y tipos _parciales_ , online en `https://www.haskell.org/hoogle` . 

5 

