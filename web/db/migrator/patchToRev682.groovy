import groovy.sql.Sql
this.class.classLoader.rootLoader.addURL(new File('../../lib/mysql-connector-java-5.1.6-bin.jar').toURL())
def sql = Sql.newInstance('jdbc:mysql://localhost/manga', 'manga', 'xxxxx', 'com.mysql.jdbc.Driver')
sql.eachRow("select * from manga", { 
    def m =  it.description =~ /(<img[^>]*>)/
    if(m.size() == 1) {  
      String newDescription = m.replaceFirst('')
      String image = m[0][0]
      sql.execute('update manga set picture = ?, description = ? where id = ?', [image, newDescription, it.id])
    }
  } 
);

