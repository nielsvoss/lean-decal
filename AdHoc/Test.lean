/-
#eval 2 + 3
#eval 1 + 5 * 6
#eval 5 - 6
#eval 6 / 4
#eval 5 / 0
#eval 11 % 3
#eval "hello" ++ "world"
#eval [1,2,3].length
#eval [4,5,2].sum
-- #eval "hello" - "world"
-- #eval 2 ++ 3

#check 2
#check 4 + 5
#check "hello"
#check [1, 2, 3]

#check -2

#eval -2 - 1
#check -0
#eval -0 + 5 - 6
#check -0 + 5 - 6

#check 4.5
#eval 4.5 + 3.2

#eval (2 : Int) - 3
#eval (2 - 3 : Int)

def x : Nat := 2 + 3
#check x
#eval x
#eval x * x

def y := 6 - 7
def z := -7 + 6
-/

def f (x : Nat) : Nat := x ^ 2 + 3

#reduce f 2

def g (x : Nat) (y : Nat) : Nat := x + y + 1
def h (s : String) (n : Nat) : Nat := (String.length s) * n

def maximum (x : Nat) (y : Nat) : Nat :=
  if x < y then
    y
  else
    x

#eval maximum 5 7

def maxOf4 (a b c d : Nat) :=
  maximum (maximum (maximum a b) c) d

def smallestOnesPlace (n m : Nat) :=
  let nOnes : Nat := n % 10
  let mOnes : Nat := m % 10
  if nOnes <= mOnes then
    n
  else
    m

#eval smallestOnesPlace 42 31

def subtractOne (n : Nat) : Nat :=
  match n with
  | 0 => 0
  | m + 1 => m

#eval subtractOne 2
