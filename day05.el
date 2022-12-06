(defun read-lines (file)
  "Read a file line by line and add every line to a list until a blank line is encountered, then create a new list and start adding lines to that list."
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (let ((lines-list '())
          (current-list '()))
      (while (not (eobp))
        (let ((line (buffer-substring-no-properties
                     (line-beginning-position)
                     (line-end-position))))
          (if (string-match-p "^\\s-*$" line)
              (progn
                (setq lines-list (cons current-list lines-list))
                (setq current-list '()))
            (setq current-list (cons line current-list)))
          (forward-line)))
      (when current-list
        (setq lines-list (cons current-list lines-list)))
      (reverse (mapcar #'reverse lines-list) ))))

(defun convert-to-columns (string-list)
  "Convert a list of strings into a list of columns."
  (let ((max-len (apply 'max (mapcar 'length string-list))))
    (mapcar (lambda (n)
              (mapconcat (lambda (s) (char-to-string (aref s n)))
                         string-list ""))
            (number-sequence 0 (1- max-len)))))

(defun filter-and-trim (string-list)
  "Filter a list of strings to those that start with a digit and return the strings after the digits."
  (let ((digit-regexp "^ *[0-9]+"))
    (delq nil
          (mapcar (lambda (s)
                    (if (string-match digit-regexp s)
                        (reverse (string-to-list (string-trim-right (substring s (match-end 0)))))
                      nil))
                  string-list))))

(defun extract-values (string)
  "Extract integer values A, B and C from a string of the form 'move A from B to C'."
  (string-match "move \\([0-9]*\\) from \\([0-9]*\\) to \\([0-9]*\\)" string)
  (mapcar (lambda (i) (string-to-number (match-string i string))) '(1 2 3)))

(defun part-1 (stack instructions)
  "Solve Part 1"
  (dolist (instruction instructions)
    (dotimes (i (nth 0 instruction))
      (let* ((from (1- (nth 1 instruction)))
             (to (1- (nth 2 instruction)))
             (from-list (nth from stack))
             (to-list (nth to stack)))
        (setf (nth from stack) (cdr from-list))
        (setf (nth to stack) (cons (car from-list) to-list)))))
  (message "Answer 1: %s" (string-join (mapcar #'char-to-string (mapcar #'car stack)) "")))

(defun part-2 (stack instructions)
  "Solve Part 2"
  (dolist (instruction instructions)
    (let* ((from (1- (nth 1 instruction)))
           (to (1- (nth 2 instruction)))
           (sz (nth 0 instruction))
           (from-list (nth from stack))
           (to-list (nth to stack)))
      (setf (nth from stack) (seq-subseq from-list sz))
      (setf (nth to stack) (append (seq-subseq from-list 0 sz) to-list))))
  (message "Answer 2: %s" (string-join (mapcar #'char-to-string (mapcar #'car stack)) "")))

(let* ((sections (read-lines "input/day05.txt"))
       (stack0 (nth 0 sections))
       (instructions0 (nth 1 sections))
       (stack1 (convert-to-columns stack0))
       (stack (filter-and-trim (mapcar #'reverse stack1)))
       (instructions (mapcar #'extract-values instructions0)))
  (part-1 (mapcar #'copy-sequence stack) instructions)
  (part-2 (mapcar #'copy-sequence stack) instructions))
