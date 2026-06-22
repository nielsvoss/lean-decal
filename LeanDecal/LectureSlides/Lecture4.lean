import VersoSlides
import Verso.Doc.Concrete

open VersoSlides

#doc (Slides) "Lecture 4" =>

# Quantifiers and Equality

# Review: Dependent Types

```lean -show
variable (α : Type)
variable (β : α → Type)
```

:::fragment
Let `α : Type` and `β : α → Type`.
:::

:::fragment
- {lean}`(x : α) → β x` is the dependent function type.
{fragment}[An element is a function `f` with domain `α` s.t. `f x : β x` for all `x : α`]
:::
:::fragment
- {lean}`Σ (x : α), β x` is the dependent pair type.
{fragment}[An element is a pair `(x, y)` such that `x : α` and `y : β x`]
:::

# Predicates

:::fragment
A _predicate_ is a function `P : α → Prop`.
:::

:::fragment
It assigns to every element of `α` a proposition.
:::

```lean
-- !fragment
def TwoDigit (n : Nat) : Prop :=
  10 ≤ n ∧ n ≤ 99

-- !fragment
#check TwoDigit 37
```

# Universal quantifier

:::fragment
Another way to write {lean}`(x : α) → β x` is {lean}`∀ (x : α), β x`.
:::

:::fragment
If `P : α → Prop` is a predicate, then a function `h : ∀ (x : α), P x` takes in an
element `x : α` and outputs a proof `h x : P x`.
:::

:::fragment
In other words, an element `∀ (x : α), P x` means that `P x` must be true for every
`x : α`.
:::

# Proofs with the universal quantifier

```lean -panel
example {α : Type} (P Q : α → Prop) :
  (∀ x : α, P x → Q x) → (∀ x : α, P x) → (∀ x : α, Q x) :=
  -- !fragment
  fun (h₁ : ∀ x : α, P x → Q x) (h₂ : ∀ x : α, P x) ↦
  -- !fragment
  fun (x : α) ↦
  -- !fragment
  have hx₁ : P x → Q x := h₁ x
  -- !fragment
  have hx₂ : P x := h₂ x
  -- !fragment
  show Q x from hx₁ hx₂
```

# Binary relations

A _binary relation_ is a function `P : α → β → Prop`.

```lean -panel
def FarApart (n m : Nat) : Prop :=
  n + 100 ≤ m ∨ m + 100 ≤ n

-- !fragment
-- The FarApart relation is symmetric
theorem farApart_symm {n m : Nat} :
    FarApart n m → FarApart m n :=
  -- !fragment
  -- FarApart n m is definitionally equal to
  -- n + 100 ≤ m ∨ m + 100 ≤ n
  -- !fragment
  fun (h : n + 100 ≤ m ∨ m + 100 ≤ n) ↦
  -- !fragment
  -- The goal FarApart m n is definitionally equal to
  -- m + 100 ≤ n ∨ n + 100 ≤ m
  -- !fragment
  show m + 100 ≤ n ∨ n + 100 ≤ m from or_comm.mp h

-- !fragment
theorem farApart_symm' {n m : Nat} :
    FarApart n m → FarApart m n :=
  -- !fragment
  or_comm.mp
```

# Equality

```lean -show
variable {α : Type}
variable (x y : α)
```

:::fragment
$`x = y` is shorthand for `Eq x y`.
:::

```lean -panel
-- !fragment
#check Eq

-- !fragment
#check Eq.refl
-- !fragment
#check Eq.symm
-- !fragment
#check Eq.trans
```

# Properties of equality

```lean -panel
-- !fragment
example (x : Nat) : 2 + x = 2 + x := Eq.refl (2 + x)

-- !fragment
example (x y z : Nat) (h₁ : 2 * x = y) (h₂ : 2 * z = y) :
    2 * x = 2 * z :=
  -- !fragment
  have h₃ : y = 2 * z := Eq.symm h₂
  -- !fragment
  show 2 * x = 2 * z from Eq.trans h₁ h₃
```

# Definitional equality

:::fragment
- By computation, {lean}`5` and {lean}`2 + 3` are _definitionally equal_.
:::
:::fragment
- Thus, {lean}`5 = 5` and {lean}`5 = 2 + 3` are definitionally equal.
:::
:::fragment
- `Eq.refl 5` has type `5 = 5`, so it also has type `5 = 2 + 3`.
:::
:::fragment
- Thus, `Eq.refl 5` is a valid proof of `5 = 2 + 3`.
:::

```lean -panel -stretch
-- !fragment
theorem five_eq_two_add_three : 5 = 2 + 3 := Eq.refl 5
```

# Definitional equality

:::fragment
*The principle of proof by reflexivity*: Whenever `x` and `y` are definitionally equal,
then `Eq.refl _` is a valid proof of `x = y`.
:::

# Proofs by reflexivity

:::fragment
{name}`rfl` is short for `Eq.refl _`.
:::

```lean
-- !fragment
#check rfl

-- !fragment
variable (f : Nat → Nat)

-- !fragment
example (x : Nat) : (fun n ↦ f (2 * n)) x = f (2 * x) := rfl
-- !fragment
example : f (10 + 12) = f 22 := rfl

-- !fragment
def a : Nat := 37
example : a = 37 := rfl
```

# Nat addition

:::fragment
- *Nat addition is right recursive:*
`x + 0` is defeq to `x`, but `0 + x` is not defeq to `x`.
:::

```lean +error
-- !fragment
example (x : Nat) : x + 0 = x := rfl
-- !fragment
example (x : Nat) : 0 + x = x := rfl
```

# More relations

```lean
-- !fragment
def SameLength (s t : String) : Prop :=
  s.length = t.length

-- !fragment
def DistanceOne (x y : Int) : Prop :=
  x - y = 1 ∨ y - x = 1
```

# Reflexive relations

:::fragment
A binary relation $`R(x,y)` on a set $`S` is called reflexive iff $`R(x,x)` for all $`x ∈ S`
:::

```lean -panel
-- !fragment
def IsReflexive {α : Type} (R : α → α → Prop) : Prop :=
  ∀ x : α, R x x

-- !fragment
#print SameLength

-- !fragment
theorem reflexive_sameLength : IsReflexive SameLength :=
  fun (x : String) ↦
  sorry
```

# TODO

-- TODO: Sets, filters or topology as exercise, proof irrelevance
