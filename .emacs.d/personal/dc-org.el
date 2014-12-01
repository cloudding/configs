;;; Commentary:
;; This contains my org-mode configuration
;; - Deepak Cherian

;;; Code:
;; org mode keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)

;; org-mode class for my latex style
(require 'org-latex)
(setq org-export-latex-listings t)
;; Originally taken from Bruno Tavernier: http://thread.gmane.org/gmane.emacs.orgmode/31150/focus=31432
;; but adapted to use latexmk 4.20 or higher.
(defun my-auto-tex-cmd ()
  "When exporting from .org with latex, automatically run latex,
     pdflatex, or xelatex as appropriate, using latexmk."
  (let ((texcmd)))
  ;; default command: oldstyle latex via dvi
  (setq texcmd "latexmk -dvi -pdfps -quiet %f")
  ;; pdflatex -> .pdf
  (if (string-match "LATEX_CMD: pdflatex" (buffer-string))
      (setq texcmd "latexmk -pdf -quiet %f"))
  ;; xelatex -> .pdf
  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
      (setq texcmd "latexmk -pdflatex=\"xelatex -fmt=/media/data/Work/tools/latex/preamble.fmt\" -pdf -quiet %f"))
  ;; LaTeX compilation command
  (setq org-latex-to-pdf-process (list texcmd)))

(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-cmd)
(setq org-latex-create-formula-image-program 'dvipng)

(defun my-auto-tex-parameters ()
      "Automatically select the tex packages to include."
      ;; default packages for ordinary latex or pdflatex export
      (setq org-export-latex-default-packages-alist
            '(("AUTO" "inputenc" t)
              ("T1"   "fontenc"   t)
              (""     "fixltx2e"  nil)
              (""     "wrapfig"   nil)
              (""     "soul"      t)
              (""     "textcomp"  t)
              (""     "marvosym"  t)
              (""     "wasysym"   t)
              (""     "latexsym"  t)
              (""     "amssymb"   t)
              (""     "hyperref"  nil)))

      ;; Packages to include when xelatex is used
      (if (string-match "LATEX_CMD: xelatex" (buffer-string))
          (setq org-export-latex-default-packages-alist
                '(("" "fontspec" t)
                  ("" "unicode-math" t)))))

(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-parameters)

;; my customized preamble
(add-to-list 'org-export-latex-classes
             '("dc-article"
               "\\documentclass[11pt,oneside]{memoir}\n
\\usepackage{color}
\\usepackage{fixltx2e}
\\usepackage{graphicx}   % add figures
\\usepackage{xcolor} 	 % support for color names
\\usepackage{array}
\\usepackage{booktabs}    % fancy tables
\\usepackage{multirow}
\\usepackage{longtable}
\\usepackage{subfig}	% add subfigure support
\\usepackage{float}	     % stronger placement of floats
\\usepackage{ulem}
\\usepackage{etoolbox}
\\usepackage{letltxmacro}  % for new sqrt
\\usepackage{parskip}
\\usepackage{titlesec}
\\usepackage{titletoc}
\\usepackage{paralist}
\\usepackage{rotating} % allow page rotation
\\usepackage{pdflscape} % allow landscape pages in pdf
\\usepackage{hyperref}  % hyperlinks in pdf
\\usepackage[figure,table]{hypcap} % Correct a problem with hyperref
\\usepackage{mathtools}
\\usepackage{bigints}
\\usepackage[warning]{onlyamsmath}
\\usepackage[sort&compress]{natbib} % for bibliography
\\usepackage{cleveref}
\\usepackage{gensymb}
\\usepackage{xfrac}
\\usepackage{siunitx}
\\usepackage[protrusion=true]{microtype}
\\linespread{1.5}
\\urlstyle{rm}
\\newcommand{\\ir}{\\mathrm{i}}
\\newcommand{\\dr}{\\mathrm{d}}
\\newcommand{\\D}{\\mathrm{D}}
\\newcommand{\\e}{\\, \\mathrm{e}}
\\newcommand{\\er}{\\mathrm{e}}
\\newcommand{\\dd}[3][]{{\\frac{\\dr^{#1} #2}{\\dr #3^{#1}}}}
\\newcommand{\\pp}[3][]{{\\frac{\\partial^{#1} #2}{\\partial #3^{#1}}}}
\\newcommand{\\DD}[1]{{\\frac{\\D#1}{\\D t}}}
\\newcommand{\\mb}[1]{\\boldsymbol{#1}} % math bold font
\\newcommand{\\ol}[1]{\\overline{#1}}
\\newcommand{\\x}{\\times}
\\newcommand{\\mO}{\\mathcal{O}}
\\newcommand{\\ubr}{\\underbracket}
\\newcommand{\\disp}{\\displaystyle}
\\newcommand{\\vb}{\\mb{v}\\xspace}
\\newcommand{\\ub}{\\mb{u}\\xspace}
\\newcommand{\\Ro}{\\mathit{Ro}}
\\newcommand{\\Rot}{\\mathit{Ro}_\mathit{T}}
\\newcommand{\\Rh}{\\mathit{Rh}}
\\newcommand{\\Ri}{\\mathit{Ri}}
\\newcommand{\\Rif}{\\Ri_f}
\\newcommand{\\Pra}{\\mathit{Pr}}
\\newcommand{\\Pe}{\\mathit{Pe}}
\\newcommand{\\Ra}{\\mathit{Ra}}
\\newcommand{\\Rey}{\\mathit{Re}}
\\newcommand{\\Fr}{\\mathit{Fr}}
\\newcommand{\\Bu}{\\mathit{Bu}}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(provide 'dc-org)
;;; dc-org ends here