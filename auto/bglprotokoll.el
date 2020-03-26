(TeX-add-style-hook
 "bglprotokoll"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("scrartcl" "a4paper" "12pt" "DIV=default" "parskip=half")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("babel" "naustrian") ("inputenc" "utf8") ("datetime2" "de-AT")))
   (TeX-run-style-hooks
    "latex2e"
    "scrartcl"
    "scrartcl12"
    "fontenc"
    "babel"
    "inputenc"
    "lmodern"
    "microtype"
    "siunitx"
    "datetime2")
   (LaTeX-add-environments
    '("datelist" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-lengths
    "daywidth"
    "monthwidth"
    "yearwidth"))
 :latex)

