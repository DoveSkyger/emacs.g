;;; early-init.el --- earliest birds               -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq load-prefer-newer t)

(let ((dir (file-name-directory (or load-file-name buffer-file-name))))
  (add-to-list 'load-path (expand-file-name "lib/compat" dir))
  (add-to-list 'load-path (expand-file-name "lib/packed" dir))
  (add-to-list 'load-path (expand-file-name "lib/auto-compile" dir)))
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(setq package-enable-at-startup nil)

(with-eval-after-load 'package
  (add-to-list 'package-archives
               (cons "melpa" "https://melpa.org/packages/")
               t))

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; Set default font before frame creation to make sure the first frame have the correct size
(defvar font-list
  (cond
   ((eq system-type 'darwin)
    '(("Sarasa Mono SC Nerd Font" . 12) ("Monaco" . 12) ("Menlo" . 12)))
   ((eq system-type 'windows-nt)
    '(("Sarasa Mono SC Nerd Font" . 10) ("Consolas" . 11) ("Cascadia Mono" . 10)))
   (t
    '(("Sarasa Mono SC Nerd Font" . 10) ("Consolas" . 11) ("Cascadia Mono" . 10))))
  "List of fonts and sizes.  The first one available will be used.")

(add-to-list 'default-frame-alist (cons 'font (format "%s-%d" (caar font-list) (cdar font-list))))


;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; early-init.el ends here
