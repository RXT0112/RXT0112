#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;; Created by Jacob Hrbek identified with an electronic mail <kreyren@rixotstudio.cz> and GPG signature <0x765AED304211C28410D5C478FCBA0482B0AB9F10> under all rights reserved in 26/08/2020 11:11:38 CEST

;; FIXME-QA: Wrap defvar simmilar to defun so that we can use 'var-name'
(zn-defvar emacs-log-file
	(cl-case system-type
		((gnu gnu/linux gnu/kfreebsd darwin cygwin aix berkeley-unix hpux irix usg-unix-v)
			(cond ;; Check if we can use XDG_DATA_HOME variable
				((= (lenght (getenv "XDG_DATA_HOME")) 0)
					;; FIXME-QA: Make sure that HOME is present
					;; FIXME-QA: Make sure that HOME is writable
					(string (getenv "HOME")"emacs.log") )
				((> (lenght (getenv "XDG_DATA_HOME")) 0)
					;; FIXME-QA: Make sure that XDG_DATA_HOME is present
					;; FIXME-QA: Make sure that XDG_DATA_HOME is writable
					(string (getenv "XDG_DATA_HOME")"emacs/emacs.log") )
				(t
					(princ (format die-format-string-bug (format "Unexpected happend while defining variable '%1$s' checking for the lenght of 'XDG_DATA_HOME' variable that stores value '%2$s'" var-name (getenv XDG_DATA_HOME))))
					(append-to-file (format die-format-string-bug (format die-format-string-bug (format "Unexpected happend while defining variable '%1$s' checking for the lenght of 'XDG_DATA_HOME' variable that stores value '%2$s'" var-name (getenv "XDG_DATA_HOME")))) nil emacs-log-file)
					(kill-emacs 250) )
			)
		)
		((windows-nt ms-dos)
			;; FIXME: Provide a default INITVALUE that contains a sane path to be used for a logging file
			(princ (format die-format-string-fixme (format "Platform '%1$s' is not implemented in a non-standard variable '%2$s' to provide INITVALUE" system-type var-name)))
			(kill-emacs 28) )
		(otherwise
			(princ (format die-format-string-unexpected (format "Platform '%1$s' is not implemented in defining variable '%2$s'" system-type var-name)))
			(append-to-file (format die-format-string-unexpected (format "Platform '%1$s' is not implemented in function '%2$s' to handle assertion for argument '%3$s'" system-type function-name exitcode)) nil emacs-log-file )
			(kill-emacs 250) )
	)
	"Non-standard variable used by logging backend of the zernit project to generate a log file using programming logic, This must be set otherwise the function is going to fail."
)
