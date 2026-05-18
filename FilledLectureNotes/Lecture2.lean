-- Example 1:
section Example1

#check Nat × Nat × Nat

def NProd (α : Type) (n : Nat) :=
  match n with
  | 0 => Unit
  | m+1 => α × NProd α m

def x : NProd String 3 := ("the", "quick", "brown", ())
def y : NProd Nat 4 := (1, 2, 3, 4, ())

def factorial (n : Nat) : Nat :=
  match n with
  | 0 => 1
  | m+1 => n * factorial m

def a : NProd Nat (factorial 3) := (1, 2, 3, 4, 5, 6, ())
-- def b : NProd Nat (factorial 4) := (1, 2, 3, 4, 5, 6, ())

end Example1

section Example2

def SuperList (α : Type) (n : Nat) :=
  match n with
  | 0 => α
  | m+1 => List (SuperList α m)

def xs : SuperList String 1 := ["a", "b", "c"]
def ys : SuperList String 2 := [["a", "b", "c"], ["d", "e", "f"]]
def zs : SuperList String (factorial 3) := [[[[[["a"]]]]]]

def addLevel (α : Type) (n : Nat) (xs : SuperList α n) : SuperList α (n + 1) :=
  [xs]

#eval addLevel String 2 (addLevel String 1 xs)

def map {α : Type} (f : α → α) (xs : List α) :=
  match xs with
  | [] => []
  | x :: rest => f x :: map f rest

#eval map (fun x ↦ x + 1) [1, 2, 3]

def superMap {α : Type} {n : Nat} (f : α → α) (xs : SuperList α n) : SuperList α n :=
  match n with
  | 0 => f xs
  | _+1 => map (superMap f) xs

end Example2
