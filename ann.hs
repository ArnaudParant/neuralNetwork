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
create gen (first_size:layer_sizes) =
  let first = Layer.create_input first_size 1 in
  let (g2, others) = aux_create gen first_size layer_sizes in
  (g2, first:others)

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

aux_error :: [Float] -> [Float] -> Float
aux_error [] _ = 0
aux_error _ [] = 0
aux_error (output:outputs) (target:targets) =
  ((output - target) * (output - target)) + aux_error outputs targets

error :: [Float] -> [Float] -> Float
error ouputs targets =
  (aux_error ouputs targets) / 2

delta :: Float -> Float -> Float
delta output target = output * (1 - output) * (output - target)

-- aux_train :: ANN -> [Neuron.Input] -> [Float] -> ()
-- aux_train [] input target = ()
-- aux_train (layer:layers) inputs target =
--   let inputs_list = take (length layer) (repeat inputs) in
--   aux_train layers (Layer.map_list layer inputs_list)

-- train :: ANN -> [Neuron.Input] -> [Float] -> ()
-- train (layer:layers) inputs =
--     aux_train layers (Layer.map1 layer inputs)
