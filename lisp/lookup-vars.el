;;; lookup-vars.el --- Lookup variable list
;; Copyright (C) 2000 Keisuke Nishida <knishida@ring.gr.jp>

;; Author: Keisuke Nishida <knishida@ring.gr.jp>
;; Keywords: dictionary

;; This file is part of Lookup.

;; Lookup is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; Lookup is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Lookup; if not, write to the Free Software Foundation,
;; Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;;; Code:

;;;;;;;;;;;;;;;;;;;;
;; Custom Variables
;;;;;;;;;;;;;;;;;;;;

(defgroup lookup nil
  "Search interface with electronic dictionaries."
  :group 'applications)

;;;
;;; Setup variables
;;;

(defgroup lookup-setup-variables nil
  "Primary setup variables."
  :group 'lookup)

(defcustom lookup-init-file (concat "~" init-file-user "/.lookup")
  "*User's initialization file for Lookup."
  :type 'file
  :group 'lookup-setup-variables)

(defcustom lookup-data-directory data-directory
  "*Lookup $B$K4X$9$k%W%m%0%i%`0J30$N%G!<%?$,<}$a$i$l$k%G%#%l%/%H%j!#(B"
  :type 'directory
  :group 'lookup-setup-variables)

(defcustom lookup-complement-directory nil
  "*Directory that complement files are put in.
If this variable is nil, complement files will be searched from `load-path'."
  :type 'directory
  :group 'lookup-setup-variables)

(defcustom lookup-complement-autoload-alist nil
  "*Alist of the load definition of complement files.
The value of this variable should look like ((REGEXP . FILE) ...),
where REGEXP is the pattern matching with a dictionary ID, and
FILE is a complement file name."
  :type '(repeat (cons (string :tag "regexp") (string :tag "file")))
  :group 'lookup-setup-variables)

(defcustom lookup-mode-module-alist nil
  "*"
  :type '(repeat (cons (symbol :tag "mode") (string :tag "module")))
  :group 'lookup-setup-variables)

;;;
;;; General options
;;;

(defgroup lookup-general-options nil
  "General customizable variables."
  :group 'lookup)

(defcustom lookup-default-method 'exact
  "*\\[lookup-pattern] $B$G<B9T$5$l$kI8=`$N8!:wJ}<0!#(B
$BJQ?t(B `lookup-search-methods' $B$N$$$:$l$+$NCM$r;XDj2DG=!#(B"
  :type 'symbol
  :group 'lookup-general-options)

(defcustom lookup-frame-alist
  '((title . "Lookup") (menu-bar-lines . 0) (width . 48) (height . 32)
    (lookup-fill-column . 45))
  "*Lookup $B@lMQ%U%l!<%`$N%Q%i%a!<%?$N%j%9%H!#(B
$B@_Dj$9$Y$-CM$K$D$$$F$O!"(B`default-frame-alist' $B$r;2>H!#(B"
  :type '(repeat (cons :tag "Parameter"
		       (symbol :tag "tag")
		       (sexp :tag "value")))
  :group 'lookup-general-options)

(defcustom lookup-fill-column .9
  "*$B%(%s%H%jFbMF$r(B fill $B$9$k$H$-$N7e?t!#(B
$B>.?t$r;XDj$7$?>l9g$O!"%&%#%s%I%&$NI}$KBP$9$k3d9g$H$7$FMQ$$$i$l$k!#(B"
  :type 'number
  :group 'lookup-general-options)

(defcustom lookup-window-height 4
  "*Entry $B%P%C%U%!Ey$N%&%#%s%I%&$N9b$5!#(B
$B>.?t$r;XDj$7$?>l9g$O!"(BLookup $BA4BN$N%&%#%s%I%&$N9b$5$KBP$9$k3d9g$H$7$F(B
$BMQ$$$i$l$k!#(B"
  :type 'number
  :group 'lookup-general-options)

(defcustom lookup-save-configuration t
  "*Non-nil $B$r;XDj$9$k$H!"(BLookup $B$rH4$1$?$H$-$K%&%#%s%I%&>uBV$r2sI|$9$k!#(B"
  :type 'boolean
  :group 'lookup-general-options)

(defcustom lookup-use-unicode (featurep 'unicode)
  "*Non-nil $B$r;XDj$9$k$H!"30;z$NI=<(Ey$K(B Unicode $B$rMQ$$$k!#(B"
  :type 'boolean
  :group 'lookup-general-options)
  
(defcustom lookup-use-bitmap (or (featurep 'bitmap)
				 (locate-library "bitmap"))
  "*Non-nil $B$r;XDj$9$k$H!"(Bbitmap-mule $B%Q%C%1!<%8$rMxMQ$7$?30;zI=<($r9T$J$&!#(B"
  :type 'boolean
  :group 'lookup-general-options)

(defcustom lookup-use-kakasi (or (locate-library "kakasi" t exec-path)
				 (locate-library "kakasi.exe" t exec-path))
  "*Non-nil $B$r;XDj$9$k$H!"$$$/$D$+$N6ILL$G(B KAKASI $B$,MxMQ$5$l$k!#(B
$B$3$l$O8=:_!"6qBNE*$K$OF|K\8l$N%G%U%)%k%H$N8!:w8l$N@Z$j=P$7$KMQ$$$F$$$k!#(B"
  :type 'boolean
  :group 'lookup-general-options)

(defcustom lookup-enable-format t
  "Non-nil $B$r;XDj$9$k$H!"%F%-%9%H$r@07A$7$F=PNO$9$k!#(B"
  :type 'boolean
  :group 'lookup-general-options)

(defcustom lookup-enable-gaiji t
  "*Non-nil $B$r;XDj$9$k$H!"30;zI=<($,M-8z$H$J$k!#(B"
  :type 'boolean
  :group 'lookup-general-options)

(defcustom lookup-enable-example t
  "*Non-nil $B$r;XDj$9$k$H!"NcJ8I=<($,M-8z$H$J$k!#(B"
  :type 'boolean
  :group 'lookup-general-options)

(defcustom lookup-enable-record nil
  "*Non-nil enables keeping records for statstics."
  :type 'boolean
  :group 'lookup-cache)

(defcustom lookup-max-hits 50
  "*$B8!:w;~$KI=<($9$k%(%s%H%j$N:GBg?t!#(B
0 $B$r;XDj$9$k$H!"8+$D$+$C$?A4$F$N%(%s%H%j$rI=<($9$k!#(B"
  :type 'integer
  :group 'lookup-general-options)

(defcustom lookup-max-text 0
  "*$B8!:w;~$KI=<($9$k%(%s%H%jK\J8$N:GBgD9!#(B
0 $B$r;XDj$9$k$H!"A4J8$rI=<($9$k!#(B"
  :type 'integer
  :group 'lookup-general-options)

(defcustom lookup-max-history 80
  "*$B8!:wMzNr$rJ];}$9$k:GBg?t!#(B
0 $B$r;XDj$9$k$HL58B$KJ];}$9$k!#(B"
  :type 'integer
  :group 'lookup-general-options)

(defcustom lookup-head-width 24
  "*Head width"
  :type 'integer
  :group 'lookup-general-options)

(defcustom lookup-initial-memorandum
  (lambda (entry)
    (format "Title: %s\nEntry: %s\nDate: %s\n\n"
	    (lookup-dictionary-title (lookup-entry-dictionary entry))
	    (lookup-entry-heading entry)
	    (format-time-string "%a, %e %b %Y %T %z")))
  "*initial memorandum."
  :type 'function
  :group 'lookup-general-options)

(defcustom lookup-cite-header nil
  "*$B%(%s%H%jK\J8$r0zMQ$9$k$H$-$N%X%C%@!#(B
$B%3%^%s%I(B `lookup-summary-cite-content' $B5Z$S(B `lookup-content-cite-region'
$B$K$h$jFbMF$r<h$j9~$`$H$-!"$=$N@hF,$K;XDj$7$?J8;zNs$,IU$12C$($i$l$k!#(B
$BJ8;zNs$,(B \"%T\" $B$r4^$`>l9g!"<-=q$N%?%$%H%k$KCV$-49$($i$l$k!#(B
$B<-=q%*%W%7%g%s(B `cite-header' $B$,;XDj$5$l$F$$$k>l9g!"$=$A$i$,M%@h$5$l$k!#(B"
  :type 'string
  :group 'lookup-general-options)

(defcustom lookup-cite-prefix nil
  "*$B%(%s%H%jK\J8$r0zMQ$9$k$H$-$N%W%l%U%#%/%9!#(B
$B%3%^%s%I(B `lookup-summary-cite-content' $B5Z$S(B `lookup-content-cite-region'
$B$K$h$jFbMF$r<h$j9~$`$H$-!"3F9T$N@hF,$K;XDj$7$?J8;zNs$,IU$12C$($i$l$k!#(B
$B<-=q%*%W%7%g%s(B `cite-preifx' $B$,;XDj$5$l$F$$$k>l9g!"$=$A$i$,M%@h$5$l$k!#(B"
  :type 'string
  :group 'lookup-general-options)

(defcustom lookup-gaiji-alternate "_"
  "*$B30;z$NBeBXJ8;zNs$H$7$FMQ$$$i$l$k%G%U%)%k%H$NJ8;zNs!#(B"
  :type 'string
  :group 'lookup-general-options)

(defcustom lookup-process-coding-system
  (when (featurep 'evi-mule)
    (if (memq system-type '(ms-dos windows-nt OS/2 emx))
	(evi-coding-system 'sjis-dos)
      (evi-coding-system 'euc-jp)))
  "*$B30It%W%m%;%9$H$N%G%U%)%k%H$NJ8;z%3!<%I!#(B"
  :type 'symbol
  :group 'lookup-general-options)

(defcustom lookup-kakasi-coding-system lookup-process-coding-system
  "*KAKASI $B$N8F$S=P$7$KMQ$$$kJ8;z%3!<%I!#(B"
  :type 'symbol
  :group 'lookup-general-options)

;;;
;;; Search agents
;;;

(defgroup lookup-search-agents nil
  "Search agents."
  :group 'lookup)

;;;
;;; Caches
;;;

(defgroup lookup-cache nil
  "Cache control."
  :group 'lookup)

(defcustom lookup-cache-file nil
  "*Lookup $B$N%-%c%C%7%e%U%!%$%kL>!#(B
$B$3$N%U%!%$%k$O(B Lookup $B=*N;;~$K>pJs$,=q$-9~$^$l$k!#(B
nil $B$r;XDj$9$k$H>pJs$rJ]B8$7$J$$!#(B"
  :type 'file
  :group 'lookup-cache)

;;;
;;; Faces
;;;

(defgroup lookup-faces nil
  "Faces."
  :group 'lookup)

(defface lookup-heading-1-face
    '((((class color) (background light)) (:foreground "SlateBlue" :bold t))
      (((class color) (background dark)) (:foreground "LightBlue" :bold t)))
  "Level 1 heading face."
  :group 'lookup-faces)

(defface lookup-heading-2-face
  '((((class color) (background light)) (:foreground "Red" :bold t))
    (((class color) (background dark)) (:foreground "Pink" :bold t)))
  "Level 2 heading face."
  :group 'lookup-faces)

(defface lookup-heading-3-face
  '((((class color) (background light)) (:foreground "Orange" :bold t))
    (((class color) (background dark)) (:foreground "LightSalmon" :bold t)))
  "Level 3 heading face."
  :group 'lookup-faces)

(defface lookup-heading-4-face
  '((t (:bold t)))
  "Level 4 heading face."
  :group 'lookup-faces)

(defface lookup-heading-5-face
  '((t nil))
  "Level 5 heading face."
  :group 'lookup-faces)

(defface lookup-heading-low-face
  '((((class color) (background light)) (:foreground "Grey" :bold t))
    (((class color) (background dark)) (:foreground "LightGrey" :bold t)))
  "Low level heading face."
  :group 'lookup-faces)

(defface lookup-reference-face
  '((((class color) (background light)) (:foreground "Blue" :bold t))
    (((class color) (background dark)) (:foreground "Cyan" :bold t)))
  "Face used to highlight reference."
  :group 'lookup-faces)

(defface lookup-refered-face
  '((((class color) (background light)) (:foreground "DarkViolet" :bold t))
    (((class color) (background dark)) (:foreground "Plum" :bold t)))
  "Face used to highlight refered reference."
  :group 'lookup-faces)


;;;;;;;;;;;;;;;;;;;;
;; Advanced Variables
;;;;;;;;;;;;;;;;;;;;

(defvar lookup-debug-mode nil
  "*Non-nil enabes Lookup's debug features.")

(defvar lookup-search-agents nil)

(defvar lookup-search-modules nil)

(defvar lookup-agent-option-alist nil)

(defvar lookup-dictionary-option-alist nil)

(defvar lookup-complement-alist nil)

(defvar lookup-complement-agent nil
  "Symbol indicating the search agent that a complement file applies to.
This variable is automatically set when loading a complement file, and
should be only refered in complement files.")

(defvar lookup-complement-options nil
  "Dictionary options defined in a complement file.
This variable should be only set in complement files.")

(defvar lookup-arrange-table
  '((replace   . lookup-arrange-replaces)
    (reference . lookup-arrange-references)
    (gaiji     . lookup-arrange-gaijis)
    (structure . lookup-arrange-structure)
    (fill      . lookup-arrange-fill-lines)))

(defvar lookup-load-hook nil
  "*List of functions called after loading Lookup.
This hook will run just after loading `lookup-init-file' and
`lookup-cache-file'.")

;;;
;;; Command control
;;;

(defvar lookup-search-method nil
  "$B8!:wJ}<0$r;XDj$9$k$H!"F~NO$r%Q!<%9$;$:$=$l$r$=$N$^$^MQ$$$k!#(B")

(defvar lookup-force-update nil
  "Non-nil $B$r;XDj$9$k$H!"%-%c%C%7%e$rMQ$$$:6/@)E*$K:F8!:w$r9T$J$&!#(B")

(defvar lookup-open-function 'lookup-other-window
  "Lookup $B$N%&%#%s%I%&$rI=<($9$k$?$a$NI8=`$N4X?t!#(B
$B<!$N;0$D$N$$$:$l$+$r;XDj2DG=!#(B

`lookup-full-screen'  - $B8!:w7k2L$r2hLLA4BN$GI=<($9$k(B
`lookup-other-window' - $B8!:w7k2L$rJL$N%&%#%s%I%&$GI=<($9$k(B
`lookup-other-frame'  - $B8!:w7k2L$rJL$N%U%l!<%`$GI=<($9$k(B")


;;;;;;;;;;;;;;;;;;;;
;; Internal Variables
;;;;;;;;;;;;;;;;;;;;

(defvar lookup-agent-alist nil)
(defvar lookup-module-alist nil)
(defvar lookup-dictionary-alist nil)
(defvar lookup-entry-table nil)
(defvar lookup-default-module nil)
(defvar lookup-buffer-list nil)
(defvar lookup-current-session nil)
(defvar lookup-last-session nil)
(defvar lookup-record-table nil)
(defvar lookup-search-history nil)

(defvar lookup-mode-help nil)
(make-variable-buffer-local 'lookup-mode-help)

(defvar lookup-byte-compiling nil)
(defvar lookup-dynamic-display nil)
(defvar lookup-valid-dictionaries nil)
(defvar lookup-proceeding-message nil)
(defvar lookup-window-configuration nil)

(defvar lookup-gaiji-compose-function nil)
(defvar lookup-gaiji-paste-function nil)

(defun lookup-init-gaiji-functions ()
  (cond ((featurep 'xemacs)
	 (setq lookup-gaiji-compose-function 'lookup-glyph-compose
	       lookup-gaiji-paste-function 'lookup-glyph-paste))
	(lookup-use-bitmap
	 (setq lookup-gaiji-compose-function 'lookup-bitmap-compose
	       lookup-gaiji-paste-function 'lookup-bitmap-paste))
	(t
	 (setq lookup-gaiji-compose-function nil
	       lookup-gaiji-paste-function 'lookup-bitmap-paste))))

(provide 'lookup-vars)

;;; lookup-vars.el ends here

;;; Local variables:
;;; mode:emacs-lisp
;;; End: