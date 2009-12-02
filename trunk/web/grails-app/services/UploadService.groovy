import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import ru.readmanga.*

class UploadService {
    def chapterService
    def submissionService
    def backgroundService
    boolean transactional = false
    private static dir = CH.config.manga.upload.dir
    private static cmdPath = CH.config.manga.upload.cmdPath
    private static defLocation = CH.config.manga.upload.location

    def saveFile(manga, vol, chapter, file, messages, t, subject) {
//        dir = "c:/"
        def name = file.getOriginalFilename()
        if (name) {
            messages << "${name}"
            if (!vol || !chapter) {
                messages << "upload.error.properties"
                return
            }

            def ext = name.substring(name.lastIndexOf('.') + 1)?.toLowerCase()
            if (ext != "rar" && ext != "zip") {
                messages << "upload.error.file.ext"
                return
            }
            def time = new Date().time
            def fileName = "${manga.linkName}_${vol}_${chapter}_${time}.${ext}"
            def content = new File("${dir}/upload.files/$fileName")
            if (content.exists()) {
                messages << "upload.error.file.exist"
                return
            }
            file.transferTo(content)
            
            def sub = createSubmission(manga, vol, chapter, messages, subject)
            if (!sub) return
            
            def s="000000" + sub.id
            def dirName="${s[-6..-5]}/${s[-4..-3]}/${s[-2..-1]}"
            
            messages << "upload.done"
            def filePath = "${dir}/upload.files/$fileName"
            def dirPath = "${dir}/work/$dirName"
            def subId = sub.id
            backgroundService.execute("uploading $fileName", {
              println 'Running async job...'
              Submission.withTransaction {
                def proc = "${cmdPath}/index.sh ${dirPath} ${filePath}".execute()
                proc.waitFor()
                println proc.in.text
                def files = new File("${dirPath}/.list.log").text
                println files
                def subm = Submission.get(subId)
                println subm
                submissionService.post(subm, files, false, dirName + '/')
                println subm.pages
                subm.save()
              }
            })
        }

    }

    def createSubmission(manga, vol, chapter, messages, subject) {
        def c = chapterService.find(manga, vol.toInteger(), chapter.toInteger())
        if (c) {
            messages << "upload.error.chapter.exist"
            return null
        } else {
            c = new Chapter(vol: vol, num: chapter, manga: manga)
            if (!c.save()) {
                messages << "$c.errors"
                return null
            }
        }
        Submission sub = new Submission(location: defLocation)
        def perm = subject?.hasRole(ShiroRole.ADMIN) || subject?.hasRole(ShiroRole.MODERATOR) /*|| subject?.principal?.trans?.id == transl*/
        sub.hidden =!perm
        sub.user=(ShiroUser) subject?.principal
        sub.chapter = c
        if (!sub.save()) {
            messages << "$sub.errors"
            return null
        }
        println "$sub.id"
        return sub
    }
}
