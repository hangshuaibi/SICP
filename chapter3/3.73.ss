(load "d:\\sicp\\chapter3\\integral.ss")
(load "d:\\sicp\\chapter3\\recursion-defined-stream.ss")
(load "d:\\sicp\\chapter3\\stream-operation.ss")
(load "d:\\sicp\\chapter3\\3.50_stream-map.ss")
;cons-stream
(define (RC r c dt)
  (define (rcs i v0)
    (add-streams (scale-stream i r)
                 (integral (scale-stream i (/ 1 c))
                           v0 dt)))
  rcs)
(define RC1 (RC 5 1 0.5))
(load "d:\\sicp\\chapter3\\display-stream.ss")
(display-stream (RC1 ints 0))