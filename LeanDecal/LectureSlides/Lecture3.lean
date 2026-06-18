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

# Decidable Propositions

Some propositions are _decidable_, which means that Lean can automatically convert them into a
{name}`Bool`.

```lean
#eval (True : Bool)
#eval (False ∧ True : Bool)
```

This fails for propositions that are not decidable:
```lean +error
#check (RiemannHypothesis : Bool)
```
