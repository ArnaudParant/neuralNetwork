module Layer where

import Data.List
import System.Random

import Neuron

type Layer = [Neuron]

create :: StdGen -> Int -> Int -> (StdGen, Layer)
create gen 0 _ = (gen, [])
create gen layer_size neuron_size =
  let (g2, n) = Neuron.create gen neuron_size in
  let (g3, ns) = Layer.create g2 (layer_size-1) neuron_size in
  (g3, n:ns)

aux_to_string :: Layer -> String
aux_to_string [] = ""
aux_to_string (neuron:layer) =
  (Neuron.to_string neuron) ++" "++ (aux_to_string layer)

to_string :: Layer -> String
to_string layer = "{"++ (aux_to_string layer) ++"}"

map_list :: Layer -> [[Neuron.Input]] -> [Float]
map_list [] _ = []
map_list _ [] = []
map_list (neuron:layer) (input:inputs) =
  (Neuron.compute neuron input):(map_list layer inputs)

map1 :: Layer -> [Neuron.Input] -> [Float]
map1 [] _ = []
map1 _ [] = []
map1 (neuron:layer) (input:inputs) =
  (Neuron.compute neuron [input]):(map1 layer inputs)