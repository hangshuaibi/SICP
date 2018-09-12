(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((ia1 (make-wire))
          (ia2 (make-wire))
          (s (make-wire)))
      (inverter a1 ia1)
      (inverter a2 ia2)
      (and-gate ia1 ia2 s)
      (inverter s output)))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
;;delay sum of all the peocedure called