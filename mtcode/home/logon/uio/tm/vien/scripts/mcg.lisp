(in-package :common-lisp-user)

;;
;; in a run-time image loading this file as its `-L' argument, we need to call
;; *restart-init-function* ourselves, as slave() below never returns.
;;
#+(and :allegro :runtime-standard)
(when (functionp excl:*restart-init-function*)
  (funcall excl:*restart-init-function*))
  
;;
;; make sure we have sufficient space available
;;
#-:64bit
(system:resize-areas :old (* 256 1024 1024) :new (* 384 1024 1024))
#+:64bit
(system:resize-areas :old (* 640 1024 1024) :new (* 1024 1024 1024))
(setf (sys:gsgc-parameter :expansion-free-percent-new) 5)
(setf (sys:gsgc-parameter :free-percent-new) 2)
(setf (sys:gsgc-parameter :expansion-free-percent-old) 5)

(let* ((logon (system:getenv "LOGONROOT"))
       (lingo (namestring (parse-namestring (format nil "~a/lingo" logon)))))
  ;;
  ;; load MK defsystem() and LinGO load-up library first
  ;;
  (load (format nil "~a/lingo/lkb/src/general/loadup" logon))

  ;;
  ;; for parsing and generation, we need (close to) the full scoop
  ;;
  (unless (find-package :tsdb)
    (pushnew :lkb *features*)
    (pushnew :logon *features*)
    (pushnew :slave *features*)
    (excl:tenuring 
     (funcall (intern "COMPILE-SYSTEM" :make) "tsdb")))
  
  (funcall (symbol-function (find-symbol "INITIALIZE-TSDB" :tsdb)))

  (excl:tenuring 
   (funcall 
    (intern "READ-SCRIPT-FILE-AUX" :lkb)
    (format nil "~a/dfki/mcg/lkb/script" logon))
   (funcall (intern "INDEX-FOR-GENERATOR" :lkb)))

  ;;
  ;; silence the [incr tsdb()] ChaSen wrapper
  ;;
  (set (intern "*CHASEN-DEBUG-P*" :tsdb) nil)

  ;;
  ;; since this client is exclusively used for batch processing, make sure to
  ;; enable packing in parsing and generation.
  ;;
  (set (intern "*CHART-PACKING-P*" :lkb) t)
  (set (intern "*GEN-PACKING-P*" :lkb) t)
  
  ;;
  ;; allow the generator to relax post-generation MRS comparison, if need be
  ;;
  (set (intern "*BYPASS-EQUALITY-CHECK*" :lkb) :filter)
  
  ;;
  ;; _fix_me_
  ;; when translating, pvm-process() does not pass on the full set of variables
  ;; to control the search (as process-item() would).           (10-feb-08; oe)
  ;;
  (set (intern "*MAXIMUM-NUMBER-OF-EDGES*" :lkb) 25000)
  (set (intern "*TSDB-MAXIMAL-NUMBER-OF-EDGES*" :tsdb) 25000)
  (set (intern "*TSDB-MAXIMAL-NUMBER-OF-ANALYSES*" :tsdb) 500)
  (set (intern "*TSDB-EXHAUSTIVE-P*" :tsdb) nil)
  
  (excl:gc :tenure) (excl:gc) (excl:gc t) (excl:gc)
  (setf (sys:gsgc-parameter :auto-step) nil)
  (set (intern "*TSDB-SEMANTIX-HOOK*" :tsdb) "mrs::get-mrs-string")
  (funcall (symbol-function (find-symbol "SLAVE" :tsdb))))
