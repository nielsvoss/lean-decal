import VersoSlides
import Verso.Doc.Concrete

open VersoSlides

set_option verso.slides.panel false

#doc (Slides) "Lecture 2" =>

# Lecture 2: Dependent Type Theory

# Simple Type Theory

# Basic Types

:::::attr (style := "font-size: 0.52em")
::::table +colHeaders +border +rowSeps +colSeps
*
  * Type
  * Description
  * Example elements
*
  * {name}`Nat`
  * :::attr (style := "font-size: 0.7em")
    The natural numbers/nonnegative integers. Can be arbitrarily large.
    :::
  * `0, 1, 2, 3, 4, ...`
*
  * {name}`Int`
  * The integers
  * `..., -2, -1, 0, 1, 2, ...`
*
  * {name}`String`
  * Unicode text
  * `"apple"`, `"LeanCal"`
*
  * {name}`Float`
  * The 64-bit floating point numbers (IEEE 754)
  * `3.2, 6.0, -0.0, NaN`
*
  * {name}`Bool`
  * A known truth value
  * `true, false`
*
  * {lean}`Prop`
  * An unknown truth value
  * `True`, `False`, `RiemannHypothesis`
::::
:::::

# Unit Type

The {name}`Unit` type has exactly one element, denoted {lean}`()`.

An element of {name}`Unit` carries $`0` bits of information.

```lean
#check ()
```

Ex: {name}`List.length` is a bijection from {lean}`List Unit` to {name}`Nat`.

# Empty Type

The {name}`Empty` type has zero elements. Useful for representing unreachable branches of code.

The function {name}`Empty.elim` converts a element of {name}`Empty` into whatever type you want.

Slogan: An element of the {name}`Empty` type "carries infinity bits of information." (not to be taken literally)

# The Function Type

```lean -show
opaque A : Type
opaque B : Type
```

If {lean}`A` and {lean}`B` are types, then {lean}`A → B` is the type of functions from {lean}`A` to {lean}`B`.

Each object assigns one element of {lean}`B` to every element of {lean}`A`.

In Lean, functions must always return the same value every time they are called, may not have side effects, and must not enter an infinite loop.

If {lean}`A` has 3 elements and {lean}`B` has 5 elements, then {lean}`A → B` has $`5^3 = 125` elements.
