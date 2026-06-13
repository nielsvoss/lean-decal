def nextRowAux (xs : List Nat) : List Nat :=
  match xs with
  | [] => []
  | x :: [] => [x]
  | x :: y :: rest => (x + y) :: nextRowAux (y :: rest)

def nextRow (xs : List Nat) : List Nat := 1 :: nextRowAux xs

def pascalsTriangleAsListsAux (n : Nat) (lastRow : List Nat) : List (List Nat) :=
  match n with
  | 0 => []
  | m+1 =>
    let next := nextRow lastRow
    next :: pascalsTriangleAsListsAux m next

def pascalsTriangleAsLists (n : Nat) : List (List Nat) := pascalsTriangleAsListsAux n []

#eval pascalsTriangleAsLists 8

def listToString (rows : List Nat) : String :=
  match rows with
  | [] => ""
  | x :: [] => toString x
  | x :: xs => toString x ++ " " ++ listToString xs

#eval listToString [1,2,3]

def listOfListsToString (rows : List (List Nat)) : String :=
  match rows with
  | [] => ""
  | row :: [] => listToString row
  | row :: remainingRows => listToString row ++ "\n" ++ listOfListsToString remainingRows

#eval listOfListsToString [[1,2,3],[4,5,6]]

def pascalsTriangle (n : Nat) : String := listOfListsToString (pascalsTriangleAsLists n)

#eval pascalsTriangle 10
#eval println! pascalsTriangle 10
