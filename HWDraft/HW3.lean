
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

section SKI
set_option linter.unusedVariables false
variable {A B C D E F : Prop}

-- If you have these three functions, you can prove a lot of theorems without using the `fun` keyword.
theorem S : (A → (B → C)) → ((A → B) → (A → C)) := fun x y z ↦ x z (y z)
theorem K : A → B → A := fun x y ↦ x
theorem I : A → A := fun x ↦ x

/- According to
https://en.wikipedia.org/wiki/SKI_combinator_calculus#Conversion_of_lambda_terms_to_SKI_combinators
you can convert any proof that uses purely `fun` to a proof without `fun` but only `S`, `K`, and `I`
by repeatedly applying the following 4 rules:

1. Replace `fun x ↦ x` with `I`
2. If the expression `e₁` does not contain `x`, replace `fun x ↦ e₁` with `K e₁`
3. If the expression `e₁` does not contain `x`, replace `fun x ↦ e₁ x` with `e₁`.
4. If none of the above cases apply, replace `fun x ↦ e₁ e₂` with `S (fun x ↦ e₁) (fun x ↦ e₂)`.
-/

-- For example:
example : A → (A → B) → B := fun x ↦ fun y ↦ y x
-- Apply rule 4
example : A → (A → B) → B := fun x ↦ (S (fun y ↦ y)) (fun y ↦ x)
-- Apply rule 2
example : A → (A → B) → B := fun x ↦ (S (fun y ↦ y)) (K x)
-- Apply rule 1
example : A → (A → B) → B := fun x ↦ (S I) (K x)
-- Apply rule 4
example : A → (A → B) → B := S (fun x ↦ S I) (fun x ↦ K x)
-- Apply rule 3
example : A → (A → B) → B := S (fun x ↦ S I) K
-- Apply rule 2
example : A → (A → B) → B := S (K (S I)) K

-- Rewrite each of the following proofs to only use `S`, `K`, and `I` and not `fun`.
example : (A → B → C) → B → A → C := fun x ↦ fun y ↦ fun z ↦ (x z) y
example : (A → B → C) → B → A → C := fun x ↦ fun y ↦ S (fun z ↦ x z) (fun z ↦ y)
example : (A → B → C) → B → A → C := fun x ↦ S (fun y ↦ S x) (fun y ↦ K y)
example : (A → B → C) → B → A → C := fun x ↦ S (K (S x)) K
example : (A → B → C) → B → A → C := S (fun x ↦ S (K (S x))) (fun x ↦ K)
example : (A → B → C) → B → A → C := S (S (fun x ↦ S) (fun x ↦ K (S x))) (K K)
example : (A → B → C) → B → A → C := S (S (K S) (S (fun x ↦ K) (fun x ↦ S x))) (K K)
example : (A → B → C) → B → A → C := S (S (K S) (S (K K) S)) (K K)

example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ fun y ↦ fun z ↦ x (fun a ↦ y z)
example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ fun y ↦ fun z ↦ x (K (y z))
example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ fun y ↦ S (fun z ↦ x) (fun z ↦ K (y z))
example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ fun y ↦ S (K x) (S (fun z ↦ K) (fun z ↦ y z))
example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ fun y ↦ S (K x) (S (K K) y)
example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ S (fun y ↦ S (K x)) (fun y ↦ S (K K) y)
example : ((A → B) → C) → (D → B) → (D → C) := fun x ↦ S (K (S (K x))) (S (K K))
example : ((A → B) → C) → (D → B) → (D → C) := S (fun x ↦ S (K (S (K x)))) (fun x ↦ S (K K))
example : ((A → B) → C) → (D → B) → (D → C) := S (S (fun x ↦ S) (fun x ↦ K (S (K x)))) (K (S (K K)))
example : ((A → B) → C) → (D → B) → (D → C) := S (S (K S) (S (fun x ↦ K) (fun x ↦ S (K x)))) (K (S (K K)))
example : ((A → B) → C) → (D → B) → (D → C) := S (S (K S) (S (K K) (S (fun x ↦ S) (fun x ↦ K x)))) (K (S (K K)))
example : ((A → B) → C) → (D → B) → (D → C) := S (S (K S) (S (K K) (S (K S) K))) (K (S (K K)))

-- A proof that only uses `S`, `K`, and `I` without using `fun` is said to be "Hilbert-style".

end SKI
