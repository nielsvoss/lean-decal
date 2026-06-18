import VersoSlides
import Verso.Doc.Concrete
import Mathlib.NumberTheory.LSeries.RiemannZeta

open VersoSlides

set_option verso.slides.panel false
set_option linter.hashCommand false
set_option linter.style.emptyLine false

#doc (Slides) "Lecture 3" =>

# Lecture 3: The Curry-Howard Correspondence

# Overview

Today's lecture is all about the {lean}`Prop` type.

{lean}`Prop` is the type of *propositions*, which are mathematical statements that can be true or
false.

Unlike {name}`Bool`, given a {lean}`Prop` we don't always know if it is true or false.

# Decidable Propositions

:::attr (style := "font-size: 0.6em")

Some propositions are _decidable_, which means that Lean can automatically convert them into a
{name}`Bool`.

Recall that {name}`True` and {name}`False` are propositions, while {name}`true` and {name}`false`
are booleans.

```lean -stretch
#eval (True : Bool)
#eval (False ∧ True : Bool)
```

This fails for propositions that are not decidable:
```lean +error -stretch
#check (RiemannHypothesis : Bool)
```
:::

# Representing proofs

```lean -show
opaque Proof : Prop → Type
set_option linter.unusedVariables false in
opaque Implies (a b : Prop) : Prop
opaque p : Prop
opaque q : Prop
```

:::attr (style := "font-size: 0.6em")
In Lean, _proofs are mathematical objects_.
This means you can have functions that take in proofs and ouptut proofs.

One design decision that lean _could_ have made is to have a new type, `Proof p`, which is the type
of proofs of the proposition `p`.

```lean -stretch
#check Proof
```
_Important: {name}`Proof` is not a real thing in Lean, we're just using it as an example._
:::

# Representing proofs

:::attr (style := "font-size: 0.6em")
We can then use {lean}`And p q`, {lean}`Or p q`, {lean}`Not p`, and {lean}`Implies p q` to build
compound propositions.
```lean -stretch
-- !fragment
#check And
-- !fragment
#check Or
-- !fragment
#check Not
-- !fragment
#check Implies
```
_Important: This is still hypothetical, not how Lean actually works._
:::

# And introduction rule

:::attr (style := "font-size: 0.7em")
In normal logic, the following is true:

> From a proof of $`p` and a proof of $`q`, we can obtain a proof of $`p \land q`.

We can represent this in Lean as follows:

```lean -stretch
axiom and_intro {p q : Prop} :
  Proof p → Proof q → Proof (And p q)
```
_The `axiom` keyword in Lean is like `def` but you don't need to provide a value._
:::

# Modus ponens

:::attr (style := "font-size: 0.7em")
The principle of modus ponens states:

> From a proof of $`p \Rightarrow q` and a proof of $`p`, we can obtain a proof of $`q`.

Representing this in Lean:
```lean -stretch
-- !fragment
axiom modus_ponens {p q : Prop} :
  Proof (Implies p q) → Proof p → Proof q
```
:::

# Our first proof

:::attr (style := "font-size: 0.7em")
Our first theorem:
> If $`p \Rightarrow q` and $`p \Rightarrow r` and $`p`, then $`q \land r`.
:::

```lean -show
noncomputable section
```
```lean -stretch
-- !fragment
def my_first_proof (p q r : Prop) :
    Proof (Implies p q) → Proof (Implies p r)
    → Proof p → Proof (And q r) :=
-- !fragment
  fun h₁ h₂ h₃ ↦
-- !fragment
    and_intro
-- !fragment
      (modus_ponens h₁ h₃)
-- !fragment
      (modus_ponens h₂ h₃)
```

# More axioms of logic

The deduction theorem:
> Suppose that from a proof of $`p` we can derive a proof of $`q`.
  Then we can get a proof of $`p \Rightarrow q`.
```lean -stretch
-- !fragment
axiom implies_intro {p q : Prop} :
  (Proof p → Proof q) → Proof (Implies p q)
```

# Another proof

Another theorem:
> If $`p \Rightarrow q` and $`q \Rightarrow r`, then $`p \Rightarrow r`.
```lean -stretch
-- !fragment
def my_second_proof (p q r : Prop) :
    Proof (Implies p q) → Proof (Implies q r)
    → Proof (Implies p r) :=
-- !fragment
  fun h₁ h₂ ↦
-- !fragment
    implies_intro
-- !fragment
      (fun (hp : Proof p) ↦
-- !fragment
        modus_ponens h₂/- !fragment
        -/ (modus_ponens h₁ hp)/- !end fragment -/)
```

# Simplifying the logical system

Lean doesn't actually have {lean}`Proof`.

:::fragment
> Simplfication #1: Write {lean}`p` instead of {lean}`Proof p`.
:::

:::fragment
Whenever `p : Prop`, then `p` is the _type of its own proofs_.
:::

:::fragment
Thus, `t : p` means that `t` is a proof of `p`.
:::

# Simplfying the logical system

:::::attr (style := "font-size: 0.65em")
With `Proof` gone, now our axioms look like:
:::::

```lean -show
namespace Hidden
```
```lean -stretch
axiom modus_ponens {p q : Prop} : (Implies p q) → /-
  !fragment 2 -/(/- !end fragment -/p → q/-
  !fragment 2 -/)/- !end fragment -/
axiom implies_intro {p q : Prop} : (p → q) → (Implies p q)
```
```lean -show
end Hidden
```

:::::attr (style := "font-size: 0.65em")
:::fragment (index := 1)
Note how there are functions back and forth between `Implies p q` and `p → q`.
:::

:::fragment (index := 3)
Lean does not have `Implies`.
:::

:::fragment (index := 4)
> Simplification #2: Write `p → q` instead of `Implies p q`.
:::

:::fragment (index := 5)
A proof `h : p → q` that `p` implies `q` is a function that takes proofs of `p` to proofs of `q`.
:::
:::::

# First proof revisited

```lean
-- !fragment
axiom and_intro_old {p q : Prop} :
  Proof p → Proof q → Proof (And p q)
-- !fragment
axiom and_intro_new {p q : Prop} :
  p → q → (And p q)

-- !fragment
-- Proof #1 before simplifications
def my_first_proof_old (p q r : Prop) :
    Proof (Implies p q) → Proof (Implies p r)
    → Proof p → Proof (And q r) :=
  fun h₁ h₂ h₃ ↦
    and_intro_old
      (modus_ponens h₁ h₃)
      (modus_ponens h₂ h₃)

-- !fragment
-- Proof #1 after simplifications
def my_first_proof_new (p q r : Prop) :
    (p → q) → (p → r) → p → (And q r) :=
  fun h₁ h₂ h₃ ↦
    and_intro_new
      (h₁ h₃)
      (h₂ h₃)
```

# Second proof revisited

```lean
-- !fragment
-- Proof #2 before simplifications
def my_second_proof_old (p q r : Prop) :
    Proof (Implies p q) → Proof (Implies q r)
    → Proof (Implies p r) :=
  fun h₁ h₂ ↦
    implies_intro
      (fun (hp : Proof p) ↦
        modus_ponens h₂ (modus_ponens h₁ hp))

-- !fragment
-- Proof #2 after simplifications
def my_second_proof_new (p q r : Prop) :
  (p → q) → (q → r) → (p → r) :=
    fun h₁ h₂ hp ↦ h₂ (h₁ hp)
```

# Summary so far

:::::attr (style := "font-size: 0.65em")
:::fragment
There is a type `Prop : Type` of propositions.
:::

:::fragment
Every proposition `p : Prop` is itself a type.
:::

:::fragment
An element `t : p` is a proof of `p`.
:::

:::fragment
If `p q : Prop`, then `p → q : Prop` is another proposition.
:::
:::fragment
- It is the type of functions from proofs of `p` to proofs of `q`.
:::
:::fragment
- Equivalently, it is the type of proofs that `p` implies `q`.
:::

:::fragment
This approach taken by Lean is known as the _propositions-as-types paradigm_,
or the _Curry-Howard correspondence_.
:::
:::::

# Defining Truth

:::fragment
A proposition `p : Prop` is _true_ if it is nonempty.
That is, `p` is true if there is at least one proof `t : p`.
:::

:::fragment
A proposition `p : Prop` is _false_ if it is empty.
That is, `p` is false if there are no proofs `t : p`.
:::

:::fragment
Example: There is a term, `trivial`, of type `True`.
```lean -stretch
#check trivial
```
:::

:::fragment
Example: There is no term of type `False`.
:::

:::notes
A student might state that Godel's incompleteness theorem implies that true ≠ provable.
This is a deep issue that seems like it might undermine the definition of truth as
"there exists a proof".
The reason why this is still a fine definition is because the phrase "there is at least one",
or equivalently, "there exists", is working at the object-level rather than the meta-level.
:::

# Philosophy

:::fragment
If a proof passes the type checker, then it is valid.
:::
:::fragment
In other words, Lean's proof checker _is_ the type checker.
:::

:::fragment
One way to think of a proof `t : p` is that `t` is a "witness" that demonstrates that we know `p`
is true.
:::

# Logic operations

:::fragment
Lean still has {name}`And`, {name}`Or`, and {name}`Not` (just not `Proof` or `Implies`).
:::

```lean -stretch
-- !fragment
#check And
-- !fragment
#check Or
-- !fragment
#check Not
```
Syntax sugar: `\and` for {lean}`And`, `\or` for {lean}`Or`, `\not` for {lean}`Not`.

# Conjunction

`And p q` or `p \and q` is the type of pairs consisting of a proof of `p` followed by a proof of `q`.
