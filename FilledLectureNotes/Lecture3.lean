theorem de_morgan {p q : Prop} : ¬(p ∨ q) ↔ ¬p ∧ ¬q :=
  Iff.intro
    (fun h ↦
    show ¬p ∧ ¬q from And.intro
      (show p → False from fun hp ↦
       have ho : p ∨ q := Or.intro_left q hp
       show False from h ho)
      (show q → False from fun hq ↦
       have ho : p ∨ q := Or.intro_right p hq
       show False from h ho))
    (fun (h : ¬p ∧ ¬q) (hc : p ∨ q) ↦
     Or.elim hc
     (And.left h)
     (And.right h))

theorem de_morgan_2 {p q : Prop} : ¬(p ∧ q) ↔ ¬p ∨ ¬q :=
  have hf : ¬(p ∧ q) → ¬p ∨ ¬q := fun (h : ¬(p ∧ q)) ↦
    have hlem : p ∨ ¬p := Classical.em p
    have hl : p → ¬p ∨ ¬q :=
      fun (hp : p) ↦
      have hnq : ¬q :=
        fun (hq : q) ↦
        show False from h (And.intro hp hq)
      Or.intro_right (¬p) hnq
    have hr : ¬p → ¬p ∨ ¬q := Or.intro_left (¬q)
    Or.elim hlem hl hr
  have hb : ¬p ∨ ¬q → ¬(p ∧ q) := fun (h : ¬p ∨ ¬q) ↦
    have hl : ¬p → ¬(p ∧ q) :=
      fun (hp : ¬p) ↦
      fun (hc : (p ∧ q)) ↦
      show False from hp (And.left hc)
    have hr : ¬q → ¬(p ∧ q) :=
      fun (hq : ¬q) ↦
      fun (hc : (p ∧ q)) ↦
      show False from hq (And.right hc)
    Or.elim h hl hr
  Iff.intro hf hb

#print axioms de_morgan
#print axioms de_morgan_2
