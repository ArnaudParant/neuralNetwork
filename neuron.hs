module Neuron where

import Data.List
import System.Random

type Bias = Float
type Weight = Float
type Input = Float
type T = ([Bias], [Weight])

rand :: Int -> IO [Float]
rand size = do
  list <- sequence (take size (repeat (getStdRandom (randomR (-1, 1)))))
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

  -- Compute without threshold
simple_compute :: [Bias] -> [Weight] -> [Input] -> Float
simple_compute [] _ _ = 0
simple_compute _ [] _ = 0
simple_compute _ _ [] = 0
simple_compute (bias:biases) (weight:weights) (input:inputs) =
  (bias + (weight * input)) + simple_compute biases weights inputs

compute :: T -> [Input] -> Float
compute (biases, weights) inputs =
  let res = simple_compute biases weights inputs in
  if res >= 0 then res else 0
