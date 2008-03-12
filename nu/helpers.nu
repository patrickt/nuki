(set? $flash (dict "notice" nil "alert" nil))

(function shell (cmd)
     (NSString stringWithShellCommand: cmd))
     
(function concat-paths (*args)
     (set result "")
     (while (*args)
          (set result (result stringByAppendingPathComponent: (car *args)))
          (set *args (cdr *args)))
     result)



(global REPOSITORY_LOCATION "/Users/patrick/Repositories/Nuki")
