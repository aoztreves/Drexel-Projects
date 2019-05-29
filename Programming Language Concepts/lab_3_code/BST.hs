module BST where
data Tree a = Node a (Tree a) (Tree a)
    | EmptyTree deriving (Show)

insert :: (Ord a) => a -> Tree a -> Tree a
insert elem (EmptyTree) = (Node elem (EmptyTree) (EmptyTree))
insert elem (Node a left right)
    | elem == a = (Node elem left right)
    | elem < a = (Node a (insert elem left) right)
    | elem > a = (Node a left (insert elem right))

member :: (Ord a) => a -> Tree a -> Maybe a
member x EmptyTree = Nothing
member x (Node a left right)
    | x == a = Just x
    | x < a = member x left
    | x > a = member x right    

inOrder :: (Ord a) => Tree a -> [a]
inOrder EmptyTree = []
inOrder (Node a left right) = inOrder left ++ [a] ++ inOrder right