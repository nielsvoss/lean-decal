
/-===========================
Problem X: Problems from TPIL
===========================-/
-- The following exercises is taken from "Theorem Proving in Lean 4", chapter 3
-- Please fill in the following sorries. Do not use tactic mode.
-- For this first set of exercises, do not use law of the excluded middle.

variable (p q r : Prop)

-- commutativity of ∧ and ∨
example : p ∧ q ↔ q ∧ p := sorry
example : p ∨ q ↔ q ∨ p := sorry

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) := sorry
example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := sorry

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) := sorry
example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) := sorry

-- other properties
example : (p → (q → r)) ↔ (p ∧ q → r) := sorry
example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := sorry
example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := sorry
example : ¬p ∨ ¬q → ¬(p ∧ q) := sorry
example : ¬(p ∧ ¬p) := sorry
example : p ∧ ¬q → ¬(p → q) := sorry
example : ¬p → (p → q) := sorry
example : (¬p ∨ q) → (p → q) := sorry
example : p ∨ False ↔ p := sorry
example : p ∧ False ↔ False := sorry
example : (p → q) → (¬q → ¬p) := sorry

example : ¬(p ↔ ¬p) := sorry

-- For these exercises, you may use the law of the excluded middle (`Classical.em`)

example : (p → q ∨ r) → ((p → q) ∨ (p → r)) := sorry
example : ¬(p ∧ q) → ¬p ∨ ¬q := sorry
example : ¬(p → q) → p ∧ ¬q := sorry
example : (p → q) → (¬p ∨ q) := sorry
example : (¬q → ¬p) → (p → q) := sorry
example : p ∨ ¬p := sorry
example : (((p → q) → p) → p) := sorry

/-===========================
Problem Y: More practice with logic
===========================-/

-- Prove the following without law of the excluded middle:
example : ¬¬(p ∨ ¬p) := sorry

/-===========================
Problem X: SKI Combinator Calculus and Hilbert Style Deduction
===========================-/

-- If you have these three functions, you can prove a lot of theorems without using the `fun` keyword.
theorem S {A B C : Prop} : (A → (B → C)) → ((A → B) → (A → C)) := fun x y z ↦ x z (y z)
theorem K {A B : Prop} : A → B → A := fun x y ↦ x
theorem I {A : Prop} : A → A := fun x ↦ x

variable {A B C D E F : Prop}

/- According to
https://en.wikipedia.org/wiki/SKI_combinator_calculus#Conversion_of_lambda_terms_to_SKI_combinators
you can convert any proof that uses purely `fun` to a proof without `fun` but only `S`, `K`, and `I`
by repeatedly applying the following 4 rules:

- Replace `fun x ↦ x` with `I`
- If the expression `e₁` does not contain `x`, replace `fun x ↦ e₁` with `K e₁`
- If the expression `e₁` does not contain `x`, replace `fun x ↦ e₁ x` with `e₁`.
- Replace `fun x ↦ e₁ e₂` with `S (fun x ↦ e₁) (fun x ↦ e₂)`.
-/

-- For example:
example : A → (A → B) → B := fun x ↦ fun y ↦ y x
example : A → (A → B) → B := fun x ↦ (S (fun y ↦ y)) (fun y ↦ x)
example : A → (A → B) → B := fun x ↦ (S I) (K x)
example : A → (A → B) → B := S (fun x ↦ S I) (fun x ↦ K x)
example : A → (A → B) → B := S (K (S I)) K
