;;; init-third-packages --- settings for third-party packages (sorted by package names)
;;; Commentary:
;;; Code:

;; benchmark-init
(use-package benchmark-init
  :ensure t
  :config (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; Settings for company, auto-complete only for coding.
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :config (setq company-show-quick-access 'left
		company-minimum-prefix-length 1
		company-format-margin-function nil))

;; Settings for exec-path-from-shell
;; fix the PATH environment variable issue
(use-package exec-path-from-shell
  :ensure t
  :when (or (memq window-system '(mac ns x))
	    (unless cabins-os-win
	      (daemonp)))
  :init (exec-path-from-shell-initialize))

;; format all, formatter for almost languages
;; great for programmers
(use-package format-all :ensure t
  ;; enable format on save with format-all-mode
  :hook ((prog-mode . format-all-mode))
  ;; 	   (format-all-mode . format-all-ensure-formatter))
  ;; and bind a shortcut to manual format
  :commands (format-all-buffer format-all-region-or-buffer format-all-mode)
  :bind ("C-c f" . #'format-all-region-or-buffer))

;; iedit - edit same text in one buffer or region
(use-package iedit
  :ensure t
  :bind ("C-;" . iedit-mode))

;; move-dup, move/copy line or region
(use-package move-dup
  :ensure t
  :hook (after-init . global-move-dup-mode))

;; Markdown file support
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\markdown\\'" . markdown-mode)))

;; Protobuf file support
(use-package protobuf-mode
  :ensure t
  :mode "\\.proto\\'")

;; Run code
(use-package quickrun
  :ensure t
  :commands (quickrun quickrun-region))
;;:when (derived-mode-p 'prog-mode))

;; HTTP Request
(use-package restclient
  :ensure t
  :mode (("\\.http\\'" . restclient-mode)))

;; project
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (setq projectile-project-search-path '("~/projects/"))
  (setq projectile-completion-system 'auto))

;; translate
(use-package maple-translate
  :ensure nil
  :commands (maple-translate maple-translate+)
  :bind ("C-x q" . maple-translate)
  :config
  (setq maple-translate-engine 'youdao)
  ;; or use multi engines
  (setq maple-translate-engine '(youdao dictcn))
  ;; custom result with different section
  (setq maple-translate-section '(phonetic basic detail morphology phrase sentence))
  ;; with google translate
  (setq maple-translate-google-url "https://translate.googleapis.com/translate_a/single")
  (setq maple-translate-google-proxies
	'(("http" . "127.0.0.1:1086")
          ("https" . "127.0.0.1:1086")))
  ;; with offline sdcv
  (setq maple-translate-sdcv-dir "~/.emacs.d/.stardict/dicts")
  (setq maple-translate-sdcv-dicts
	'(("lazyworm-ec" . "stardict-lazyworm-ec-2.4.2")
          ("lazyworm-ce" . "stardict-lazyworm-ce-2.4.2"))))

;; flycheck
(use-package flycheck
  :ensure t  ;; 手动下载就改成 :ensure nil，并且加 load-path
  :init
  (global-flycheck-mode)
  :config
  (setq byte-compile-warnings '(not free-vars))  ;(not free-vars) 表示除了未使用变量，其它警告都保留
  )

(provide 'init-third-packages)

;;; init-third-packages.el ends here
