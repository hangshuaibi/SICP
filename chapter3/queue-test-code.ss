(define (queue-test-code)
  (define q (make-queue))
  (insert-queue! q 'a)(print-queue q)
  (insert-queue! q 'b)(print-queue q)
  ;(insert-queue! q 'b)(print-queue q)
  (delete-queue! q)(print-queue q)
  (insert-queue! q 'c)(print-queue q)
  (insert-queue! q 'd)(print-queue q)
  (delete-queue! q)(print-queue q)
  (delete-queue! q)(print-queue q)
  (delete-queue! q)(print-queue q)
  'done)
(queue-test-code)