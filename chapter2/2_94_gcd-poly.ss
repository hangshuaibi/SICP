(load "d:\\sicp\\chapter2\\2_91_div-poly.ss")
(define (remainder-terms a b)
  (cadr (div-terms a b)))
;;sample
(define (gcd_ a b)
  (if (= (remainder a b) 0)
      b
      (gcd b (remainder a b))))
(define (gcd-terms a b)
  (let ((remain (remainder-terms a b)))
    (if (empty-termlist? remain)
        b
        (gcd-terms b remain))))
(define (test-code)
  (display (div-terms '(1 1) '(1 0 -1)))(newline)
  (display (div-terms '(1 0 -1) '(1 1)))(newline)
  (display (gcd-terms '(1 0 -1) '(1 1)))(newline)
  (display (gcd-terms '(1 1) '(1 0 -1)))(newline)
  (display (gcd-terms'(1 -1 -1 1) '(1 -1 0)))(newline)
  (display (gcd-terms '(1 -1 0) '(1 -1 -1 1)))(newline)
  (display (div-terms '(1 -1 0) '(1 -1 -1 1)))
  'done)
;(test-code)
(define (gcd-poly p1 p2)
 (if (same-variable? (variable p1) (variable p2))
     (let ((result (make-poly (variable p1) 
                              (gcd-terms (term-list p1) (term-list p2)))))
       (let ((termlist (term-list result)))
         (if (< (coeff (first-term termlist)) 0)
             (make-poly (variable result)
                        (make-negative-terms termlist))
             result)))
     (error "different var -- GCD_POLY" p1 p2)))
    
;;book-test
(define p1 (make-poly 'x '(1 -1 -2 2 0)))
(define p2 (make-poly 'x '(1 0 -1 0)))
;(display (gcd-poly p1 p2))