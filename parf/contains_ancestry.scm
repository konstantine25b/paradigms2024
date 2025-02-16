(define (flatten sequence)
(cond ((null? sequence) '())
((list? (car sequence)) (append (flatten (car sequence))
(flatten (cdr sequence))))
(else (cons (car sequence) (flatten (cdr sequence))))))

(define (contains-ancestry root seq)
  
    (map (lambda (elem) 
    (
      map (lambda (child)
         (equal? elem child)
      )(flatten root
      )  
    )
    
    ) seq)
  
  (if (map (lambda (elem) (member elem (flatten root))) seq) #t #f))






;; contains-ancestry ფუნქციის ტესტები
(display "Testing contains-ancestry")(newline)
(display (if (equal? #f (contains-ancestry '(1) '(2))) "contains-ancestry: 1 SUCCESS" "contains-ancestry: 1 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1) '(1))) "contains-ancestry: 2 SUCCESS" "contains-ancestry: 2 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1 (2 (3) (4)) (5 (6) (7 (8)))) '(1 2 4))) "contains-ancestry: 3 SUCCESS" "contains-ancestry: 3 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1 (2 (3) (4)) (5 (6) (7 (8)))) '(1 8))) "contains-ancestry: 4 SUCCESS" "contains-ancestry: 4 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1 (2 (3) (4)) (5 (6) (7 (8)))) '(1 7 8))) "contains-ancestry: 5 SUCCESS" "contains-ancestry: 5 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1 (2 (3) (4)) (5 (6) (7 (8)))) '(1 5 8))) "contains-ancestry: 6 SUCCESS" "contains-ancestry: 6 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1 (2 (3) (4)) (5 (6) (7 (8)))) '(1 5 7 8))) "contains-ancestry: 7 SUCCESS" "contains-ancestry: 7 FAILURE"))(newline)
(display (if (equal? #t (contains-ancestry '(1 (2 (3) (4)) (5 (6) (7 (8)))) '(5 8))) "contains-ancestry: 8 SUCCESS" "contains-ancestry: 8 FAILURE"))(newline)
