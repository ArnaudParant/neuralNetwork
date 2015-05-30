module Layer where

import Data.List

import Neuron

type Layer = [Neuron]

create :: Int -> Int -> IO Layer
create layer_size neuron_size = do
  layer <- sequence (take layer_size (repeat (Neuron.create neuron_size)))
  return layer

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