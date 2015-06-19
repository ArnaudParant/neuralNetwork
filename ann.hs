module ANN where

import Data.List
import System.Random

import Neuron
import Layer

type ANN = [Layer]

aux_create :: StdGen -> Int -> [Int] -> (StdGen, ANN)
aux_create gen _ [] = (gen, [])
aux_create gen last_size (layer_size:layer_sizes) =
  let (g2, layer) = Layer.create gen layer_size last_size in
  let (g3, layers) = ANN.aux_create g2 layer_size layer_sizes in
  (g3, layer:layers)

create :: StdGen -> [Int] -> (StdGen, ANN)
create gen layer_sizes = aux_create gen 1 layer_sizes

aux_ann_to_string :: ANN -> String
aux_ann_to_string [] = ""
aux_ann_to_string (layer:layers) =
  (Layer.to_string layer) ++"\n"++ (aux_ann_to_string layers)

to_string :: ANN -> String
to_string ann = "Artificial Neural Network ::\n"++ (aux_ann_to_string ann)

aux_compute :: ANN -> [Neuron.Input] -> [Float]
aux_compute [] output = output
aux_compute (layer:layers) inputs =
  let inputs_list = take (length layer) (repeat inputs) in
  aux_compute layers (Layer.map_list layer inputs_list)

compute :: ANN -> [Neuron.Input] -> [Float]
compute (layer:layers) inputs =
  aux_compute layers (Layer.map1 layer inputs)
