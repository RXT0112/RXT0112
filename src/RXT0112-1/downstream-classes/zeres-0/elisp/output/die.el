#!/bin/sh
":"; exec emacs --script "$0" "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
;; Created by Jacob Hrbek identified with an electronic mail <kreyren@rixotstudio.cz> and GPG signature <0x765AED304211C28410D5C478FCBA0482B0AB9F10> under all rights reserved in 26/08/2020 11:11:38 CEST

;; Formatting string declaration
;;; Success
(defvar die-format-string-success "SUCCESS: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for regular output using success trap")
(defvar die-format-string-success-log "SUCCESS: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for log entry using success trap")
(defvar die-format-string-success-debug "SUCCESS: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging output using success trap")
(defvar die-format-string-success-debug-log "SUCCESS: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging log entry using success trap")
;;; Failure
(defvar die-format-string-failure "FATAL: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for regular output using failure trap")
(defvar die-format-string-failure-log "FATAL: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for log entry using failure trap")
(defvar die-format-string-failure-debug "FATAL: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging output using failure trap")
(defvar die-format-string-failure-debug-log "FATAL: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging log entry using failure trap")
;;; Security
(defvar die-format-string-security "SECURITY: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for regular output using security trap")
(defvar die-format-string-security-log "SECURITY: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for log entry using security trap")
(defvar die-format-string-security-debug "SECURITY: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging output using security trap")
(defvar die-format-string-security-debug-log "SECURITY: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging log entry using security trap")
;;; Fixme
(defvar die-format-string-fixme "FIXME: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for regular output using fixme trap")
(defvar die-format-string-fixme-log "FIXME: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for log entry using fixme trap")
(defvar die-format-string-fixme-debug "FIXME: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging output using fixme trap")
(defvar die-format-string-fixme-debug-log "FIXME: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging log entry using fixme trap")
;;; Bug
(defvar die-format-string-bug "BUG: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for regular output using bug trap")
(defvar die-format-string-bug-log "BUG: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for log entry using bug trap")
(defvar die-format-string-bug-debug "BUG: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging output using bug trap")
(defvar die-format-string-bug-debug-log "BUG: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging log entry using bug trap")
;;; Unexpected
(defvar die-format-string-unexpected "UNEXPECTED: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for regular output using unexpected trap")
(defvar die-format-string-unexpected-log "UNEXPECTED: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for log entry using unexpected trap")
(defvar die-format-string-buunexpectedg-debug "UNEXPECTED: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging output using unexpected trap")
(defvar die-format-string-unexpected-debug-log "UNEXPECTED: %s\n" "Non-standard variable storing formatting string for non-standard function `die' to be used for debugging log entry using unexpected trap")

;; FIXME-TEST: Make sure that function 'die' works after changes
(zn-defun die (exitcode &optional message)
"Reimplementation of a non-standard function provided by the Zernit project (https://github.com/RXT0112/Zernit/blob/master/src/RXT0112-1/downstream-classes/zeres-0/bash/output/die.sh) into an emacs lisp that allow assertion of elisp runner with specified exit code and message with logging and debugging.

Due to the cross-platform compatibility the function is using strings for the exit codes instead of numerical values.
- true - Returns 0 on linux and 1 on windows to exit successfully
- false - Returns 1 on linux and 0 on windows for general failure
- security - Returns 28, used to fail safely in case security threat is detected
- fixme - Returns 36, used for unimplemented features
- bug - Returns 250, used to capture bugs in the wild
- unexpected - Returns 255, used for unexpected behavior

Messages are optional, if no message is provided the function will use a hardcoded message which should be avoided when the message might me inaccurate to the failure point to avoid user confusion.

Formatting strings of the messages are variables designed to be customized on demand using variables:
- '<function-name>-format-string-<exitcode>' for regular messages
- '<function-name>-format-string-<exitcode>-debug' for regular messages with debugging enabled
- '<function-name>-format-string-<exitcode>-log' for logging output in path defined in non-standard variable `emacs-log-file'
- '<function-name>-format-string-<exitcode>-log' for logging output in path defined in non-standard variable `emacs-log-file' with debugging enabled

Requires following variables:
- `emacs-log-file' - Non-standard variable used to output logging in a path of file
- `emacs-debug' - Non-standard variable used to set debugging level"

	(pcase exitcode
		("true" ;; Generic success
			(cond
				;; Process the message by lenght and debug state
				((> (length message) 0)
					(cond
						((or (= (length message) 0) (boundp 'message))
							(princ (format die-format-string-success message))
							(append-to-file (format die-format-string-success-log message) nil emacs-log-file) )
						;; FIXME: Implement logic that triggers only when emacs-debug contains 'function-name
						((string-equal emacs-debug function-name)
							(princ (format die-format-string-success-debug message))
							(append-to-file (format die-format-string-success-debug-log message) nil emacs-log-file ) )
						(t
							(princ (format die-format-string-bug "Function '%1$s' with argument '%2$s' triggered unexpected case while processing variable 'emacs-debug' containing value '%3$s'" function-name exitcode emacs-debug)) )
					)
				)
				((or (= (length message) 0) (boundp 'message))
					(princ (format die-format-string-success "Logically determined that processed finished successfully"))
					(append-to-file (format die-format-string-success-log "Logically determined that processed finished successfully") nil emacs-log-file) )
				(t
					(princ (format die-format-string-bug (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)))
					(append-to-file (format die-format-string-bug-log (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)) nil emacs-log-file )
					(kill-emacs 250) )
			)
			(cl-case system-type
				((gnu gnu/linux gnu/kfreebsd darwin cygwin aix berkeley-unix hpux irix usg-unix-v)
					(kill-emacs 0) )
				((windows-nt ms-dos)
					(kill-emacs 1) )
				(otherwise
					(princ (format die-format-string-unexpected (format "Platform '%1$s' is not implemented in function '%2$s' to handle assertion for argument '%3$s'" system-type function-name exitcode)))
					(append-to-file (format die-format-string-unexpected (format "Platform '%1$s' is not implemented in function '%2$s' to handle assertion for argument '%3$s'" system-type function-name exitcode)) nil emacs-log-file ) )
					(kill-emacs 250)
			)
		)
		("false" ;; Generic failure
			(cond
				;; Process the message by lenght and debug state
				((> (length message) 0)
					(cond
						((> (length message) 0)
							(princ (format die-format-string-failure message))
							(append-to-file (format die-format-string-failure-log message) nil emacs-log-file) )
						;; FIXME: Implement logic that triggers only when emacs-debug contains 'function-name
						((string-equal emacs-debug function-name)
							(princ (format die-format-string-failure-debug message))
							(append-to-file (format die-format-string-failure-debug-log message) nil emacs-log-file ) )
						(t
							(princ (format die-format-string-bug "Function '%1$s' with argument '%2$s' triggered unexpected case while processing variable 'emacs-debug' containing value '%3$s'" function-name exitcode emacs-debug)) )
					) )
				((or (= (length message) 0) (boundp 'message))
					(princ (format die-format-string-failure message "Logically determined that process failed"))
					(append-to-file (format die-format-string-failure-log message "Logically determined that processed failed") nil emacs-log-file) )
				(t
					(princ (format die-format-string-bug (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)))
					(append-to-file (format die-format-string-bug-log (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)) nil emacs-log-file )
					(kill-emacs 250) )
			)
			(cl-case system-type
				((gnu gnu/linux gnu/kfreebsd darwin cygwin aix berkeley-unix hpux irix usg-unix-v)
					(kill-emacs 1) )
				((windows-nt ms-dos)
					(kill-emacs 0) )
				(otherwise
					(princ (format die-format-string-unexpected (format "Platform '%1$s' is not implemented in function '%2$s' to handle assertion for argument '%3$s'" system-type function-name exitcode)))
					(append-to-file (format die-format-string-unexpected (format "Platform '%1$s' is not implemented in function '%2$s' to handle assertion for argument '%3$s'" system-type function-name exitcode)) nil emacs-log-file ) )
					(kill-emacs 250)
			)
		)
		("security" ;; Security trap
			(cond
				;; Process the message by lenght and debug state
				((> (length message) 0)
					(cond
						;; FIXME: This does not trigger if message is unbound or ""
						((> (length message) 0)
							(princ (format die-format-string-security message))
							(append-to-file (format die-format-string-security-log message) nil emacs-log-file) )
						;; FIXME: Implement logic that triggers only when emacs-debug contains 'function-name
						((string-equal emacs-debug function-name)
							(princ (format die-format-string-security-debug message))
							(append-to-file (format die-format-string-security-debug-log message) nil emacs-log-file ) )
						(t
							(princ (format die-format-string-bug "Function '%1$s' with argument '%2$s' triggered unexpected case while processing variable 'emacs-debug' containing value '%3$s'" function-name exitcode emacs-debug)) )
					) )
				((or (= (length message) 0) (boundp 'message))
					(princ (format die-format-string-security message "Runtime tripped security trap, exitting for safety"))
					(append-to-file (format die-format-string-security-log message "Runtime tripped security trap, exitting for safety") nil emacs-log-file) )
				(t
					(princ (format die-format-string-bug (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)))
					(append-to-file (format die-format-string-bug-log (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)) nil emacs-log-file )
					(kill-emacs 250) )
			)
			(kill-emacs 28)
		)
		("fixme" ;; Fixme trap
			(cond
				;; Process the message by lenght and debug state
				((> (length message) 0)
					(cond
						;; FIXME: This does not trigger if message is unbound or ""
						((> (length message) 0)
							(princ (format die-format-string-fixme message))
							(append-to-file (format die-format-string-fixme-log message) nil emacs-log-file) )
						;; FIXME: Implement logic that triggers only when emacs-debug contains 'function-name
						((string-equal emacs-debug function-name)
							(princ (format die-format-string-fixme-debug message))
							(append-to-file (format die-format-string-fixme-debug-log message) nil emacs-log-file ) )
						(t
							(princ (format die-format-string-bug "Function '%1$s' with argument '%2$s' triggered unexpected case while processing variable 'emacs-debug' containing value '%3$s'" function-name exitcode emacs-debug)) )
					) )
				((or (= (length message) 0) (boundp 'message))
					(princ (format die-format-string-fixme message "Runtime tripped fixme trap with no message provided, this is likely a bug where developer forgot to provide a message"))
					(append-to-file (format die-format-string-fixme-log message "Runtime tripped fixme trap with no message provided, this is likely a bug where developer forgot to provide a message") nil emacs-log-file) )
				(t
					(princ (format die-format-string-bug (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)))
					(append-to-file (format die-format-string-bug-log (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)) nil emacs-log-file )
					(kill-emacs 250) )
			)
			(kill-emacs 36)
		)
		("bug" ;; Bug trap
			(cond
				;; Process the message by lenght and debug state
				((> (length message) 0)
					(cond
						;; FIXME: This does not trigger if message is unbound or ""
						((> (length message) 0)
							(princ (format die-format-string-bug message))
							(append-to-file (format die-format-string-bug-log message) nil emacs-log-file) )
						;; FIXME: Implement logic that triggers only when emacs-debug contains 'function-name
						((string-equal emacs-debug function-name)
							(princ (format die-format-string-bug-debug message))
							(append-to-file (format die-format-string-bug-debug-log message) nil emacs-log-file ) )
						(t
							(princ (format die-format-string-bug "Function '%1$s' with argument '%2$s' triggered unexpected case while processing variable 'emacs-debug' containing value '%3$s'" function-name exitcode emacs-debug)) )
					) )
				((or (= (length message) 0) (boundp 'message))
					(princ (format die-format-string-bug message "Runtime tripped bug trap with no message provided, this is likely a bug where developer forgot to provide a message"))
					(append-to-file (format die-format-string-bug-log message "Runtime tripped bug trap with no message provided, this is likely a bug where developer forgot to provide a message") nil emacs-log-file) )
				(t
					(princ (format die-format-string-bug (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)))
					(append-to-file (format die-format-string-bug-log (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)) nil emacs-log-file )
					(kill-emacs 250) )
			)
			(kill-emacs 250)
		)
		("unexpected" ;; Unexpected trap
			(cond
				;; Process the message by lenght and debug state
				((> (length message) 0)
					(cond
						;; FIXME: This does not trigger if message is unbound or ""
						((> (length message) 0)
							(princ (format die-format-string-unexpected message))
							(append-to-file (format die-format-string-unexpected-log message) nil emacs-log-file) )
						;; FIXME: Implement logic that triggers only when emacs-debug contains 'function-name
						((string-equal emacs-debug function-name)
							(princ (format die-format-string-unexpected-debug message))
							(append-to-file (format die-format-string-unexpected-debug-log message) nil emacs-log-file ) )
						(t
							(princ (format die-format-string-bug "Function '%1$s' with argument '%2$s' triggered unexpected case while processing variable 'emacs-debug' containing value '%3$s'" function-name exitcode emacs-debug)) )
					) )
				((or (= (length message) 0) (boundp 'message))
					(princ (format die-format-string-unexpected message "Runtime tripped unexpected trap with no message provided, this is likely a bug where developer forgot to provide a message"))
					(append-to-file (format die-format-string-unexpected-log message "Runtime tripped unexpected trap with no message provided, this is likely a bug where developer forgot to provide a message") nil emacs-log-file) )
				(t
					(princ (format die-format-string-bug (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)))
					(append-to-file (format die-format-string-bug-log (format "Function '%1$s' tripped unexpected trap while processing message '%2$s' with argument '%3$s'" function-name message exitcode)) nil emacs-log-file )
					(kill-emacs 250) )
			)
			(kill-emacs 255)
		)
		("" ;; No argument provided
			(princ (format die-format-string-bug (format "No argument was provided in function '%1$s' which is not implemented to handle this scenario" function-name)))
			(kill-emacs 250) )
		(_ ;; unimplemented argument provided
			(princ (format die-format-string-bug (format "Argument '%1$s' is not implemented in function '%2$s'" exitcode function-name)))
			(kill-emacs 250) )
	)
)
