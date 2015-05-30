import Neuron

main = do
  neuron <- Neuron.create 2
  print (Neuron.to_string neuron)
  print (Neuron.compute neuron [1, 1])
