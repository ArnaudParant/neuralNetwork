module Neuron where

import Data.List
import System.Random

import Maths

type Bias = Float
type Weight = Float
type Input = Float
type Neuron = ([Bias], [Weight])

rand :: Int -> IO [Float]
rand size = do
  list <- sequence (take size (repeat (getStdRandom (randomR (-0.2, 0.2)))))
  return list

create :: Int -> IO Neuron
create size = do
  biases <- rand size
  weights <- rand size
  return (biases, weights)

to_string :: Neuron -> String
to_string (biases, weights) =
  "("++ (show biases) ++" "++ (show weights) ++")"

compute_u :: Neuron -> [Input] -> Float
compute_u ([], _) _ = 0
compute_u (_, []) _ = 0
compute_u _ [] = 0
compute_u ((bias:biases), (weight:weights)) (input:inputs) =
  (bias + (weight * input)) + compute_u (biases, weights) inputs

threshold_func :: Float -> Float
threshold_func u = 1 / (1 + (Maths.e ** (-u)))

compute :: Neuron -> [Input] -> Float
compute neuron inputs = threshold_func (compute_u neuron inputs)
