;; source files
(set @nu_files 	  (filelist "^nu/.*nu$"))

;; framework description
(set @framework "Nuki")
(set @framework_identifier   "nu.programming.nuki")
(set @framework_creator_code "????")

(set @frameworks  '("Cocoa" "Nu"))
(set @includes    "")

(compilation-tasks)
(framework-tasks)

(task "clobber" => "clean" is
      (SH "rm -rf #{@framework_dir}"))


(task "install" => "framework" is
      (SH "sudo rm -rf /Library/Frameworks/#{@framework}.framework")
      (SH "ditto #{@framework}.framework /Library/Frameworks/#{@framework}.framework"))

(task "default" => "framework")

(task "doc" is (SH "nudoc"))
