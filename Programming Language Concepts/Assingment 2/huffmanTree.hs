mergHufffman::(String,Int) -> (String,Int) -> (String,Int)
mergHufffman x y =  (fst x ++ fst y, snd x + snd y)

data HTree a = Leaf a | Branch (HTree a) (HTree a) deriving Show

treeHuff::[(String,Int)] -> HTree (String,Int)
treeHuff (x:[]) = Leaf x
treeHuff (x:y:[])
        | snd x < snd y = Branch (Leaf x) (Leaf y)
        | snd x > snd y = Branch (Leaf y) (Leaf x)
treeHuff (x:y:z:list)
        | snd x > snd merged = Branch (Leaf x) (treeHuff $ sortFirst $ y:z:list)
        | otherwise = Branch (treeHuff $ y:z:[]) (treeHuff $ sortFirst $ x:list)
        where merged = mergHufffman y z 

sortFirst::[(String,Int)]->[(String,Int)]
sortFirst freq = reverse $ sortBy (comparing snd) freq

readHuffTree :: HTree (String,Int)-> String -> [(String, String)]
readHuffTree (Branch x y) code = f1 ++ f2
                          where 
                          f1 = readHuffTree x (code ++ "0")
                          f2 = readHuffTree y (code ++ "1")
readHuffTree (Leaf x) code = ((fst x, code):[])