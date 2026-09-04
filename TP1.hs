module TP1 where

import Data.Bool (bool)

data Caja = Bombilla Bool | Nada
  deriving (Eq)

instance Show Caja where
  show = showDeCaja

showDeCaja :: Caja -> String
showDeCaja (Bombilla True) = "💡"
showDeCaja (Bombilla False) = "⚪️"
showDeCaja (Nada) = "🛑"

data Circuito
  = Caja Caja
  | Serie Circuito Circuito
  | Paralelo Caja Circuito Circuito Caja
  deriving (Eq)

instance Show Circuito where
  show = showDeCircuito

showDeCircuito :: Circuito -> String
showDeCircuito (Caja caja) = showDeCaja caja
showDeCircuito (Serie circuitoInicial circuitoFinal) =
  (showDeCircuito circuitoInicial) ++ "-" ++ (showDeCircuito circuitoFinal)
showDeCircuito (Paralelo cajaEntrada circuitoIzquierdo circuitoDerecho cajaSalida) =
  (showDeCaja cajaEntrada)
    ++ "{"
    ++ (showDeCircuito circuitoIzquierdo)
    ++ "}"
    ++ "{"
    ++ (showDeCircuito circuitoDerecho)
    ++ "}"
    ++ (showDeCaja cajaSalida)

showDeCircuitoConEstructura :: Circuito -> String
showDeCircuitoConEstructura (Caja caja) = showDeCaja caja
showDeCircuitoConEstructura (Serie circuitoInicial circuitoFinal) =
  "("
    ++ (showDeCircuitoConEstructura circuitoInicial)
    ++ "-"
    ++ (showDeCircuitoConEstructura circuitoFinal)
    ++ ")"
showDeCircuitoConEstructura (Paralelo cajaEntrada circuitoIzquierdo circuitoDerecho cajaSalida) =
  (showDeCaja cajaEntrada)
    ++ "{"
    ++ (showDeCircuitoConEstructura circuitoIzquierdo)
    ++ "}"
    ++ "{"
    ++ (showDeCircuitoConEstructura circuitoDerecho)
    ++ "}"
    ++ (showDeCaja cajaSalida)

on = Bombilla True

off = Bombilla False

cajaOn = Caja on

cajaOff = Caja off

cajaNada = Caja Nada

-- 1: recCircuito

-- 1: recCircuito

-- recCircuito = undefined -- TODO: COMPLETAR
recCircuito :: (Caja -> a) -> (a -> Circuito -> a -> Circuito -> a) -> (Caja -> a -> Circuito -> a -> Circuito -> Caja -> a) -> Circuito -> a -- (caso base) -> (primer funcion recurisva + ELEMENTO ORIGINAL) -> (segunda funcion recursiva + ELEMENTO ORIGINAL) -> Sobre lo que trabajamos -> tipo de dato de salida
recCircuito fCaja fSerie fParalelo circuito = case circuito of
  Caja c -> fCaja c
  Serie c1 c2 -> fSerie (rec c1) c1 (rec c2) c2 -- Tiene que tener paso recursivo, con c1 y c2 lo que hacemos es pasarle el circuito original ya que es una caracteristica de la recursion primitiva
  Paralelo caja1 c1 c2 caja2 -> fParalelo caja1 (rec c1) c1 (rec c2) c2 caja2 -- Tiene que tener paso recursivo, con c1 y c2 lo que hacemos es pasarle el circuito original ya que es una caracteristica de la recursion primitiva
  where
    rec = recCircuito fCaja fSerie fParalelo

-- 2: foldCircuito

-- foldCircuito = undefined -- TODO: COMPLETAR

{-foldCircuito :: (Caja -> a) -> (a -> a -> a) -> (Caja -> a -> a -> Caja -> a) -> Circuito -> a -- (caso base) -> (primer funcion recurisva) -> (segunda funcion recursiva) -> Sobre lo que trabajamos -> tipo de dato de salida
foldCircuito fCaja fSerie fParalelo circuito = case circuito of
  Caja c = fCaja c
  Serie c1 c2 = fSerie (rec c1) (rec c2)                                 --Tiene que tener paso recursivo
  Paralelo caja1 c1 c2 caja2 = fParalelo caja1 (rec c1) (rec c2) caja2       --Tiene que tener paso recursivo
  where rec = foldCircuito fCaja fSerie fParalelo -- PREGUNTAR SI CON ESQUEMA SIMILAR SE REFIERE A ESTA MISMA FORMA, no se termina de comprender si quieren que usemos recCircuito aca, pero no tiene mucho sentido eso
-}
foldCircuito :: (Caja -> a) -> (a -> a -> a) -> (Caja -> a -> a -> Caja -> a) -> Circuito -> a
foldCircuito fCaja fSerie fParalelo circuito = recCircuito (fCaja) (\res1 c1 res2 c2 -> fSerie res1 res2) (\ca1 res1 c1 res2 c2 ca2 -> fParalelo ca1 res1 res2 ca2) (circuito)

-- 3 invertido

-- invertido = undefined -- TODO: COMPLETAR
invertido :: Circuito -> Circuito
invertido = foldCircuito (Caja) (\x y -> Serie y x) (\ca1 a b ca2 -> Paralelo ca2 b a ca1)

-- 4: hayCaminoIluminado

hayCaminoIluminado :: Circuito -> Bool
hayCaminoIluminado = foldCircuito (\caja -> if caja == on then True else False) (\circuito1 circuito2 -> circuito1 && circuito2) (\caja1 circuito1 circuito2 caja2 -> caja1 == on && (circuito1 || circuito2) && caja2 == on)

-- c1 = caja1 c2=caja2
-- 5: cantidadPrendidas

cantidadPrendidas :: Circuito -> Int
cantidadPrendidas = foldCircuito (\caja -> if caja == on then 1 else 0) (\circuito1 circuito2 -> circuito1 + circuito2) ((\caja1 circ1 circ2 caja2 -> (if caja1 == on then 1 else 0) + circ1 + circ2 + (if caja2 == on then 1 else 0))) -- foldr

-- 6: cajasDeCircuito
cajasDeCircuito :: Circuito -> [Caja]
cajasDeCircuito = foldCircuito (\caja -> caja : []) (\circuito1 circuito2 -> circuito1 ++ circuito2) (\caja1 circuito1 circuito2 caja2 -> (caja1 : []) ++ circuito1 ++ circuito2 ++ (caja2 : []))

-- 7 :
esCircuitoProlijo :: Circuito -> Bool
esCircuitoProlijo = recCircuito (\x -> True) (\res1 c1 res2 c2 -> res1 && res2 && (case c2 of Serie _ _ -> False; _ -> True)) (\caja1 res1 c1 res2 c2 caja2 -> res1 && res2)

-- 9:

tienenLaMismaEstructura :: Circuito -> Circuito -> Bool
tienenLaMismaEstructura c1 c2 =
  ( foldCircuito
      ( \caja -> \otro ->
          case otro of
            Caja _ -> True
            _ -> False
      )
      ( \rec1 rec2 -> \otro ->
          case otro of
            Serie otro1 otro2 ->
              rec1 otro1 && rec2 otro2
            _ -> False
      )
      ( \caja1 rec1 rec2 caja2 -> \otro ->
          case otro of
            Paralelo _ otro1 otro2 _ ->
              rec1 otro1 && rec2 otro2
            _ -> False
      )
      c1
  )
    c2

-- 10: subCircuitoMásResistente

-- subCircuitoMásResistente = undefined -- TODO: COMPLETAR

-- resistenciaCircuito :: Circuito -> Float

subCircuitoMasResistente :: Circuito -> Circuito
subCircuitoMasResistente = recCircuito (\x -> Caja x) (\rec1 c1 rec2 c2 -> mejor (Serie c1 c2) ((mejor rec1 rec2))) (\caja1 rec1 c1 rec2 c2 caja2 -> mejor (mejor rec1 rec2) (Paralelo caja1 c1 c2 caja2))
  where
    mejor a b =
      if resistenciaCircuito a >= resistenciaCircuito b
        then a
        else b

{-- 11: Demostrar: alternado . alternado = id

alternado :: Circuito -> Circuito
{AC} alternado (Caja caja) = Caja (cajaAlternada caja)
{AS} alternado (Serie ci cf) = Serie (alternado ci) (alternado cf)
{AP} alternado (Paralelo ce ci cd cs) =
       Paralelo (cajaAlternada ce) (alternado ci) (alternado cd) (cajaAlternada cs)

cajaAlternada :: Caja -> Caja
{CAN} cajaAlternada Nada = Nada
{CAB} cajaAlternada Bombilla booleano = Bombilla not booleano

(.) :: (b -> c) -> (a -> b) -> a -> c
{C} (f . f) x = f (f x)

id :: a -> a
{I} id x = x

not :: Bool -> Bool
{NT} not True = False
{NF} not False = True

-- TODO: COMPLETAR

--}
