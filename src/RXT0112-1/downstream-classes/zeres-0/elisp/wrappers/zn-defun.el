#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;; Created by Jacob Hrbek identified with email kreyren@rixotstudio.cz and gpg key 0x765AED304211C28410D5C478FCBA0482B0AB9F10 under all rights reserved in 27/08/2020 21:57:59 CEST

;;;! Wrapper for standard function 'defun'
;;;! Currently allows to reference a variable 'function-name' to use function name
(defmacro zn-defun (name args &rest body)
	"Wrapper for standard function 'defun'"
	;; Store the function name in function-name variable
	(declare (indent 2))
	`(defun ,name ,args
		(let ((function-name ',name))
			,@body)
		)
)
