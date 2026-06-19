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
```

# TODO

-- TODO: Sets, filters or topology as exercise, proof irrelevance
