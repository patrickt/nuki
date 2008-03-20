(global UNICODE 4)

(global shell
        (do (cmd)
            (NSString stringWithShellCommand: cmd)))

(global concat-paths
        (do (*args)
            (set result "")
            (while (*args)
                   (set result (result stringByAppendingPathComponent: (car *args)))
                   (set *args (cdr *args)))
            result))
