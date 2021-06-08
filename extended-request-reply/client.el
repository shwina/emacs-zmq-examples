;; client.el

;; Sends a request to the server and receives a reply.

(package-initialize)
(require 'zmq)
(setq debug-on-error t)

(let* ((context (zmq-context))
        (socket (zmq-socket context zmq-REQ))
        (result))
     (zmq-connect socket "tcp://localhost:5559")
     (let (msg)
       (while t
         (zmq-send socket "World")
         (setq msg (zmq-recv socket))
         (message (format "Received %s" msg)))))
