
/-============================
Problem 1: Recursive functions
============================-/
-- Implement the following functions:

/--
The nth triangle number is the sum of the first n positive integers.
`triangleNumber 3 = 1 + 2 + 3 = 6`
-/
def triangleNumber (n : Nat) : Nat :=
  match n with
  | 0 => 0
  | m+1 => triangleNumber m + m + 1

def factorial (n : Nat) :=
  match n with
  | 0 => 1
  | (m+1) => (m+1) * factorial m

/--
The fibonacci sequence `0 1 1 2 3 5 8 13 ...`
Ex. `fibonacci 0 = 0`
Ex. `fibonacci 1 = 1`
Ex. `fibonacci 2 = 1`
Ex. `fibonacci 3 = 2`

(Note: The algorithm you implement here may be slow for large numbers due to an exponentially
increasing number of recursive calls.)
-/
def fibonacci (n : Nat) :=
  match n with
  | 0 => 0
  | 1 => 1
  | m + 2 => fibonacci m + fibonacci (m+1)

/--
Finds the largest integer `m` such that `m^2 ≤ n`.
-/
def floorSqrt (n : Nat) : Nat := sorry

/--
Applies a function `f` `n` times to an input `x`.
Ex. `iterate f 3 x = f (f (f x))`
Ex. `iterate f 0 x = x`.
-/
def iterate (f : Int → Int) (n : Nat) (x : Int) :=
  match n with
  | 0 => x
  | m+1 => f (iterate f m x)

/-
Return the sum of the largest two elements of xs.
If xs is empty, return 0, and if xs has exactly one element, return that element.
-/
def sumLargestTwo (xs : List Nat) : Nat :=
  0

def bubbleSort (xs : List Nat) : List Nat :=
  []

/-=========================
Problem 2: Maclaurin series
=========================-/
/-
Many functions such as e^x and sin(x) can be calculated using a Taylor series, which is an
infinitely large polynomial (also known as a power series). A Macluarin series is a Taylor series
centered at 0.

For example, `e^x = 1 + x + x^2/2 + x^3/6 + x^4/24 + ...`. The coefficients are
`1/0! = 1`, `1/1! = 1`, `1/2! = 1/2`, `1/3! = 1/6`, `1/4! = 1/24`, etc.

We can use this to approximate `e^x`. For example: the 3rd order Taylor approximation of e^1.5 is
`1 + 1.5 + (1.5)^2/2 + (1.5)^3/6 = 4.1875`, which is close to the true value of `e^1.5 = 4.481689`.
-/

/--
Given a polynomial encoded as list, evaluate it at x.
The polynomial `x + 4` is encoded as `[1, 4]`, so `evalPolynomial [1, 4] 10` should return `14`
The polynomial `x^2 + 4x - 6` is encoded as `[1, 4, -6]`, so `evalPolynomial [1, 4, -6] 0` should
return `-6`.

Note: You may need `Float.ofNat` if you want to raise a `Float` to the power of a `Nat`.
-/
def evalPolynomial (polynomial : List Float) (x : Float) : Float :=
  match polynomial with
  | [] => 0
  | a::as => a * x ^ (Float.ofNat as.length) + evalPolynomial as x

private def approximateExpHelper (n : Nat) : List Float :=
  match n with
  | 0 => [1]
  | m+1 => 1.0 / Float.ofNat (factorial (m + 1)) :: approximateExpHelper m

/--
Compute the nth order approximation of e^x using the Maclaurin series.
(Note the `n`th order approximation actually has `n + 1` terms).
Ex: `approximateExp 1.5 3 = 4.1875`.

Feel free to define a helper function for this.
-/
def approximateExp (x : Float) (n : Nat) : Float :=
  evalPolynomial (approximateExpHelper n) x
