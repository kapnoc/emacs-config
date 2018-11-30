;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-offsets-alist (quote ((arglist-cont-nonempty . +))))
 '(custom-safe-themes
   (quote
    ("bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "c2831730b24d526a7b6268a9e42e8e57d2a1279c8f92c5db554af03d4333af2c" "e8ebf4fb99b76dad3b7ec2313d5d091c1f3a3e0e4f9d55d3a58d73a8d3387358" default)))
 '(indent-tabs-mode nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (xterm-color exwm-x go-mode flycheck rainbow-mode rainbow-delimiters typescript-mode desktop+ magit string-inflection ample-theme emmet-mode yasnippet-snippets yasnippet eimp plantuml-mode markdown-mode evil-surround auto-complete haskell-mode ##)))
 '(plantuml-jar-path "/usr/share/java/plantuml-1.2018.0.jar"))
(package-initialize)

(setq emacs-lisp-dir "~/.emacs.d/"
      my-elmode-dir (concat emacs-lisp-dir "elmodes/"))
(setq load-path
      (append load-path (list my-elmode-dir)))


;; ============================================================================
;;  START OF PERSONAL CONFIG
;; ============================================================================

;(set-default-font "Terminus-12")
(set-default-font "LucidaTypewriter:style=Sans")

(require 'exwm)
(require 'exwm-config)
;; (exwm-config-default)
(require 'exwm-systemtray)
;; (exwm-systemtray-enable)
(setq exwm-workspace-number 10)
;; TODO: change font

(add-to-list 'load-path "~/.emacs.d/lisp")

;; epitech's old useless config
(load "std.el")
(load "std_comment.el")

;; evil shenanigans
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode t)
(setq evil-want-fine-undo t)    ; vim-like undo
(require 'evil-surround)
(global-evil-surround-mode t)   ; vim-like surround

;; key bindings redone after evil fucks things up
(global-set-key (kbd "C-h") 'help)


;; auto-complete
(ac-config-default)
(global-auto-complete-mode t)

;; c config
(add-hook 'c-mode-hook (lambda () (setq comment-start "/*"
                                        comment-continue "**"
                                        comment-end "*/"
                                        indent-tabs-mode 1)))
(setq c-default-style "linux")

;; c++ config
(add-hook 'c++-mode-hook (lambda () (setq comment-start "/*"
                                          comment-continue "**"
                                          comment-end "*/"
                                          indent-tabs-mode 1
                                          flycheck-gcc-include-path (list "/usr/include/qt"  "/usr/include/qt/QtCore" "/usr/include/qt/QtWidgets"))))

;; js
(add-hook 'js-mode-hook (lambda () (setq comment-start "/*"
                                         comment-continue "**"
                                         comment-end "*/"
                                         indent-tabs-mode nil)))
(add-hook 'typescript-mode-hook (lambda () (setq comment-start "/*"
                                         comment-continue "**"
                                         comment-end "*/"
                                         indent-tabs-mode nil)))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes

;; plantuml
(global-set-key (kbd "C-x C-u") 'plantuml-preview)
(setq plantuml-output-type "png")

;; general config
(require 'whitespace)
(global-whitespace-mode t)
(setq whitespace-line-column 79
      whitespace-style '(face tabs trailing lines-tail space-before-tab indentation empty space-after-tab tab-mark))
(setq column-number-mode t)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(icomplete-mode)                ; better minibuffer completion
(electric-pair-mode)            ; auto-pair
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit) ; auto-pair only when needed
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq-default indent-tabs-mode t)
(yas-global-mode 1)             ; yasnippet
(savehist-mode 1)               ; history accross sessions
(filesets-init)
(setq scroll-conservatively 2000) ; scroll by line, not half a screen
(global-auto-revert-mode 1)     ; automaticaly refresh files
(define-key evil-normal-state-map (kbd "SPC f") 'link-hint-open-link)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'find-file-hook (lambda () (rainbow-mode t)))
(add-hook 'find-file-hook (lambda () (rainbow-delimiters-mode t)))

(defun find-files (files) ; open multiple files
  (find-file (car files))
  (if (cdr files)
      (find-files (cdr files))))
(defun open-dir (dir match) (find-files (directory-files-recursively dir match))) ; :find and open all files recursively from dir matching match

                                        ;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-hook 'after-init-hook (lambda () (if (display-graphic-p) (load-theme 'ample))))

(add-hook 'after-init-hook (lambda () (scroll-bar-mode -1)))
(add-hook 'after-init-hook (lambda () (menu-bar-mode -1)))
(add-hook 'after-init-hook (lambda () (tool-bar-mode -1)))


;; ============================================================================
;;  END OF PERSONAL CONFIG
;; ============================================================================

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t nil))))

;; '(ac-candidate-face ((t (:background "#232c31" :foreground "white smoke"))))
;; '(popup-menu-summary-face ((t (:inherit popup-summary-face))))
;; '(popup-summary-face ((t (:background "#232c31" :foreground "white smoke"))))
;; '(popup-tip-face ((t (:background "black" :foreground "gray"))))
;; '(whitespace-indentation ((t (:background "        #232c31" :foreground "#cc6666"))))
;; '(whitespace-tab ((t (:background "#232c31" :foreground "gray30" :strike-through t)))))
