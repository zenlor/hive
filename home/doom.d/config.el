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
(setq doom-theme 'doom-gruvbox)

;; font
(setq doom-font (font-spec :family "IBM Plex Mono" :size 13)
      doom-variable-font (font-spec :family "IBM Plex Sans")
      doom-unicode-font (font-spec :family "IBM Plex Mono")
      doom-big-font (font-spec :family "IBM Plex Mono" :size 22))
;(setq doom-font (font-spec :family "Iosevka" :size 14)
;      doom-variable-font (font-spec :family "Iosevka Aile")
;      doom-unicode-font (font-spec :family "Iosevka")
;      doom-big-font (font-spec :family "Iosevka" :size 22))

;; org
(setq org-directory "~/Documents/notes")

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

;; keychain support: https://github.com/tarsius/keychain-environment/blob/main/keychain-environment.el
(let* ((ssh (shell-command-to-string "keychain -q --noask --agents ssh --eval"))
       (gpg (shell-command-to-string "keychain -q --noask --agents gpg --eval")))
  (list (and ssh
             (string-match "SSH_AUTH_SOCK[=\s]\\([^\s;\n]*\\)" ssh)
             (setenv       "SSH_AUTH_SOCK" (match-string 1 ssh)))
        (and ssh
             (string-match "SSH_AGENT_PID[=\s]\\([0-9]*\\)?" ssh)
             (setenv       "SSH_AGENT_PID" (match-string 1 ssh)))
        (and gpg
             (string-match "GPG_AGENT_INFO[=\s]\\([^\s;\n]*\\)" gpg)
             (setenv       "GPG_AGENT_INFO" (match-string 1 gpg)))))


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
