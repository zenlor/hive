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

;; fix complaints about non posix shell ... or better: non-bash shell :'(
(setq shell-file-name (executable-find "bash"))
    
(setq-default
  vterm-shell "/run/current-system/sw/bin/fish")
(setq-default
  explicit-shell-file-name "/run/current-system/sw/bin/fish")

;; keep ssh agent variables
(after! doom-cli-env
  (add-to-list 'doom-env-allow "^SSH_"))

;; theme
(setq doom-theme 'doom-snazzy)

;; font
(let ((fontsize 15)
      (family           "Iosevka")  ;; IBM Plex Mono
      (family-variable  "Iosevka Etoile")) ;; IBM Plex Sans
  (if (or (equal (system-name) "horus")
          (equal (system-name) "meila")
          (equal (system-name) "nixos"))
    (setq fontsize 17))
  (setq doom-font (font-spec :family family :size fontsize)
        doom-variable-font (font-spec :family family-variable)
        doom-symbol-font (font-spec :family family)
        doom-big-font (font-spec :family family :size (truncate (* fontsize 1.5)))))

;; org
(setq org-directory "~/Documents/notes")

;; eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(terraform-mode . ("terraform-ls" "serve"))
               '(nix-mode . ("nil"))))
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


;; projectile
;; control project root additional guess (besides ".git", ".projectile")
(setq projectile-project-root-files
'("CMakeLists.txt" "Makefile" "configure.ac" "configure.in" "TAGS" "GTAGS"))
(setq projectile-ignored-projects '("~/"))

(c-set-offset 'inline-open '0)
(defun vlad-cc-style()
  (c-set-style "linux")
  (c-set-offset 'innamespace '0)
  (c-set-offset 'inextern-lang '0)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'label '*)
  (c-set-offset 'case-label '*)
  (c-set-offset 'access-label '/)
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
)

(add-hook 'c++-mode-hook 'vlad-cc-style)
