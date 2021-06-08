;; broker.el

(package-initialize)
(require 'zmq)
(setq debug-on-error t)

(let* ((context (zmq-context))
       (frontend (zmq-socket context zmq-ROUTER))
       (backend (zmq-socket context zmq-DEALER)))

  (zmq-bind frontend "tcp://*:5559")
  (zmq-bind backend "tcp://*:5560")

  (zmq-proxy frontend backend nil))
