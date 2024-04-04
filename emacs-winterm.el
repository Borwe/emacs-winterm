(defun emacs-winterm/zig-exists-p ()
  (executable-find "zig"))

(defun emacs-winterm/getlibrary-path ()
  (concat (file-name-parent-directory (locate-library "emacs-winterm.el"))))

(defun emacs-winterm/get-emacs-include-path ()
  (concat (file-name-parent-directory invocation-directory) "include"))

(defun emacs-winterm/build-lib (header-dir workd-dir)
  (let* ((command (format "cd %s && zig build -- %s" workd-dir header-dir))
		 (build-success (shell-command command)))
	(if (equal 0 build-success)
		(message "Build success"))))

(defun emacs-winterm/build-and-install ()
  "Build the dynamic zig library for package to work"
  (interactive)
  (message "Beggining build setup")
  (let ((emacs-modules-header (emacs-winterm/get-emacs-include-path))
		(emacs-winterm-dir (emacs-winterm/getlibrary-path)))
	(message "emacs header dir is %s" emacs-modules-header)
	(if (emacs-winterm/zig-exists-p)
		(progn
		  (message "Found zig executable")
		  (emacs-winterm/build-lib emacs-modules-header emacs-winterm-dir))
	  (error "Couldn't find zig in your path, please install and set it to go further"))))


