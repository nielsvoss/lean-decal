import LeanDecal.LectureSlides.Lecture2
import LeanDecal.LectureSlides.Lecture3
import VersoSlides

open VersoSlides

def main : IO UInt32 := do
  let returnCode2 ← slidesMain
    (config := { theme := "white", slideNumber := true, transition := "slide" })
    (doc := %doc LeanDecal.LectureSlides.Lecture2)
  if returnCode2 ≠ 0 then return returnCode2
  IO.FS.rename "_slides/index.html" "_slides/Lecture2.html"

  let returnCode3 ← slidesMain
    (config := { theme := "white", slideNumber := true, transition := "slide" })
    (doc := %doc LeanDecal.LectureSlides.Lecture3)
  if returnCode3 ≠ 0 then return returnCode3
  IO.FS.rename "_slides/index.html" "_slides/Lecture3.html"

  return 0
