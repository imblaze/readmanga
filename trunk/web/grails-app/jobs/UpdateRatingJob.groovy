import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

class UpdateRatingJob {
  def cronExpression = CH.config.manga.rating.job.cronExpression
  def javax.sql.DataSource dataSource
  def needExecute=CH.config.manga.rating.job.execute
  def execute() {
    println "It's time for executing UpdateRatingJob needExecute: $needExecute"
    if (needExecute) {
      println "executing job"
      def sql = new Sql(dataSource)
      sql.executeUpdate("update manga m, (select manga_id,count(1) c from visit where date_created>  DATE_SUB(CURDATE(),INTERVAL 1 MONTH) and chapter_id is not null group by manga_id) s SET m.rating = s.c WHERE m.id=s.manga_id");
    }
  }
}
