;;; desktop/exwm/config.el -*- lexical-binding: t; -*-

;; emacs window manager !!
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)
(require 'exwm-randr)
(setq exwm-randr-workspace-output-plist '(0 "eDP-1"))
(add-hook 'exwm-randr-screen-change-hook
          (lambda ()
            (start-process-shell-command
             "xrandr" nil "xrandr --output eDP-1")))
(exwm-randr-enable)

;; system tray
(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; better firefox experience in exwm
(require 'exwm-firefox-evil)
(add-hook 'exwm-manage-finish-hook 'exwm-firefox-evil-activate-if-firefox)

;; add something to firefox
(dolist (k `(escape))
  (cl-pushnew k exwm-input-prefix-keys))
