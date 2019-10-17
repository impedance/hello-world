;; =================
;; Data definitions:
(define-struct bear (x y angle))
;; Bear is (make-bear Natural Natural Natural)
;; interp. a bear is spinning at position x, y
 

(define BEAR1 (make-bear 100 100 0))
(define BEAR2 (make-bear 50 50 0))

#;

(define (fn-for-bear b)
  (...(bear-x b)       ;Natural
      (bear-y b)       ;Natural
      (bear-angle b))) ;Natural

 

;;Template rules used:
;; - compound: 3 fields


;; =================
;; Functions:

;; Bear -> Bear
;; start the world with (main BEAR1)
;;

(define (main b)
  (big-bang b                            ; Bear
            (on-tick   next-bear)        ; Bear -> Bear
            (to-draw   render)           ; Bear -> Image
            (on-mouse  handle-mouse)))   ; Bear Integer Integer MouseEvent -> Bear

;; Bear -> Bear
;; produce the next bear angled to 1 degree counterclockwise

(check-expect (next-bear BEAR1)
  (make-bear
    (bear-x BEAR1)
    (bear-y BEAR1)
    (+ (bear-angle BEAR1) 1)))
(check-expect (next-bear (make-bear 30 30 10))
  (make-bear 30 30 11))
 
;(define (next-bear b) 1) ;stub
 
(define (next-bear b)
  (make-bear
    (bear-x b)
    (bear-y b)
    (+ (bear-angle b) 1)))

 
;; Bear -> Image
;; render new spinned bear on the screen at x and y position
(check-expect (render BEAR1)
  (place-image 
      (rotate (bear-angle BEAR1) BEAR-IMG)
      (bear-x BEAR1)
      (bear-y BEAR1)
      MTS))
(check-expect (render BEAR2)
  (place-image 
      (rotate (bear-angle BEAR2) BEAR-IMG)
      (bear-x BEAR2)
      (bear-y BEAR2)
      MTS))

;(define (render b) MTS) ;stub
 
(define (render b)
  (place-image
   (rotate (bear-angle b) BEAR-IMG)
           (bear-x b)
           (bear-y b)
           MTS))

 

; Bear Integer Integer MouseEvent -> Bear
; producing new bear when user clicks button-down on mouse
(check-expect (handle-mouse BEAR1 100 100 "button-down")
              (make-bear 100 100 0))
(check-expect (handle-mouse BEAR1 50 50 "move")
              BEAR1)
(check-expect (handle-mouse BEAR1 10 10 "button-down")
              (make-bear 10 10 0))

;(define (handle-mouse b x y me) b) ;stub

;; template from handle-mouse
(define (handle-mouse b x y me)
  (cond [(mouse=? me "button-down") (make-bear x y 0)]
        [else b]))


