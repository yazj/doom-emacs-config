;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
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
(setq org-directory "~/workstation/org/todos/")


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
;;
;; ========================================================
;;

;; ==================
;; emacs配置
;; ==================

;;设置初始为emacs模式而不是evil
(setq evil-default-state 'emacs)

;; 设置自动保存
(setq auto-save-default t)

;; 启动自动全屏并且最大化
(if (eq initial-window-system 'x)
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(global-set-key (kbd "C-c C-p") #'+treemacs/toggle)

;; =================
;; 字体和界面
;; =================

;; mode-line 显示电池剩余电量
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))

;; mode-line 显示时间
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-format "%Y-%m-%d %H:%M")  ;; 年-月-日 时:分

;; 字体设置
(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16))
;; 中文字体设置
(when (display-graphic-p) (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font t charset (font-spec :family "LXGW WenKai" :size 26))))
;; 调整中英文对齐
(setq face-font-rescale-alist
      '(("LXGW WenKai" . 1.4)))
;; 全局字体优化
(set-face-attribute 'bold nil
                    :foreground "#2e7d32"  ;; 柔和绿色，比原来亮度低
                    :weight 'bold
                    :underline nil
                    :overline nil)
(set-face-attribute 'italic nil
                    :foreground "#b45309"  ;; 橙色，白底可读
                    :slant 'italic
                    :weight 'normal)
(set-face-attribute 'fixed-pitch nil
                    :foreground "#3a3a3a"
                    :background "#fff9c4"
                    :weight 'bold
                    :box '(:line-width 1 :color "#ffeaa7" :style released-button)
                    :slant 'normal)
;; (set-face-attribute 'shadow nil
;;                     :foreground "#6b7280"  ;; 仅改变文字颜色
;;                     :background "#e0e0e0"
;;                     :slant 'italic
;;                     :weight 'normal)
(set-face-attribute 'link nil
                    :foreground "#2563eb"
                    :underline t)
(set-face-attribute 'warning nil
                    :foreground "#b91c1c"
                    :weight 'bold)

;; =================
;; package配置
;; =================

;; org-roam
(after! org-roam
  (setq org-roam-directory (file-truename "~/workstation/org/"))
  (org-roam-db-autosync-mode 1)
  (setq org-roam-capture-templates
        '(("m" "main" plain
         "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n#+filetags: :main:\n")
         :immediate-finish t
         :unnarrowed t)
         ("d" "default" plain "%?"
         :if-new (file+head "main/node/${slug}.org"
                            "#+title: ${title}\n#+created: %U\n#+filetags: :node:\n")
         :unnarrowed t)
         ("r" "reference" plain "%?"
         :if-new
         (file+head "reference/${title}.org" "#+title: ${title}\n#+filetags: :reference:\n")
         :immediate-finish t
         :unnarrowed t)
         ("a" "article" plain "%?"
         :if-new
         (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t)))

  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))

  (setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

)

;; 使用 setq! 全局设置分组
(setq! org-super-agenda-groups
       '((:name "Today"
          :time-grid t)
         (:name "Important"
          :priority "A")
         (:name "Start"
          :todo "START")
         (:name "Next Actions"
          :todo "NEXT") ; 还没做，但近期要做的任务
         (:name "Waiting"
          :todo "WAITING") ; 等别人、外部条件的任务
         (:name "Personal"
          :tag "personal")
         (:name "Work"
          :tag "work")
         (:name "Article"
          :tag "article")
         (:name "Reference"
          :tag "reference")
         (:name "Done"
          :todo "DONE" :order 99)))

;; 启用 org-modern
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config

  ;; 星号替换（标题前的 bullet）
  (setq org-modern-star '("◉" "○" "✿" "✸" "◆" "▶")) ;; 不同层级用不同符号

  ;; 隐藏多余的星号，只显示一个
  (setq org-modern-hide-stars 'leading)


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
;; Org 层级缩进，看起来更有结构感
(setq org-startup-indented t)

;; 默认折叠内容，保持整洁
(setq org-startup-folded t)

;; ==============================
;; Org LaTeX 配置
;; ==============================

(after! org

   (setq org-capture-templates
         '(("s" "Slipbox" entry (file "~/workstation/org/inbox.org")
            "* %?\n")
          ("t" "Todo" entry
           (file "~/workstation/org/todo/todo.org")
           "* TODO %U %?\n")))

   (defun my/org-capture-slipbox ()
     (interactive)
     (org-capture nil "s"))

   (setq org-agenda-files (directory-files-recursively "~/workstation/org/" "\\.org$"))


  (setq org-modern-priority nil)
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

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-day nil ;; i.e. today
      org-agenda-span 1
      org-agenda-start-on-weekday nil)
  :config
  (org-super-agenda-mode))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
