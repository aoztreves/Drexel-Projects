type (Church a) = ((a -> a) -> (a -> a))

makeChurch :: Int -> (Church a)
makeChurch 0 = \f -> \x -> x
makeChurch n = \f -> \x -> f (makeChurch (n-1) f x)

numChurch x = (x succ) 0

showChurch x = show $ numChurch x

addChurch = \m -> \n -> \f -> \x -> m f (n f x)

multChurch = \m -> \n -> \f -> \x -> m (n f) x