;; source files
(set @nu_files 	  (filelist "^nu/.*nu$"))

(set @frameworks    '("Cocoa" "Nu"))
(set @includes      "")
(set @resources     (filelist "^resources/*"))

;; application description
(set @application              "Nuki")
(set @application_identifier   "nu.programming.nuki")
(set @application_creator_code "????")

;; framework description
(set @framework "Nuki")
(set @framework_identifier   "nu.programming.nuki")
(set @framework_creator_code "????")

;; build configuration
(set @cc "gcc")
(set @cflags "-g -O3 -DMACOSX ")
(set @mflags "-fobjc-exceptions")

(set @ldflags
     ((list
           ((@frameworks map: (do (framework) " -framework #{framework}")) join)
           ((@libs map: (do (lib) " -l#{lib}")) join)
           ((@lib_dirs map: (do (libdir) " -L#{libdir}")) join))
      join))

(compilation-tasks)
(application-tasks)
(framework-tasks)

(task "clobber" => "clean" is
      (SH "rm -rf #{@application_dir}/Nuki.app/"))

(task "default" => "application")

(task "doc" is (SH "nudoc"))
