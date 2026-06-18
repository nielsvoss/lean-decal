import VersoSlides
import Verso.Doc.Concrete

open VersoSlides

set_option verso.slides.panel false

#doc (Slides) "Lecture 3" =>

# Lecture 3: The Curry-Howard Correspondence

# Overview

Today's lecture is all about the {lean}`Prop` type.

{lean}`Prop` is the type of *propositions*, which are mathematical statements that can be true or
false.

Unlike {name}`Bool`, given a {lean}`Prop` we don't always know if it is true or false.
