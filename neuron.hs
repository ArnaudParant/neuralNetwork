module Neuron where

import Data.List
import System.Random

import Maths

type Bias = Float
type Weight = Float
type Input = Float
type Neuron = ([Bias], [Weight])

rand :: StdGen -> Int -> (StdGen, [Float])
rand gen 0 = (gen, [])
rand gen size =
  let (v, g2) = randomR (-0.2, 0.2) gen in
  let (g3, l) = rand g2 (size-1) in
  (g3, v:l)

create :: StdGen -> Int -> (StdGen, Neuron)
create gen size =
  let (g2, biases) = rand gen size in
  let (g3, weights) = rand g2 size in
  (g3, (biases, weights))

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
