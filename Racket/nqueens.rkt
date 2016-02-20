#lang racket
(require rackunit)
(require rackunit/text-ui)


;;;;;;;;;;;;;;;;;;;;;
;; LISTA TABULEIRO
;;;;;;;;;;;;;;;;;;;;;
; A lista tabuleiro é uma lista de inteiros.
; Os valores contidos na lista indicam a linha que uma rainha
; está posicionada no tabuleiro. A posicão na lista indica a coluna.
; Por Exemplo: (list 3 2 1 0) é um tabuleiro 4X4, o primeiro elemento
; da lista que é o 3 indica que tem uma rainha na linha 3 e coluna 0.


;;;;;;;;;;;;;;;;;;;;
;; FUNÇÃO SEGURO?
;;;;;;;;;;;;;;;;;;;;
; Lista Natural Natural -> Boolean
; Verifica se é seguro colocar uma nova rainha
; na posição linha, coluna do tabuleiro.

;; TESTES

; Tabuleiro 1 para teste, 3 rainhas posicionadas,
; falta apenas a ultima rainha na ultima coluna.
; . Q . _
; . . . _
; Q . . _
; . . Q _
(define tab-teste1 (list 2 0 3))

; Tabuleiro 2 para teste, 3 rainhas posicionadas,
; falta apenas a ultima rainha na ultima coluna.
; . . Q _
; Q . . _
; . . . _
; . Q . _
(define tab-teste2 (list 1 3 0))

(define seguro?-tests
  (test-suite
   "seguro tests"
   (check-equal? (seguro? empty 0 0) true)
   (check-equal? (seguro? tab-teste1 0 3) false)
   (check-equal? (seguro? tab-teste1 1 3) true)
   (check-equal? (seguro? tab-teste1 2 3) false)
   (check-equal? (seguro? tab-teste1 3 3) false)
   (check-equal? (seguro? tab-teste2 0 3) false)
   (check-equal? (seguro? tab-teste2 1 3) false)
   (check-equal? (seguro? tab-teste2 2 3) true)
   (check-equal? (seguro? tab-teste2 3 3) false)))

;; FUNÇÃO
(define (seguro? tabuleiro linha coluna)
  (define (iter tabuleiro linha coluna acc)
    (cond
      [(empty? tabuleiro) true]          ; Iterou por toda a lista
      [(or (= (first tabuleiro) linha)      ; Colisão na linha
           (= (abs (- (first tabuleiro) linha)) (abs (- acc coluna)))  ; Colisão nas diagonais
           ) false]
      [else (iter (rest tabuleiro) linha coluna (add1 acc))]
      )
    )
  (iter tabuleiro linha coluna 0)
  )


;;;;;;;;;;;;;;;;;;;;
;; FUNÇÃO NQUEENS
;;;;;;;;;;;;;;;;;;;;
; Natural -> Natural
; Calcula o número total de soluções do problema das
; N-Rainhas para uma entrada N.

;; TESTES

(define nrainhas-tests
  (test-suite
   "n-rainhas tests"
   (check-exn exn:fail? (thunk (nrainhas -1)))
   (check-equal? (nrainhas 1) 1)
   (check-equal? (nrainhas 2) 0)
   (check-equal? (nrainhas 3) 0)
   (check-equal? (nrainhas 4) 2)
   (check-equal? (nrainhas 5) 10)
   (check-equal? (nrainhas 6) 4)
   (check-equal? (nrainhas 7) 40)
   (check-equal? (nrainhas 8) 92)
   (check-equal? (nrainhas 9) 352)
   (check-equal? (nrainhas 10) 724)))

;; FUNÇÃO
(define (nrainhas n)
  (define num-solucoes 0)
  (define solucoes empty)
  (define (iter col tabuleiro)
    (for ([i n]
          #:when (seguro? tabuleiro i col))
      (define tab (append tabuleiro (list i)))
      (cond
        [(= col (sub1 n)) (set! num-solucoes (add1 num-solucoes))]
        [else (iter (add1 col) tab)])
    ))
  (iter 0 empty)
  num-solucoes
  )


;;;;;;;;;;;;;;;;;;;;
;; Funcões para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes seguro?-tests
                nrainhas-tests)


(display "\nINSTRUÇÕES:\nPara executar o programa, basta utilizar a função (nrainhas N)
onde N é o tamanho do tabuleiro. A saída será o número de soluções.")