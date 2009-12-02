import groovy.net.xmlrpc.*

class CopyToAmazon extends PostChapter{

  CopyToAmazon() {
    super(false)
  }

  def listUrlsLike(String prefix, String locationName) {
   try {
        serv.listUrlsLike(prefix, locationName)
       } catch(Exception e)
       {
         println e.message
       }
  }

  String switchLocation(String prefix, String oldLocation, String locationName) {
   try {
        serv.switchLocation(prefix, oldLocation, locationName)
       } catch(Exception e)
       {
         println e.message
       }
  }
  
  public static void main(String[] args) {
     def self = new CopyToAmazon()
     def amazon = new Amazon()
     def (localPath, prefix) = args
     boolean total = true;
     self.listUrlsLike(prefix, 'LOCAL').each {
     print "${it.url}..."
       boolean res = amazon.put(it.url, localPath + it.url, it.type)
       total = total & res
       println res
     }
     if(total) {
       print 'successfully uploaded to amazon, switching location: ' 
       print self.switchLocation(prefix, 'LOCAL', 'AMAZON')
       println ' chapters switched'
     }
     else {
       println "some files failed, pages is not updated in db, please review log"
     }


/*
     println self.switchLocation('', 'LOCAL', 'AMAZON')
     println self.listUrlsLike('fma/v10ch38/fma-38-02', 'AMAZON')
     println self.switchLocation('', 'AMAZON', 'LOCAL')
*/
  }
}
