import groovy.net.xmlrpc.*


def checkArgs() {
  if(args.size() < 2) {
    println 'Usage: ./dir_post.sh <dir> <manga name>'
    System.exit 1
  }
}


checkArgs()
println "creating  PostChapter instance..."
def serv = new PostChapter()

//String base = '/mnt/manga/'
String path = args[0]
String name = args[1]
File dir = new File(path)
def pattern = ~/v([0-9]+)ch([0-9]+)/

if(dir.exists() && dir.isDirectory()) {
  dir.eachFileMatch(pattern) { ch ->
    if(ch.isDirectory()) {
      def m = (ch.name =~ pattern)[0][1..2]
       def v = m[0]
       def c = m[1]
       print "Processing [$name $v $c]..." 
       try {
         def filePath = ch.toString() + '/.list.log';
         print filePath
         def log = new File(filePath).text
         if(log.isEmpty()) {
           println ' - empty file'
           return
         }
         print ' - '
         println serv.postChapter(name, v, c, log)
       } catch(FileNotFoundException e)
       { 
         println ' - not found'
       } catch(Exception e)
       {
         println e.message
       }
    }
  }
}
