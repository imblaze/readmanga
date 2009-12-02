import groovy.net.xmlrpc.*

class PostChapter {

  def serv
  PostChapter(boolean test = false) {
    serv = getService(test)
  }

  def getService(boolean test) {
    println "Getting service... $test"
    if(test)
       return new XMLRPCServerProxy("http://localhost:8080/manga/admin/submission/rpc")
    else      
       return new XMLRPCServerProxy("http://new.readmanga.ru:82/admin/submission/rpc")

  }

  String postChapter(String name, String v, String c, String log) {
   try {
         serv.postChapter(name, v, c, log)
       } catch(Exception e)
       {
         e.message
       }
  }
  public static void main(String[] args) {
     if(args.size() < 4) {
       println 'Usage: ./post_chapter.sh <manga name> <vol> <chapter> <.list.log content>'
       System.exit 1
     }
     def self = new PostChapter(true)
     println self.postChapter(args[0], args[1], args[2], args[3])
  }
}
