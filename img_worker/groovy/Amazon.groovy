import com.amazon.s3.AWSAuthConnection
import com.amazon.s3.CallingFormat
import com.amazon.s3.QueryStringAuthGenerator
import com.amazon.s3.S3Object
class Amazon {
  private final String secretKey = 'secret'
  private final String accessKey = 'secret'
  private final String bucketName = 's.readmanga.ru'
  private final Map contentTypes = [TXT: 'text/plain', JPEG: 'image/jpeg', PNG: 'image/png']
  private AWSAuthConnection conn;
  Amazon() {
    println 'Creating amazon connection'
    this.conn = new AWSAuthConnection(accessKey, secretKey, false)
  }

  boolean put(String url, String path, String type) {
        S3Object object = new S3Object(new File(path).readBytes(), null)
        Map<String, List<String>> headers = ['Content-Type': [contentTypes.get(type)],
                                             'x-amz-acl' : ['public-read']]
        String response
        int count = 0
        while('OK' != response && count < 10) {
          response = conn.put(bucketName, url, object, headers).connection.getResponseMessage()
          count++ 
          if(count>1) println "$response, retring..$count"
        }
        return 'OK' == response 
  }
  public static void main(String[] args) {
    Amazon self = new Amazon()
    println self.put(args[1], args[0], args[2])
  }
}
  
/*
        if (!conn.checkBucketExists(bucketName))
        {
            println '----- creating bucket -----'
            println conn.createBucket(bucketName, AWSAuthConnection.LOCATION_DEFAULT, null).connection.getResponseMessage()
        } 
*/

//        println '----- listing all my buckets -----'
//        println conn.listAllMyBuckets(null).entries
        
//        println conn.delete(bucketName, keyName, null).connection.responseMessage 

//        println '----- deleting bucket -----'
//        println conn.deleteBucket(bucketName, null).connection.responseMessage




/*
        println '----- listing bucket -----'
        println conn.listBucket(bucketName, null, null, null, null).entries

*/
