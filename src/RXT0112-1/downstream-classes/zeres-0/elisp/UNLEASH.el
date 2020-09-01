#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;; Created by Jacob Hrbek identified with an e-mail <kreyren@rixotstudio.cz> and GPG signature <0x765AED304211C28410D5C478FCBA0482B0AB9F10> under all rights reserved in 26/08/2020 11:11:38 CEST

;; WARNING: NOT IMPLEMENTED!
;(message "NOT IMPLEMENTED!")
;(kill-emacs 36)

(require 'cl-lib)

;; Source wrappers
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/wrappers/zn-defun.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/wrappers/zn-defvar.el")

;; Source variables
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/variables/emacs-debug.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/variables/emacs-log-file.el")

;; Source functions
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/output/die.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/output/ewarn.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/output/einfo.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/output/efixme.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/output/edebug.el")
(load "/home/kreyren/Repositories/Zernit/src/RXT0112-1/downstream-classes/zeres-0/elisp/output/eerror.el")
