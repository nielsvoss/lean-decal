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
  * :::attr (style := "font-size: 0.52em")
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
