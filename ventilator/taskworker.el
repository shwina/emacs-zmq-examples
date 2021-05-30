;; ventilator.el

;; Performs task

(package-initialize)
(require 'zmq)
(setq debug-on-error t)


(let* ((context (zmq-context))
       (receiver (zmq-socket context zmq-PULL))
       (sender (zmq-socket context zmq-PUSH)))

  (zmq-connect receiver "tcp://localhost:5557")
  (zmq-connect sender "tcp://localhost:5558")

  (while t
    (setq s (zmq-recv receiver))
    (message s)
    (sleep-for 0 (string-to-number s)) ;; 0 seconds, s milliseonds
    (zmq-send sender ""))

  (zmq-close receiver)
  (zmq-close sender))

