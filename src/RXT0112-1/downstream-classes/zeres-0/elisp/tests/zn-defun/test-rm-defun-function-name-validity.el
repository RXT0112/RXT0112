#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;;; TEST: Make sure that function-name stores valid name
;; FIXME: Implement cl-case instead of cond for better readability (https://www.gnu.org/software/emacs/manual/html_node/cl/Conditionals.html)
(zn-defun test-rm-defun-function-name-validity (message)
	(cond
		((string-equal function-name "test-rm-defun-function-name-validity")
			(message "Test for checking function-name validity passed, variable 'function-name' stores '%s' for function name 'test-rm-defun-function-name-validity'", function-name)
			(cond
				((string-equal system-type "gnu/linux")
					(kill-emacs 1))
				((string-equal system-type "windows-nt")
					(kill-emacs 0))
				(t
					(message "BUG: Function 'test-rm-defun-function-name-validity' triggered unexpected logic for system type '%s' for killing emacs as a result of failed test" system-type)
					(kill-emacs 250))
			)
		;; DNM
		((if (string= function-name "test-rm-defun-function-name-validity") '() t)
			(message "Test for checking function-name validity failed, variable function-name stores value '%s' when expected is 'test-rm-defun-function-name-validity'" function-name)
			(cond
				((string-equal system-type "gnu/linux")
					(kill-emacs 1))
				((string-equal system-type "windows-nt")
					(kill-emacs 0))
				(t
					(message "BUG: Function 'test-rm-defun-function-name-validity' triggered unexpected logic for system type '%s' for killing emacs as a result of failed test" system-type)
					(kill-emacs 250))
			)
		((= (length function-name) 0)
			(message "Test for checking function-name validity failed, variable function-name stores value '%s'" function-name)
			(cond
				((string-equal system-type "gnu/linux")
					(kill-emacs 1))
				((string-equal system-type "windows-nt")
					(kill-emacs 0))
				(t
					(message "BUG: Function 'test-rm-defun-function-name-validity' triggered unexpected logic for system type '%s' for killing emacs as a result of failed test" system-type)
					(kill-emacs 250))
			)
		)
		(t
			(message "BUG: Function 'test-rm-defun-function-name-validity' triggered unexpected logic for checking lenght of variable 'function-name' with value %s" function-name)
			(kill-emacs 250))
		)
	)
)
