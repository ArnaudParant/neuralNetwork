module ANN where

import Data.List

import Neuron
import Layer

type ANN = [Layer]

aux_make :: Int -> [Int] -> IO ANN
aux_make _ [] = return []
aux_make last_size (layer_size:layer_sizes) = do
  layer <- Layer.create layer_size last_size
  layers <- aux_make layer_size layer_sizes
  return (layer:layers)

make :: [Int] -> IO ANN
make layer_sizes = aux_make 1 layer_sizes

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
