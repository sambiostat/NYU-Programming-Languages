;;;PL Homework -scheme
;;; 
;;;Q1
;;; Base Case: L is empty, return 0
;;; Assumption: (count-numbers M) returns a count of the numbers in M, for
;;; any list M smaller than L (including (car L) and (cdr L)).
;;; Step: If (car L) is a list, then return the sum of the count of the
;;; numbers in (car L) and the count of the numbers in (cdr L).
;;; If (car L) is a number, return 1 plus the count of the numbers in
;;; (cdr L). Otherwise, return the count of the numbers in (cdr L).

(define (count-numbers L)
	(cond ( (null?  L)  0)
              (else (cond ((list? (car L)) (+ (count-numbers (car L)) (count-numbers (cdr L))))
                          (else (cond ((number? (car L)) (+ 1 (count-numbers (cdr L))))
                                      (else (count-numbers (cdr L)))))))))

(count-numbers '(11 (22 (a 33 44) 55) (6 (b 7 8 (9 c) 100 d))))

;;;Q2
;;; Base Case: L is empty, return (x)
;;; Assumption: ( insert x M) returns a sorted list containing x and all the elements in M, for
;;; any list M smaller than L (including (car L) and (cdr L)).
;;; Step: If (car L) is bigger than x then then return list that has x as the first element.
;;; i.e. return (cons x L)
;;; If (car L) is smaller than x, then return the list that has  (car L) as the first element
;;; and insert x in the position afterwards. (cons (car L) (insert x (cdr L))). 

(define  (insert x L) 
	(cond ( (null? L)  (list x) )
	(else (cond ( (> (car L) x)  (cons x L) ) 
                     (else( cons (car L)  (insert x ( cdr L))))))))
 (insert 5 '(1 2 3 4 6 7 8))

;;;Q3
;;; Base Case: L is empty, return (M)
;;; Assumption: ( insert-all Q M) returns a sorted list containing a all the elements in M and Q, for
;;; any list Q smaller than L (including (car L) and (cdr L)).
;;; Step: call insert ( car L)  (insert-all (cdr L) M)

(define (insert-all L M)
(cond ( (null? L) M )
(else (insert (car L) (insert-all (cdr L) M)))))

 (insert-all '(2 4) '(1 3 5))

;;;Q4
;;; Base Case: L is empty, return (L)
;;; Assumption: (sort M) returns a sorted list containing all the elements in M, for
;;; any list M smaller than L (including (car L) and (cdr L)).
;;; Step: call  insert ( car(L)  (sort (cdr L) ) )

(define sort (lambda (L)
           (letrec
              ((insert  (lambda (x L)
                 (cond((null? L) (list x))
                    (else (cond ( (<= x (car L)) (cons x L))
                           (else (cons (car L) (insert x (cdr L))))))))))
            (cond ( (null? L) L)
                  ( else (insert (car L) (sort (cdr L))))))))

(sort '(3 6 1 5 2 7 4))

;;;Q5
;;; Translate one by one
(define (translate op)
  (cond ((eq? op '+) +)
        ((eq? op '*) *)
        ((eq? op '-) -)
        ((eq? op '/) /)))

((translate '*) 3 4)


;;;Q6
;;;Base case: the exp is a number then return it;
;;;Assumption: (postfix-eval L) works for any element L inside the exp. including (car L) and (caar L
;;;Step: call ((translate (cddr L)) (postfix-eval (car L)) (postfix-eval (caar L)))

(define (postfix-eval exp)
  (cond ((number? exp) exp)
        (else ((translate (caddr exp))  (postfix-eval (car exp))  (postfix-eval (cadr exp))))))

(postfix-eval `((16 12 *) ((2 6 +) (9 1 -) *) /))


;;; Q7
;;; Base Case: L is empty, return the set containing the empty
;;; set, i.e. ’(()).
;;; Assumption: (powerset M) returns the powerset of M, for any set M smaller than L (including (cdr L)).
;;; Step: append (powerset (cdr L)) and the list hat having (car L) in the front of each elements
;;; in (powerset (cdr L)).

(define (powerset L)
  (cond ((null? L) '(()))
        (else (let ((S (powerset (cdr L))))
                    (append  S (map (lambda (x) (cons (car L) x)) S))))))

(powerset '(1 2 3 4))

(powerset '(1 2 3 4))
