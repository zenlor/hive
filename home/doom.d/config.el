;;; config.el -*- lexical-binding: t; -*-
(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

(setenv "PATH"
        (concat
         (getenv "HOME") "/lib/bin" ":"
         (getenv "HOME") "/.local/bin" ":"
         (getenv "HOME") "/.luarocks/bin" ":"
         (getenv "PATH")))

(add-to-list 'exec-path (getenv "HOME") "/lib/bin")
(add-to-list 'exec-path (getenv "HOME") "/.local/bin")
(add-to-list 'exec-path (getenv "HOME") "/.luarocks/bin")

;; keep ssh agent variables
(after! doom-cli-env
  (add-to-list 'doom-env-allow "^SSH_"))

;; theme
;(setq doom-theme 'doom-tomorrow-night)
(after! doom-ui
        (setq! auto-dark-dark-theme  'doom-ayu-dark
               auto-dark-light-theme 'doom-ayu-light)
        (auto-dark-mode 1))


;; font
(setq doom-font (font-spec :family "Iosevka" :size 16)
      doom-variable-font (font-spec :family "Iosevka Aile")
      doom-unicode-font (font-spec :family "Iosevka")
      doom-big-font (font-spec :family "Iosevka" :size 22))

;; eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(terraform-mode . ("terraform-ls" "serve"))
               '(nix-mode . ("nixd"))))
;; apheleia
(after! apheleia
        (setf (alist-get 'opentofu apheleia-formatters)
              '("tofu" "fmt" "-"))
        (setf (alist-get 'terraform-mode apheleia-mode-alist)
              'opentofu))

;; enable global substitutions
(setq evil-ex-substitute-global t)

;; relative fringe numbers
(setq display-line-numbers-type 'relative)

;;
;; Keybindings
;;
(map! ;; sexp navigation
 :nv "U" 'backward-up-list
 :nv "R" 'down-list
 :nv "L" 'sp-forward-sexp
 :nv "H" 'sp-backward-sexp

 ;; Easier window navigation
 :n "C-h"   #'evil-window-left
 :n "C-j"   #'evil-window-down
 :n "C-k"   #'evil-window-up
 :n "C-l"   #'evil-window-right)

;;; clojure
(map! (:after clojure-mode
       :localleader
       (:map clojure-mode-map
             "S" #'cider-repl-set-ns
             "N" #'cider-enlighten-mode
             "s" #'cider-scratch
             "b" #'cider-load-buffer
             "B" #'cider-load-buffer-and-switch-to-repl-buffer)))
