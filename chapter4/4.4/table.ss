;implementation of data directed programming, copy from ch3, a little
;modified
(define (make-table)
  (list '*table*))
(define (put_ tag1 tag2 value table)
  (let ((record1 (assoc tag1 (cdr table))))
    (if record1
        (let ((record2 (assoc tag2 (cdr record1))))
          ;(display record1)(newline)
          ;(display record2)(newline)
          (if record2
              (set-cdr! record2 value)
              (set-cdr! record1 (cons (cons tag2 value) (cdr record1)))))
        (set-cdr! table (cons 
                         (cons tag1 (list (cons tag2 value)))
                         (cdr table))))))
(define (get_ tag1 tag2 table);;return the corresponding value if exist
  (let ((record1 (assoc tag1 (cdr table))))
    ;(display "get in two-dimenson-table.ss is called")
    (if record1
        (let ((record2 (assoc tag2 (cdr record1))))
          (if record2
              (cdr record2)
              #f))
        #f)))
;*****
(define local-table (make-table))
(define (put tag1 tag2 value)
  (put_ tag1 tag2 value local-table))
(define (get tag1 tag2)
  (get_ tag1 tag2 local-table))