;; SICP - Chapter 4.4

(load "./CodeFromTheReasonedSchemer2ndEd/trs2-impl.scm")
(load "./CodeFromTheReasonedSchemer2ndEd/trs2-arith.scm")

(defrel (addresso n a)
  (disj
   (== `(,n ,a) '((Bitdiddle Ben) (Slumerville (Ridge Road) 10)))
   (== `(,n ,a) '((Hacker Alyssa P) (Cambridge (Mass Ave) 78)))
   (== `(,n ,a) '((Fect Cy D) (Cambridge (Ames Street) 3)))
   (== `(,n ,a) '((Tweakit Lem E) (Boston (Bay State Road) 22)))
   (== `(,n ,a) '((Reasoner Louis) (Slumerville (Pine Tree Road) 80)))
   (== `(,n ,a) '((Warbucks Oliver) (Swellesley (Top Heap Road))))
   (== `(,n ,a) '((Scrooge Eben) (Weston (Shady Lane) 10)))
   (== `(,n ,a) '((Cratchet Robert) (Allston (N Harvard Street) 16)))
   (== `(,n ,a) '((Aull DeWitt) (Slumerville (Onion Square) 5)))))

(run* q
      (addresso '(Bitdiddle Ben) q))

(defrel (jobo n j)
  (disj
   (== `(,n ,j) '((Bitdiddle Ben) (computer wizard)))
   (== `(,n ,j) '((Hacker Alyssa P) (computer programmer)))
   (== `(,n ,j) '((Fect Cy D) (computer programmer)))
   (== `(,n ,j) '((Tweakit Lem E) (computer technician)))
   (== `(,n ,j) '((Reasoner Louis) (computer programmer trainee)))
   (== `(,n ,j) '((Warbucks Oliver) (administration big wheel)))
   (== `(,n ,j) '((Scrooge Eben) (accounting chief accountant)))
   (== `(,n ,j) '((Cratchet Robert) (accounting scrivener)))
   (== `(,n ,j) '((Aull DeWitt) (administration secretary)))))

(defrel (salaryo n s)
  (disj
   (== `(,n ,s) '((Bitdiddle Ben) 60000))
   (== `(,n ,s) '((Hacker Alyssa P) 40000))
   (== `(,n ,s) '((Fect Cy D) 35000))
   (== `(,n ,s) '((Tweakit Lem E) 25000))
   (== `(,n ,s) '((Reasoner Louis) 30000))
   (== `(,n ,s) '((Warbucks Oliver) 150000))
   (== `(,n ,s) '((Scrooge Eben) 75000))
   (== `(,n ,s) '((Cratchet Robert) 18000))
   (== `(,n ,s) '((Aull DeWitt) 25000))))

(defrel (supervisoro n s)
  (disj
   (== `(,n ,s) '((Hacker Alyssa P) (Bitdiddle Ben)))
   (== `(,n ,s) '((Fect Cy D) (Bitdiddle Ben)))
   (== `(,n ,s) '((Tweakit Lem E) (Bitdiddle Ben)))
   (== `(,n ,s) '((Reasoner Louis) (Hacker Alyssa P)))
   (== `(,n ,s) '((Bitdiddle Ben) (Warbucks Oliver)))
   (== `(,n ,s) '((Scrooge Eben) (Warbucks Oliver)))
   (== `(,n ,s) '((Cratchet Robert) (Scrooge Eben)))
   (== `(,n ,s) '((Aull DeWitt) (Warbucks Oliver)))))

;; simple query

(run* q
      (jobo q '(computer programmer)))

(run* (p q)
      (addresso p q))

(run* p
      (supervisoro p p))

;; find adresses of computer progammers
(run* (p w)
      (jobo p '(computer programmer))
      (addresso p w))

(run* p
      (disj (supervisoro p '(Bitdiddle Ben))
	    (supervisoro p '(Hacker Alyssa P))))

(run* p
      (supervisoro p '(Bitdiddle Ben))
      (fresh (q)
	     (jobo p q)
	     (conda ((== q '(computer programmer)) F)
		    (S S))))

;; name of peole with a salary greater than 30000

(define (filter-lst fn lst)
  (cond ((null? lst) '())
        ((fn (car lst)) 
         (cons (car lst)
               (filter-lst fn (cdr lst))))
        (else (filter-lst fn (cdr lst)))))

(let ((dat (run* (name salary)
		 (salaryo name salary))))
  (filter-lst (lambda (elt)
		(> (cadr elt) 30000))
	      dat))

(defrel (outranked-byo s b)
  (disj (supervisoro s b)
	(fresh (m)
	       (conj (supervisoro s m)
		     (supervisoro m b)))))

(run* p
      (outranked-byo '(Bitdiddle Ben) p))

(run* p
      (outranked-byo '(Hacker Alyssa P) p))

(run* p
      (outranked-byo '(Cratchet Robert) p))
