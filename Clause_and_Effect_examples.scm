;; 
;; "Clause and Effect" worksheets 1 to 4

(load "./CodeFromTheReasonedSchemer2ndEd/trs2-impl.scm")
(load "./CodeFromTheReasonedSchemer2ndEd/trs2-arith.scm")

;; --

(defrel (drinko d)
  (disj (== d 'beer)
	(== d 'milk)
	(== d 'water)))

(run* q
      (drinko q))

(defrel (drinkso p d)
  (disj (== `(,p ,d) '(john water))
	(== `(,p ,d) '(john gin))
	(== `(,p ,d) '(jeremy milk))
	(== `(,p ,d) '(camila beer))
	(conj (== p 'jeremy)
	      (drinkso 'john d))))

(run* q
      (drinkso 'jeremy q))

;; -- Worksheet 1

(defrel (maleo q)
  (disj (== q 'bertram)
	(== q 'percival)))

(defrel (femaleo q)
  (disj (== q 'lucinda)
	(== q 'camilla)))

(defrel (pairo p q)
  (maleo p)
  (femaleo q))

(run* (p q)
      (pairo p q))

;; -- Worksheet 2

(defrel (drinkso p d)
  (disj (== `(,p ,d) '(john martini))
	(== `(,p ,d) '(mary gin))
	(== `(,p ,d) '(susan vodka))
	(== `(,p ,d) '(john gin))
	(== `(,p ,d) '(fred gin))))

(defrel (pairo x y z)
  (drinkso x z)
  (drinkso y z)
  (conda ((== x y) F)
	 (S S)))

(run* (x y)
      (fresh (z)
	     (pairo x y z)))

;; -- Worksheet 3

(defrel (bordero p q)
  (disj (== `(,p ,q) '(sussex kent))
	(== `(,p ,q) '(sussex surrey))
	(== `(,p ,q) '(surrey kent))
	(== `(,p ,q) '(hampshire sussex))
	(== `(,p ,q) '(hampshire surrey))
	(== `(,p ,q) '(hampshire berkshire))
	(== `(,p ,q) '(berkshire surrey))
	(== `(,p ,q) '(wiltshire hampshire))
	(== `(,p ,q) '(wiltshire berkshire))))

(defrel (adjacento p q)
  (bordero p q))

(defrel (adjacento p q)
  (bordero q p))

(defrel (affordableo p q)
  (fresh (r)
	 (adjacento p r)
	 (adjacento r q)))

(run* (p q)
      (affordableo 'wiltshire 'sussex))

(run* (p q)
      (affordableo p q))

;; Worksheet 4

(defrel (arco p q)
  (disj (== `(,p ,q) '(g h))
	(== `(,p ,q) '(g d))
	(== `(,p ,q) '(e d))
	(== `(,p ,q) '(h f))
	(== `(,p ,q) '(e f))
	(== `(,p ,q) '(a e))
	(== `(,p ,q) '(a b))
	(== `(,p ,q) '(b f))
	(== `(,p ,q) '(b c))
	(== `(,p ,q) '(f c))))

(defrel (patho p q)
  (fresh (r)
	 (arco p r)
	 (arco r q)))

(run* (p q)
      (patho p q))
