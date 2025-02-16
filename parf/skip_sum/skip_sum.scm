(define (max-skip-sum seq)
  ;; IMPLEMENT
  0)






;; max-skip-sum ფუნქციის ტესტები
(display "Testing max-skip-sum")(newline)
(display (if (equal? 3 (max-skip-sum '(1 4 1 4 1))) "max-skip-sum: 1 SUCCESS" "max-skip-sum: 1 FAILURE"))(newline)
(display (if (equal? 23 (max-skip-sum '(2 3 0 10 9 7 1 6 8 4 5))) "max-skip-sum: 2 SUCCESS" "max-skip-sum: 2 FAILURE"))(newline)
(display (if (equal? 17 (max-skip-sum '(7 4 8 9 1 3 6 2 10 5 0))) "max-skip-sum: 3 SUCCESS" "max-skip-sum: 3 FAILURE"))(newline)
(display (if (equal? 54 (max-skip-sum '(-11 -7 3 -9 20 -6 1 17 -5 18 -12 19 4 14 -17 -3 -4 8 10 -19 -2 -16 -20 -15 0 16 12 15 -18 5 9 7 -10 -13 -1 -8 13 6 2 11 -14))) "max-skip-sum: 4 SUCCESS" "max-skip-sum: 4 FAILURE"))(newline)
