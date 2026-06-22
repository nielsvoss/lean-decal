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
Let `P : α → Prop` be a predicate.
:::

:::fragment
A function `h : ∀ (x : α), P x` takes in an
element `x : α` and outputs a proof `h x : P x`.
:::

:::fragment
In other words, an element `∀ (x : α), P x` means that `P x` must be true for every
`x : α`.
:::

# Proofs with the universal quantifier

```lean -panel
-- !fragment
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

:::fragment
A _binary relation_ is a function `P : α → β → Prop`.
:::

```lean -panel
-- !fragment
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

:::fragment
`x = y` is shorthand for `Eq x y`.
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

```lean -panel -stretch
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

::::attr (style := "font-size: 0.6em")
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
::::

```lean -panel -stretch
-- !fragment
theorem five_eq_two_add_three : 5 = 2 + 3 := Eq.refl 5
```

# Proof by reflexivity

:::fragment
*The principle of proof by reflexivity*: Whenever `x` and `y` are definitionally equal,
then `Eq.refl _` is a valid proof of `x = y`.
:::

:::fragment
{name}`rfl` is short for `Eq.refl _`.
:::

# Proofs by reflexivity

```lean -panel
-- !fragment
#check rfl

-- !fragment
example : 2 * 100 = 200 := rfl
-- !fragment
example : [3, 4] ++ [5, 6] = [3, 4, 5, 6] := rfl

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

```lean +error -panel -stretch
-- !fragment
example (x : Nat) : x + 0 = x := rfl
-- !fragment
example (x : Nat) : 0 + x = x := rfl
```

# Substitution

::::attr (style := "font-size: 0.6em")
:::fragment
Let `P` be a predicate.
:::

:::fragment
*Substitution property of equality*:
If `P x` and `x = y`, then `P y`.
:::

:::fragment
`P` is called the _motive_.
:::
::::

```lean -panel -stretch
-- !fragment
#check Eq.subst

-- !fragment
example (α : Type) (a b : α) (p : α → Prop)
        (h1 : a = b) (h2 : p a) : p b :=
  Eq.subst h1 h2

-- !fragment
example (α : Type) (a b : α) (p : α → Prop)
    (h1 : a = b) (h2 : p a) : p b :=
  h1 ▸ h2
```

# Congruence

:::fragment
*Theorem (Congruence on the argument):*
Let $`f : A \to B` and $`x, y \in A`. Then $`f(x) = f(y)`.
:::

```lean -panel
-- !fragment
theorem congruence {α β : Type} (f : α → β) (x y : α)
    : x = y → f x = f y :=
  -- !fragment
  fun (h : x = y) ↦
  -- !fragment
  let P : α → Prop := fun a ↦ f x = f a
  -- !fragment
  have hx : P x := show f x = f x from rfl
  -- !fragment
  show f x = f y from Eq.subst (motive := P) h hx
```

# Congruence

```lean -panel
-- !fragment
#check congrArg -- We just proved this
-- !fragment
#check congrFun
-- !fragment
#check congr

-- !fragment
variable (α : Type)
variable (a b : α)
variable (f g : α → Nat)
variable (h₁ : a = b)
variable (h₂ : f = g)

-- !fragment
example : f a = f b := congrArg f h₁
-- !fragment
example : f a = g a := congrFun h₂ a
-- !fragment
example : f a = g b := congr h₂ h₁
```

# Calc mode

```lean +panel
-- !fragment
variable (α : Type) (a b c d : α)
  (h₁ : a = b) (h₂ : b = c) (h₃ : c = d)

-- !fragment
example : a = d :=
-- !fragment
  Eq.trans h₁ (Eq.trans h₂ h₃)

-- !fragment
example : a = d :=
  calc
    a = b := h₁
    _ = c := h₂
    _ = d := h₃
```

# Another example

In-class example: Rewrite the following using calc mode
```lean -panel -stretch
variable (a b c d e : Nat)

theorem T
    (h1 : a = b)
    (h2 : b = c + 1)
    (h3 : c = d)
    (h4 : e = 1 + d) :
    a = e :=
  have q₁ : c + 1 = d + 1 := congrArg (fun n ↦ n + 1) h3
  have q₂ : d + 1 = 1 + d := Nat.add_comm d 1
  have q₃ : 1 + d = e := Eq.symm h4
  Eq.trans h1 (Eq.trans h2 (Eq.trans q₁ (Eq.trans q₂ q₃)))
```

# The existential quantifier

:::fragment
Fix a predicate `P : α → Prop`.
:::

:::fragment
Then `Exists P` (also written `∃ (x : α), P x`) means that there is at least one
element `x : α` such that `P x` is true.
:::

:::fragment
It consists of a tuple `⟨x, hx⟩` where `x` is an element of `α` and `hx` is a proof of `P x`.
:::

:::fragment
_Note: This behaves similarly to (but is distinct from) the sum type `∑ (x : α), β x`_
:::

# Exists

```lean -panel +stretch
-- !fragment
#check Exists

-- !fragment
#check Exists.intro
-- !fragment
#check Exists.elim
```

# TODO

-- TODO: Sets, filters or topology or graphs as exercise, proof irrelevance
