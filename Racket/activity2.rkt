;Diego Fernando Montaño Pérez  A01282875

(define (sumlist lst)
  (if (null? lst)
      0
      (if (number? (car lst))
          (+ (car lst) (sumlist (cdr lst)))
          (sumlist (cdr lst))
      )
  )
)

(sumlist '(1 2 3 4))

(define (palindrome? lst)
  (equal? lst (reverse lst))
)

(palindrome? '(a b b a))


(define (reverselst lst)
  (if (null? lst)
      null
      (append (reverselst (cdr lst)) (list (car lst)))
  )
)

(reverselst '(a b c d e f))



(define (elementbyindex lst i)
  (if (or(< i 0) (> i (length lst)))
      null
      (if(= i 0)
         (car lst)
         (elementbyindex(cdr lst) (- i 1))
      )
  )
   
)
(elementbyindex '(a b c d e f) 4)



(define (oddPositAux lst x)
  (if (null? lst)
      null
      (if (equal? #t x)
          (cons (car lst) (oddPositAux (cdr lst) #f))
          (oddPositAux (cdr lst) #t)
      )
  )
  
)

(define (oddPosit lst)
  (oddPositAux lst #f)
)

(oddPosit '(1 2 3 4 5 6 7 8))