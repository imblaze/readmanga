import ru.readmanga.*
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication

class BootStrap {

     def init = { servletContext ->
        if (GrailsUtil.environment != GrailsApplication.ENV_DEVELOPMENT) {
          log.info('running not in dev environment - no BootStrap')
          return
        }

        //Create test data

       def adminRole = new ShiroRole(name: ShiroRole.ADMIN)
       adminRole.save()
       def userRole = new ShiroRole(name: ShiroRole.USER)
       userRole.save()
       def   moderRole  = new ShiroRole(name:ShiroRole.MODERATOR)
       moderRole.save()

       def user = new ShiroUser(username: "testUser", forumId:12)
       user.addToPermissions("*:*")
//       user.addToRoles(adminRole)
       user.addToRoles(userRole)
       user.addToRoles(moderRole)
       user.save()


       SiteBlock sb = new SiteBlock(name: 'user_agreement', body: 'test body of user_agreement ')
       SiteBlock sb1 = new SiteBlock(name: 'welcome', body: '<b> welcome</b>')
       SiteBlock sb2 = new SiteBlock(name: 'news', body: '<i> news</i>')
       sb.save()
       sb1.save()
       sb2.save()
       def g1 = new Genre(name: 'comedy',title:'Комедия' )
       g1.save()
       def g2 = new Genre(name: 'war')
       g2.save()
       def g3 = new Genre(name: 'vampire', title:'Вампиры')
       g3.save()

       def t = new Translator(link: "demo", name:"demo")
       t.save()
       
       def s = new Submission().
          addToPages(new Page(url: "fma/v10ch38/fma-38-00.png", size: 546000, w:760, h:1200, type: ImageType.PNG, md5: '0' )).
          addToPages(new Page(url: "fma/v10ch38/fma-38-01.png", size: 1140000, w:760, h:1200, type: ImageType.PNG, md5: '0' )).
          addToPages(new Page(url: "fma/v10ch38/fma-38-02-03.png", size: 450000, w:1525, h:1200, type: ImageType.PNG, md5: '0' )).
          addToPages(new Page(url: "fma/v10ch38/fma-38-04.jpg", size: 666600, w:760, h:1200, type: ImageType.JPEG, md5: '0' )).
          addToPages(new Page(url: "fma/v10ch38/fma-38-02-03.png", size: 2500000, w:1567, h:1200, type: ImageType.PNG, md5: '0' ))
          s.hidden=true
//          s.location=Location.AMAZON
//          s.save()

        def s1 = new Submission().
          addToPages(new Page(url: "fma/v10ch38/fma-38-00.png", size: 0, w:760, h:1200, type: ImageType.PNG, md5: '0' )).
          addToPages(new Page(url: "fma/v10ch38/fma-38-01.png", size: 0, w:760, h:1200, type: ImageType.PNG, md5: '0' ))
//        save()

        def m = new Manga(name: 'One Piece', engName: 'One Piece', description: 'Описание манги из <b>БД</b>', mature: true, topicId:211);
        m.save();
        m.addToChapters(new Chapter(vol: 1, num: 1, name: 'название первое')).
          addToChapters(new Chapter(vol: 2, num: 2, name: 'название второе')).
          addToChapters(new Chapter(num: 3))
       m.genres = [g1, g2]
       m.save(flush: true)


       def m1 = new Manga(name: 'Наруто', engName: 'Naruto');
       m1.genres = [g2, g3]
       m1.save(flush: true)


       m1 = new Manga(name: '666 Satan', engName: '666 сатан');
       m1.genres = [g2, g3]
       m1.save(flush: true)

       def c = Chapter.findByMangaAndNum(Manga.findByName('One Piece'), 1)
//       println c
       s.setChapter(c)
       s.save(flush: true)

       def c1 = Chapter.findByMangaAndNum(Manga.findByName('One Piece'), 2)
       s1.setChapter(c1)
       s1.save(flush: true)

       c = Chapter.findByMangaAndNum(Manga.findByName('One Piece'), 1)
       println c.sub?.dateCreated
       
//       new Submission().
//          addToPages(new Page(url: "test.url1", size: 0, w:100, h:100)).
//       save()
         new Twitt(sub: s, message: "my test text page 1 t0", user:user, page: 1).save()
       new Twitt(sub: s, message: "my test text page 2 t1", user:user, page: 2).save()
       new Twitt(sub: s, message: "my test text page 2 t2", user:user, page: 2).save()
       new Twitt(sub: s, message: "my test text page 1 t3", user:user, page: 1).save()
       new Twitt(sub: s, message: "my test text page 1 t4", user:user, page: 1).save()
        new Twitt(sub: s1, message: "my test text page 1 t5", user:user, page: 1).save()
         new Twitt(sub: s1, message: "my test text page 1 t5", user:user, page: 1).save()

       println s.errors
       println m.errors

       println Submission.list()
       println Manga.list()
       println Genre.list()
     }
     def destroy = {
     }
} 
