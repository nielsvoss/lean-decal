import VersoSlides
import Verso.Doc.Concrete
import Mathlib.NumberTheory.LSeries.RiemannZeta

open VersoSlides

set_option verso.slides.panel false
set_option linter.hashCommand false

#doc (Slides) "Lecture 3" =>

# Lecture 3: The Curry-Howard Correspondence

# Overview

Today's lecture is all about the {lean}`Prop` type.

{lean}`Prop` is the type of *propositions*, which are mathematical statements that can be true or
false.

Unlike {name}`Bool`, given a {lean}`Prop` we don't always know if it is true or false.

/-
# Operations on Prop

```lean -show
-- TODO: Consider namespacing
opaque p : Prop
opaque q : Prop
```

{lean}`And p q` (also written as {lean}`p ∧ q`) is the _conjunction_ of {lean}`p` and {lean}`q`.
```lean -stretch
#check And
```

{lean}`Or p q` (also written as {lean}`p ∨ q`) is the _disjunction_ of {lean}`p` and {lean}`q`.
```lean -stretch
#check Or
```
-/

# Decidable Propositions

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

# Representing proofs in Lean

```lean -show
namespace AlternateReality
opaque Proof : Prop → Type
opaque And : Prop → Prop → Prop
opaque Or : Prop → Prop → Prop
opaque Not : Prop → Prop
opaque Implies : Prop → Prop → Prop
axiom and_intro (p q : Prop) : Proof p → Proof q → Proof (And p q)
axiom modus_ponens (p q : Prop) : Proof (Implies p q) → Proof p → Proof q
```

The most important thing about propositions is that they can be proven.

In Lean, _proofs are mathematical objects_.
This means you can have functions that take in proofs and ouptut proofs.

One design decision that lean _could_ have made is to have a new type, `Proof p`, which is the type
of proofs of the proposition `p`.

```lean -stretch
#check Proof
```

_Important: {name}`Proof` is not a real thing in Lean, we're just using it as an example._

```lean -show
end AlternateReality
```
