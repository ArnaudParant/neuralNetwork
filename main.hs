import Layer

main = do
  layer <- Layer.create 5 1
  putStr (Layer.to_string layer)
  print (Layer.map1 layer [0.8, 0.2, 0.4, 0.1, 0.6])
