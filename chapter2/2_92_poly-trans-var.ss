(load "d:\\sicp\\chapter2\\split-list.ss")
(load "d:\\sicp\\chapter2\\common-poly.ss")
(load "d:\\sicp\\chapter2\\dense-poly.ss")
;;var-rank -> x > y > z
;;2.92, to make it easy, may focus on dense-poly
;; '(y ([x (1 -1)] 2) -> (x - 1) * y + 2
(define (rank-poly poly)
  (cond ((number? poly) 0)
        ((eq? (variable poly) 'z) 1)
        ((eq? (variable poly) 'y) 2)
        ((eq? (variable poly) 'x) 3)
        (else (error "unknown var ... -- just support x y z"
                     poly))))
;;can-raise?-deep
(define (can-raise? poly)
  (define (check-iter poly coeffs)
    (cond ((null? coeffs)
           #f)
          ((< (rank-poly poly) (rank-poly (car coeffs)))
           #t)
          (else (check-iter poly (cdr coeffs)))))
  (check-iter poly (term-list poly)))
(load "d:\\sicp\\chapter2\\common-poly.ss")
(define (test-code)
  ;(display (can-raise? '(x 1 2 3)))(newline)
  ;(display (can-raise? '(y (x 2 4) 2 0)))(newline)
  ;(display (can-raise? '(a (x 1 2) 2 4))) (newline)
  ;(display (mul-term-num 'x (make-term 3 4) 2))(newline)
  ;(display (term-to-poly-deep 'y '(1 (x 1 2 3))))(newline)
  ;(display (term-to-poly-deep 'y '(3 -1)))(newline)
  (display (raise_ '(y (x 1 2) 2 3)))(newline)
  (display (add 12 3))(newline)
  (display (add '(x 1 2) 4))(newline)
  (display (add 4 '(y 2 3 4)))(newline)
  (display (add '(x 1 2) '(x 2 3 4)))(newline)
  'done)
;;term-to-termlist
(define (term-to-poly var term);;coeff of term is a number type
  (make-poly var
             (cons (coeff term)
                   (build-list-from-num-val (order term) 0))))
(define (term-to-poly-deep main-var term);;use recursion
  (let ((ord (order term))
        (coe (coeff term)))
    (cond ((number? coe)
           (term-to-poly main-var term))
          ((poly? coe)
           (make-poly (variable coe)
                      (map
                       (lambda (ccoe)
                         (term-to-poly-deep main-var
                                                (make-term ord ccoe)))
                       (term-list coe))))
          (else 'error-term-to-poly-deep))))

(define (mul-term-num var term num)
  (make-poly var (map (lambda (x) (* num x))
                      (term-list (term-to-poly-deep var term)))))

(define (raise_ poly)
  (define (iter-raise main-var terms)
    (if (null? terms)
        (the-empty-termlist)
        (add (term-to-poly-deep main-var (first-term terms))
             (iter-raise main-var (rest-terms terms)))))
  (if (can-raise? poly)
      (iter-raise (variable poly) (term-list poly))
      (error "cant raise --" poly)))
;(define add cons)
(define (add-poly-dense p1 p2)
  ;(display p1)
  ;(display p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1) 
                 (add-terms-dense (term-list p1) (term-list p2)))
      ;(error "different var -- add-poly" p1 p2)))
      (if (< (rank-poly p1) (rank-poly p2))
          (add-poly-dense p2 (make-poly (variable p2) (list p1)))
          (add-poly-dense p1 (make-poly (variable p1) (list p2))))))
;;add
(define (add-poly-num poly num)
  (add-poly-dense poly (term-to-poly-deep (variable poly)
                                          (make-term 0 num))))
(define (add a1 a2)
  (cond ((and (number? a1) (number? a2))
         (+ a1 a2))
        ((and (poly? a1) (poly? a2))
         (add-poly-dense a1 a2))
        ((and (poly? a1) (number? a2))
         (add-poly-num a1 a2))
        ((and (poly? a2) (number? a1))
         (add-poly-num a2 a1))
        ((empty-termlist? a1)
         a2)
        ((empty-termlist? a2)
         a1)
        (else (error "no such type -- ADD" a1 a2))))
;(define add cons)
(test-code) 
(display (add-poly-dense '(x 1 2 3) '(y 2 3)))