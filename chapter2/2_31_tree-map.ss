;;;map & tree
(define (scale-tree tree factor)
  (cond ((null? tree) ())
        ((pair? tree) (cons (scale-tree (car tree) factor)
                            (scale-tree (cdr tree) factor)))
        (else (* tree factor))))
;;;test
(define x (list 1 (list 2 (list 3 4) 5 ) (list 6 7)))
(display (scale-tree x 10))
;;;with map
(define (scale-tree-with-map tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree-with-map sub-tree factor)
             (* factor sub-tree)))
       tree))
(newline)
(display (scale-tree-with-map x 10))
;;;
(define (tree-map-0 proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map-0 proc sub-tree)
             (proc sub-tree)))
       tree))
(define (tree-map-1 proc tree)
  (cond ((null? tree) ())
        ((pair? tree) (cons (tree-map-1 proc (car tree))
                            (tree-map-1 proc (cdr tree))))
        (else (proc tree))))
  
(load "d:\\sicp\\aux_\\math.ss")
(newline)
(display (tree-map-1 square x))
(newline)
(display (tree-map-0 square x))