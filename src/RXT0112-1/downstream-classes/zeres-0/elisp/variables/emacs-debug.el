#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;; Created by Jacob Hrbek identified with an electronic mail <kreyren@rixotstudio.cz> and GPG signature <0x765AED304211C28410D5C478FCBA0482B0AB9F10> under all rights reserved in 26/08/2020 11:11:38 CEST

(defvar
	emacs-debug
	0 ;; Disable debugging
	"Non-standard variable used to output hardcodded logic in zernit"
)
