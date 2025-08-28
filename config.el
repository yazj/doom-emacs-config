;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq auto-save-default t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(setq lsp-pyright-plugins-ruff-enabled t)

;;(use-package! dict
;;  :config
;;  (setq dict-server "dict.org")
;;  (setq dict-lookup-function 'dict-search))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 21 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16))

;; 中文字体设置
(when (display-graphic-p)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font t
                      charset
                      (font-spec :family "LXGW WenKai" :size 26))))

;; 调整中英文对齐
(setq face-font-rescale-alist
      '(("LXGW WenKai" . 1.4)))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'tango)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/workstation/org")

;; org-roam
(after! org-roam
  (setq org-roam-directory "~/workstation/org/roam")  ;; 笔记存放目录
  (org-roam-db-autosync-mode))


;;设置初始为emacs模式而不是evil
(setq evil-default-state 'emacs)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ==============================
;; Org 美化配置
;; ==============================


;; 启用 org-modern
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config

  ;; 星号替换（标题前的 bullet）
  (setq org-modern-star '("◉" "○" "✿" "✸" "◆" "▶")) ;; 不同层级用不同符号

  ;; 隐藏多余的星号，只显示一个
  (setq org-modern-hide-stars 'leading)

  ;; 美化 TODO 标签
  (setq org-todo-keywords
        '((sequence "⚪ TODO(t)" "🔵 NEXT(n)" "🟡 WAITING(w)" "|" "✅ DONE(d)" "❌ CANCELED(c)")))

  (setq org-modern-todo-faces
        '(("TODO"     . (:background "#ff6c6b" :foreground "white" :weight bold :box (:line-width (1 . 1) :style released-button)))
          ("NEXT"     . (:background "#c678dd" :foreground "white" :weight bold :box (:line-width (1 . 1) :style released-button)))
          ("WAITING"  . (:background "#ECBE7B" :foreground "black" :weight bold :box (:line-width (1 . 1) :style released-button)))
          ("DONE"     . (:background "#98be65" :foreground "black" :weight bold :box (:line-width (1 . 1) :style released-button)))
          ("CANCELED" . (:background "#5B6268" :foreground "white" :weight bold :box (:line-width (1 . 1) :style released-button)))))
  (setq org-modern-todo-icon
      '(("TODO" . "⚪")
        ("NEXT" . "🔵")
        ("WAITING" . "🟡")
        ("DONE" . "✅")
        ("CANCELED" . "❌")))

  ;; 美化折叠符号
  (setq org-ellipsis " ⤵ "
        org-modern-ellipsis " ⤵ ")  ;; 美化折叠箭头

  ;; 表格线美化
  (setq org-modern-table nil) ;; 如果你用 org-modern-table，表格会更紧凑
  (setq org-modern-horizontal-rule "────────────") ;; 分隔线样式

  ;; 美化引用块 (quote / src)
  (setq org-modern-block-name '("⟦" . "⟧")) ;; 代码块标题符号
  (setq org-modern-keyword "⚙")             ;; #+KEYWORD 渲染符号
  (setq org-modern-priority
        '((?A . (:foreground "#ff6c6b" :weight bold))
          (?B . (:foreground "#ECBE7B" :weight bold))
          (?C . (:foreground "#98be65" :weight bold))))

)


(setq org-hide-emphasis-markers t)

;; valign：表格对齐（尤其是中日韩字符）
(use-package! valign
  :hook (org-mode . valign-mode))

;; Org 层级缩进，看起来更有结构感
(setq org-startup-indented t)

;; 默认折叠内容，保持整洁
(setq org-startup-folded t)

;; Org 快捷键绑定
(map! :after org
      :map org-mode-map
      "C-c %" #'org-mark-ring-goto)

;; ==============================
;; Org LaTeX 配置
;; ==============================

(after! org

  ;; 美化 deadline & scheduling 提示
  (setq org-deadline-warning-days 7) ;; 提前一周提醒
  (setq org-log-done 'time)          ;; DONE 记录完成时间
  (setq org-log-into-drawer t)

  ;; 禁用org-superstar-mode
  (remove-hook 'org-mode-hook #'org-superstar-mode)

  ;; 使用 dvisvgm 渲染公式（矢量高清）
  (setq org-preview-latex-default-process 'dvisvgm)

  ;; 打开 Org 文件时自动渲染公式
  (setq org-startup-with-latex-preview t)

  ;; 渲染公式缩放比例
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 0.6))

  ;; 自定义 dvisvgm 流程，确保不会报 File wasn’t produced
  (setq org-preview-latex-process-alist
        '((dvisvgm
           :programs ("latex" "dvisvgm")
           :description "dvi > svg"
           :message "请安装 latex 和 dvisvgm"
           :use-xcolor t
           :image-input-type "dvi"
           :image-output-type "svg"
           :image-size-adjust (1.7 . 1.5)
           :latex-compiler ("latex -interaction nonstopmode -output-directory %o %f")
           :image-converter ("dvisvgm %f -n -b min -c %S -o %O"))))

)


;; ==============================
;; org-fragtog：光标进入显示源码，离开渲染公式
;; ==============================
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

;; ==========================
;; all-the-icons (美化图标)
;; ==========================
(use-package! all-the-icons)


;; 启用 Org Super Agenda
(use-package! org-super-agenda
  :after org
  :config
  ;; 定义分组
  (setq org-super-agenda-groups
        '((:name "Today"
                 :time-grid t
                 :todo "TODAY"
                 :order 0)
          (:name "Important"
                 :priority "A"
                 :order 1)
          (:name "Long-term"
                 :todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
                 :tag "longterm"
                 :order 2)
          (:name "Work"
                 :tag "work"
                 :order 3)
          (:name "Personal"
                 :tag "personal"
                 :order 4)
          (:name "Study"
                 :tag "study"
                 :order 5)
          (:name "Fun"
                 :tag "fun"
                 :order 6)))

  ;; 启用 super agenda
  (org-super-agenda-mode))

;; TODO 状态颜色
(setq org-todo-keyword-faces
      '(("TODO"       . (:foreground "orange" :weight bold))
        ("TODAY"      . (:foreground "deep sky blue" :weight bold))
        ("WAITING"    . (:foreground "magenta" :weight bold))
        ("DONE"       . (:foreground "green" :weight bold))
        ("SOMEDAY"    . (:foreground "gray" :weight bold))
        ("TO-READ"    . (:foreground "violet" :weight bold))
        ("CHECK"      . (:foreground "gold" :weight bold))
        ("TO-WATCH"   . (:foreground "cyan" :weight bold))
        ("WATCHING"   . (:foreground "light green" :weight bold))))

;; Agenda 前缀格式
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " %i %-12:c [%e] ")
        (tags   . " %i %-12:c [%e] ")
        (search . " %i %-12:c [%e] ")))

;; 隐藏标签
(setq org-agenda-hide-tags-regexp ".*")

;; 排序策略
(setq org-agenda-sorting-strategy
      '((agenda habit-down time-up priority-down category-keep)
        (todo priority-down category-keep)
        (tags priority-down category-keep)
        (search category-keep)))
