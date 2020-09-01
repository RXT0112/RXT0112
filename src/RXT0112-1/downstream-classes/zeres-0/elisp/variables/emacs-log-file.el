#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;; Created by Jacob Hrbek identified with an electronic mail <kreyren@rixotstudio.cz> and GPG signature <0x765AED304211C28410D5C478FCBA0482B0AB9F10> under all rights reserved in 26/08/2020 11:11:38 CEST

;; RELEVANT: XDG specification used for non-standard file hiearchy on unix https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

(require 'cl-lib)

;; FIXME-QA: Wrap defvar simmilar to defun so that we can use 'var-name'
(zn-defvar emacs-log-file
	(cl-case system-type
		((gnu gnu/linux gnu/kfreebsd darwin cygwin aix berkeley-unix hpux irix usg-unix-v)
			;;; Find the file to write logs into
			;;; On Linux this should be writing in '/var/log/emacs/emacs-version/emacs.log' assuming it being present else '$HOME/.local/share/emacs/emacs-version/emacs.log'
			(cond ;; Check if we can use XDG_DATA_HOME variable
				;; Check if we can write in /var/log/emacs/emacs-version/emacs.log
				((file-writable-p (format "%1$s%2$s%3$s" "/var/log/emacs/" emacs-build-number "/emacs.log"))
					(concat (format "%1$s%2$s%3$s" "/var/log/emacs/" emacs-build-number "/emacs.log")) )
				((> (length (getenv "XDG_DATA_HOME")) 0)
					;; FIXME-QA: Make sure that XDG_DATA_HOME is present
					(cond
						((file-writable-p (concat (getenv "XDG_DATA_HOME") (format "%1$s%2$s" "/emacs/" emacs-build-number "/emacs.log")))
							(concat (getenv "XDG_DATA_HOME") (format "%1$s%2$s" "/emacs/" emacs-build-number "/emacs.log")) )
						(t
							(princ "FATAL: %1$s\n" (format "Path '%1$s' is not writable and thus can not be used for a logging file" (concat (getenv "XDG_DATA_HOME") (format "%1$s%2$s" "/emacs/" emacs-build-number "/emacs.log")))) )
					)
				)
				((= (length (getenv "XDG_DATA_HOME")) 0)
					;; FIXME-QA: Make sure that HOME is present
					;; FIXME-QA: Make sure that HOME is writable
					(cond
						((> (length (getenv "HOME")) 0)
							;; FIXME-QA: Output message inside zn-defvar's argument without getting 'Invalid function' fatal err
							;;(princ "WARN: %1$s\n" (format "Variable 'XDG_DATA_HOME' is storing a blank value '%1$s' and so it can't be used for logging, using '%2$s'" (getenv "XDG_DATA_HOME") (concat (getenv "HOME")"/emacs.log") ))
							(concat (getenv "HOME")"/emacs.log") )
						(t
							(princ "WARN: %1$s\n" (format "Unable to define variable '%1s$' as variable 'HOME' is storing a blank value '%2$s', thus we are unable to generate a log file" var-name (getenv HOME)))
							(concat nil))
					)
				)
				(t
					(princ (format "BUG: %1$s\n" (format "Unexpected happend while defining variable '%1$s' checking for the lenght of 'XDG_DATA_HOME' variable that stores value '%2$s'" var-name (getenv XDG_DATA_HOME))))
					(append-to-file (format die-format-string-bug (format die-format-string-bug (format "Unexpected happend while defining variable '%1$s' checking for the lenght of 'XDG_DATA_HOME' variable that stores value '%2$s'" var-name (getenv "XDG_DATA_HOME")))) nil emacs-log-file)
					(kill-emacs 250) )
			)
		)
		((windows-nt ms-dos)
			;; FIXME: Provide a default INITVALUE that contains a sane path to be used for a logging file
			(princ (format "FIXME: %1$s\n" (format "Platform '%1$s' is not implemented in a non-standard variable '%2$s' to provide INITVALUE" system-type var-name)))
			(kill-emacs 28) )
		(t
			(princ (format "UNEXPECTED: %1$s\n" (format "Platform '%1$s' is not implemented in defining variable '%2$s'" system-type var-name)))
			(append-to-file (format "UNEXPECTED: %1$s\n" (format "Platform '%1$s' is not implemented in function '%2$s' to handle assertion for argument '%3$s'" system-type function-name exitcode)) nil emacs-log-file )
			(kill-emacs 250) )
	)
	"Non-standard variable used by logging backend of the zernit project to generate a log file using programming logic implemented by zernit project

	On linux this expects environmental variables:
	- XDG_DATA_HOME: Used for finding a location used for a log file, if not set it uses HOME/emacs.log
	- HOME: Used for finding a location for a log file in case XDG_DATA_HOME is not set, sets itself to 'nil' if HOME is not writable"
)
