import System.Random

import ANN

main = do
  gen <- getStdGen
  let (g2, ann) = ANN.create gen [2, 5, 3]
  putStr (ANN.to_string ann)
  print (ANN.compute ann [0.8, 0.2])
