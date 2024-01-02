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


;; theme
(setq doom-theme 'doom-gruvbox)


;; font
;; (setq doom-font (font-spec :family "Iosevka" :size 20)
;;       doom-unicode-font (font-spec :family "Iosevka")
;;       doom-big-font (font-spec :family "Iosevka" :size 28))
(setq doom-font (font-spec :family "Fira Code" :size 20)
      doom-variable-font (font-spec :family "Fira Sans")
      doom-unicode-font (font-spec :family "Fira Code")
      doom-big-font (font-spec :family "Fira Code" :size 30))

;; eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(terraform-mode . ("terraform-ls" "serve"))
               '(nix-mode . ("nixd" "rnix-lsp"))))


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
