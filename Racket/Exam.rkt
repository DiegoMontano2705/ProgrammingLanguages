#lang racket

;; ====================
;; Complete the following functions and submit your file to Canvas.
;; ====================
;; Do not change the names of the functions. 
;; Do not change the number of arguments in the functions.
;; If your file cannot be loaded by the Racket interpreted, your submission may be cancelled. Then, submit only code that works.
;; ====================
;; Grading instructions:
;; There is a series of test cases for each function. In order to state that your function "works as described", your output must be similar to the expected one in each case.

;; === exam.stdev ===

(define (media lst)
        (/ (apply + lst) (length lst))
  )
(define (stdevAux lst)
        (apply + (map * (map (lambda (x) (- x (media lst)))lst) (map (lambda (x) (- x (media lst)))lst)))   
 )

(define (exam.stdev lst)
	(if (null? lst)
            0
            (sqrt (/ (stdevAux lst) (- (length lst) 1)))
            )
)

(display "=== exam.stdev ===\n")
(exam.stdev '(1 2 3 4 5 6)) ;; 1.8708286933869707
(exam.stdev '(300 250 58 47 125 36)) ;; 113.1529937739165
(exam.stdev '(1 2)) ;; 0.7071067811865476

;; === exam.toBinary ===
(define (toBinaryAux x)
 (if (= x 0)
            null
            (if (= (modulo x 2) 0)
                (append '(0)(toBinaryAux (quotient x 2)))
                (append '(1)(toBinaryAux (quotient x 2)))
            )
         )

       )
(define (exam.toBinary x)
        (if (= x 0)
            '(0)
            (reverse (toBinaryAux x))
         )
)

(display "=== exam.toBinary ===\n")
(exam.toBinary 0) ;; '(0)
(exam.toBinary 1) ;; '(1)
(exam.toBinary 3) ;; '(1 1)
(exam.toBinary 7) ;; '(1 1 1)
(exam.toBinary 32) ;; '(1 0 0 0 0 0)
(exam.toBinary 847) ;; '(1 1 0 1 0 0 1 1 1 1)

;; === exam.numberToList ===

(define (exam.numberToList x)
	(display "Not yet implemented\n")
)

(display "=== exam.numberToList ===\n")
(exam.numberToList 100) ;; '(1 0 0)
(exam.numberToList 17395) ;; '(1 7 3 9 5)
(exam.numberToList 0) ;; '(0)

;; === exam.differences ===

(define (exam.differences lst)
	(display "Not yet implemented\n")
)

(display "=== exam.differences ===\n")
(exam.differences '(1 2 4 8 20)) ;; '(1 2 4 12 19)
(exam.differences '(5 9 13 27 100 91 4)) ;; '(4 4 14 73 9 87 1)
(exam.differences '(99)) ;; '(0)
(exam.differences '()) ;; '()

;; === exam.rotate ===

(define (exam.rotate matrix)
	(display "Not yet implemented\n")
)

(display "=== exam.rotate ===\n")
(exam.rotate '((1 2 3) (4 5 6) (7 8 9))) ;; '((7 4 1) (8 5 2) (9 6 3))
(exam.rotate '((1 2 3) (4 5 6) (7 8 9) (10 11 12))) ;; '((10 7 4 1) (11 8 5 2) (12 9 6 3))
(exam.rotate '((1 2) (3 4) (5 6) (7 8) (9 10))) ;; '((9 7 5 3 1) (10 8 6 4 2))
(exam.rotate '((1 2 3 4 5) (6 7 8 9 10))) ;; '((6 1) (7 2) (8 3) (9 4) (10 5))

;; === exam.scan ===
(define (scanAux lst)
        (if (null? lst)
            '(1 2)
        (if (or (not(equal? (car lst) 0)) (not(equal? (car lst) 1)))
                   null
                   (scanAux (cdr lst))
            )
        )
  )
(define (exam.scan lst)	
	(if (or (not(equal? (list-ref lst 0) 1)) (not(equal? (list-ref lst (- (length lst) 1)) 2))    )
            #f
            (if(null? (scanAux (take (cdr lst) (- (length lst) 2) )))
               #t
               #f
               )
            )
)

(display "=== exam.scan ===\n")
(exam.scan '(0 1 1 1 1 1 2)) ;; #f
(exam.scan '(1 0 0 0 0 0 0 2)) ;; #t
(exam.scan '(1 0 0)) ;; #f
(exam.scan '(1 1 1 1 0 1 1 1 0 1 1 0 2)) ;; #t
(exam.scan '(1 1 2)) ;; #t
(exam.scan '(0 1 1 2)) ;; #f

;; === exam.select ===

;; This should not be done! (but it helps)
(define grades 
	'(
		("id" "g1" "g2" "g3")
	 	(796623 62 84 91)
	 	(782544 81 89 77)
	 	(790256 59 62 63)
	 	(799610 75 68 82)
	 	(791313 85 56 92)
	 	(786621 97 98 92)
	 	(809706 91 72 80)
	 )
)

;;(define (selectAux table cols)
     ;;(if (null? table)
       ;;  null
     ;;    (append (map cadr (filter (lambda (x) (equal? (car x) cols)) (car table))) (selectAux (cdr table) cols))
   ;;      )
 ;; )

(define (exam.select table cols)
	(display "Not yet implemented\n")
        ;;(map list cols (selectAux table (car cols)))
)

(display "=== exam.select ===\n")
(exam.select grades '("g1" "g2")) ;; '(("g1" "g2") (62 84) (81 89) (59 62) (75 68) (85 56) (97 98) (91 72))
(exam.select grades '("id")) ;; '(("id") (796623) (782544) (790256) (799610) (791313) (786621) (809706))

;; === exam.insert ===

;; This should not be done! (but it helps)
(define patients '((name height) ("John Wick" 182) ("Ellen Ripley" 173) ("Beatrix Kiddo" 175)))

(define (exam.insert table col index)
	(display "Not yet implemented\n")
)

(display "=== exam.insert ===\n")
(exam.insert patients '(weight 92 73 75) 0) ;; '((weight name height) (92 "John Wick" 182) (73 "Ellen Ripley" 173) (75 "Beatrix Kiddo" 175))
(exam.insert patients '(weight 92 73 75) 1) ;; '((name weight height) ("John Wick" 92 182) ("Ellen Ripley" 73 173) ("Beatrix Kiddo" 75 175))
(exam.insert patients '(weight 92 73 75) 5) ;; '((name height weight) ("John Wick" 182 92) ("Ellen Ripley" 173 73) ("Beatrix Kiddo" 175 75))

