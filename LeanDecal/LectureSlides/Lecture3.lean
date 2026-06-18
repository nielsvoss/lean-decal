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
--namespace AlternateReality
opaque Proof : Prop → Type
--opaque And : Prop → Prop → Prop
--opaque Or : Prop → Prop → Prop
--opaque Not : Prop → Prop
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
#check And
#check Or
#check Not
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
axiom modus_ponens {p q : Prop} :
  Proof (Implies p q) → Proof p → Proof q
```
:::

# Our first proof

Our first proof of the following theorem:
> If $`p \Rightarrow q` and $`p \Rightarrow r` and $`p`, then $`q \land r`.

```lean -show
noncomputable section
```
```lean +panel
-----
def my_proof (p q r : Prop) :
    Proof (Implies p q) → Proof (Implies p r)
    → Proof p → Proof (And q r) :=
  fun h₁ h₂ h₃ ↦
    and_intro
      (modus_ponens h₁ h₃)
      (modus_ponens h₂ h₃)
```
