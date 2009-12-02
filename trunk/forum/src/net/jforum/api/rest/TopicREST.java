package net.jforum.api.rest;

import net.jforum.dao.*;
import net.jforum.view.forum.common.TopicsCommon;
import net.jforum.view.forum.common.ViewCommon;
import net.jforum.view.forum.common.ForumCommon;
import net.jforum.util.preferences.TemplateKeys;
import net.jforum.entities.Topic;
import net.jforum.entities.User;
import net.jforum.entities.Post;
import net.jforum.entities.Forum;
import net.jforum.repository.ForumRepository;
import net.jforum.SessionFacade;

import java.util.List;
import java.util.Date;

public class TopicREST extends CommonREST {

    public void list() {
        try {
            int forumId = Integer.valueOf(requiredRequestParameter("id"));
            List topics = TopicsCommon.topicsByForum(forumId, 0);
            this.setTemplateName(TemplateKeys.API_TOPIC_LIST);
            this.context.put("topics", topics);
        } catch (Exception e) {
            this.setTemplateName(TemplateKeys.API_ERROR);
            this.context.put("exception", e);
        }
    }

    /**
     * @see net.jforum.view.forum.PostAction#insertSave() PostAction.insertSave
     */
    public void insert() {
        try {
            TopicDAO topicDao = DataAccessDriver.getInstance().newTopicDAO();
            PostDAO postDao = DataAccessDriver.getInstance().newPostDAO();
            ForumDAO forumDao = DataAccessDriver.getInstance().newForumDAO();
            UserDAO userDao = DataAccessDriver.getInstance().newUserDAO();
            int forumId = Integer.valueOf(requiredRequestParameter("id"));
            String title = requiredRequestParameter("title");
            String postSubject = this.request.getParameter("subject");
            if(postSubject == null) postSubject = "";
            String postText = requiredRequestParameter("text");

            Topic t = new Topic(-1);
            User u = userDao.selectById(2); //admin u

            t.setTitle(title);
            t.setForumId(forumId);

            t.setType(Topic.TYPE_NORMAL);
            t.setTime(new Date());
            t.setPostedBy(u);
            t.setFirstPostTime(ViewCommon.formatDate(t.getTime()));
            int topicId = topicDao.addNew(t);
            t.setId(topicId);
            //creating first post
            Post p = new Post();
            p.setForumId(forumId);
            p.setTopicId(topicId);
            p.setSubject(postSubject);
            p.setText(postText);
            p.setTime(new Date());
            p.setUserId(u.getId());
            p.setUserIp("system-api");

            int postId = postDao.addNew(p);
            p.setId(postId);

            t.setFirstPostId(postId);
            t.setLastPostId(postId);
            t.setLastPostBy(u);
            t.setLastPostDate(p.getTime());
            t.setLastPostTime(p.getFormatedTime());
            topicDao.update(t);
            //update cache?
            Forum forum = ForumRepository.getForum(forumId);
            ForumCommon.notifyUsers(forum, t, p);
            t.setTotalViews(t.getTotalViews() + 1);
            DataAccessDriver.getInstance().newUserDAO().incrementPosts(p.getUserId());
            TopicsCommon.updateBoardStatus(t, postId, true, topicDao, forumDao);
            ForumRepository.updateForumStats(t, u, p);
            SessionFacade.getTopicsReadTime().put(t.getId(),  p.getTime().getTime());

            this.setTemplateName(TemplateKeys.API_TOPIC_INSERT);
            this.context.put("topicId", topicId);

        } catch (Exception e) {
            this.setTemplateName(TemplateKeys.API_ERROR);
            this.context.put("exception", e);
        }
    }
}
