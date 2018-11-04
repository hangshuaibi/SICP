;e4.57
'(rule (replace ?person1 person2)
       (or 
        (and (job ?person1 ?same-job)
             (job ?person2 ?same-job)
             (not (same ?person1 ?person2)))
        (and (job ?person1 job1)
             (job ?person2 job2)
             (can-do-job job1 job2))))
;a)
'(replace ?person (Cy D.Fect))
;b)
'(and (replace ?person1 ?person2)
      (salary person1? ?amount1)
      (salary person2? ?amount2)
      (lisp-value < ?amount1 ?amount2))