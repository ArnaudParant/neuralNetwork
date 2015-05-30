import ANN

main = do
  ann <- ANN.make [2, 5, 3]
  putStr (ANN.to_string ann)
  print (ANN.compute ann [0.8, 0.2])
