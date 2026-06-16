import LeanDecal.LectureSlides.Lecture2
import VersoSlides

open VersoSlides

def main : IO UInt32 := do
  let returnCode2 ← slidesMain
    (config := { theme := "white", slideNumber := true, transition := "slide" })
    (doc := %doc LeanDecal.LectureSlides.Lecture2)
  if returnCode2 ≠ 0 then return returnCode2
  IO.FS.rename "_slides/index.html" "_slides/Lecture2.html"

  return 0
