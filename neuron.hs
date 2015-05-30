module Neuron where

import Data.List
import System.Random

import Maths

type Bias = Float
type Weight = Float
type Input = Float
type T = ([Bias], [Weight])

rand :: Int -> IO [Float]
rand size = do
  list <- sequence (take size (repeat (getStdRandom (randomR (-0.2, 0.2)))))
  return list

create :: Int -> IO T
create size = do
  biases <- rand size
  weights <- rand size
  return (biases, weights)

to_string :: T -> String
to_string (biases, weights) =
  let str_biases = show biases in
  let str_weights = show weights in
  "Neuron :: "++ str_biases ++" "++ str_weights

compute_u :: T -> [Input] -> Float
compute_u ([], _) _ = 0
compute_u (_, []) _ = 0
compute_u _ [] = 0
compute_u ((bias:biases), (weight:weights)) (input:inputs) =
  (bias + (weight * input)) + compute_u (biases, weights) inputs

threshold_func :: Float -> Float
threshold_func u = 1 / (1 + (Maths.e * (-u)))

compute :: T -> [Input] -> Float
compute neuron inputs = threshold_func (compute_u neuron inputs)
