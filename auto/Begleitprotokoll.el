(TeX-add-style-hook
 "Begleitprotokoll"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("vwa" "DLS" "	inreferencehack" "	ohneVgl=false" "	ohneS=false" "	scauthor" "	rundeauslassung=false" "	bookstyle=false" "	widowlines=3" "	titlepage=DLS2017" "	listof=nochaptergap" "	doppelpunkt=false" "	postnotedoppelpunkt=false" "	zitierstil=klassisch")))
   (TeX-run-style-hooks
    "latex2e"
    "vwa"
    "vwa10")
   (LaTeX-add-environments
    '("datelist" LaTeX-env-args ["argument"] 0)))
 :latex)

