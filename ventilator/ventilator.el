;; ventilator.el

;; Pushes tasks to several workers

(package-initialize)
(require 'zmq)
(setq debug-on-error t)

(let* ((context (zmq-context))
       (sender (zmq-socket context zmq-PUSH))
       (sink (zmq-socket context zmq-PUSH)))

  (zmq-bind sender "tcp://*:5557")
  (zmq-connect sink "tcp://localhost:5558")
  
  (message "Print Enter when workers are ready: ")
  (read-from-minibuffer "")  ;; reads from stdin
  (message "Sending tasks to workers...")

  (zmq-send sink "0")

  (setq total-msec 0)
  (dotimes (task-number 20)
    (message (int-to-string task-number))
    ;; Random workload from 1 to 100msec
    (setq workload (+ (random 100) 1))
    (+ total-msec workload)
    (zmq-send sender (int-to-string workload)))

  (zmq-close sink)
  (zmq-close sender))
