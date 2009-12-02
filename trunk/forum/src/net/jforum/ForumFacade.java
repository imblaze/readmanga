package net.jforum;

import net.jforum.entities.User;
import net.jforum.entities.Post;
import net.jforum.view.forum.common.PostCommon;
import net.jforum.dao.PostDAO;
import net.jforum.dao.DataAccessDriver;
import net.jforum.*;
import javax.servlet.http.Cookie;

import org.apache.log4j.Logger;

import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

public class ForumFacade {
    private static final Logger log = Logger.getLogger(ForumFacade.class);
    private static ControllerUtils utils = new ControllerUtils();

    public static User getUserByCookie(Cookie[] cookies){
        return utils.getUserByAutoLogin(cookies);
    }

    public static List<Post> getPosts(int topicId){
        List<Post> result=null;
        try {
            PostDAO postDao = DataAccessDriver.getInstance().newPostDAO();
            result = PostCommon.topicPosts(postDao, false, 0, topicId, 1, 6);
        }catch (Throwable e) {
            log.error("Error getPosts",e);
        }finally {
          JForumExecutionContext.finish();
        }
        if (result==null){
            result=new ArrayList<Post>();
        }
//        Collections.reverse(result);
        return result; 
    }

    @Override
    public String toString() {
        return "ForumFacade is Active";
    }
}
