;; server.el

;; Receives a request from a client and sends back a reply
;; after doing some "work" (sleeping).

(package-initialize)
(require 'zmq)
(setq debug-on-error t)

(let* ((context (zmq-context))
        (socket (zmq-socket context zmq-REP))
        (result))
     (zmq-bind socket "tcp://*:5555")
     (let (msg)
       (while t
         (setq msg (zmq-recv socket))
         (sleep-for 1)
         (zmq-send socket "Hello")
         (message (format "Received %s" msg))))))
