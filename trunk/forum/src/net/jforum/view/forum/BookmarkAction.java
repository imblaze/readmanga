/*
 * Copyright (c) JForum Team
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, 
 * with or without modification, are permitted provided 
 * that the following conditions are met:
 * 
 * 1) Redistributions of source code must retain the above 
 * copyright notice, this list of conditions and the 
 * following  disclaimer.
 * 2)  Redistributions in binary form must reproduce the 
 * above copyright notice, this list of conditions and 
 * the following disclaimer in the documentation and/or 
 * other materials provided with the distribution.
 * 3) Neither the name of "Rafael Steil" nor 
 * the names of its contributors may be used to endorse 
 * or promote products derived from this software without 
 * specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT 
 * HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
 * BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE 
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
 * IN CONTRACT, STRICT LIABILITY, OR TORT 
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 * 
 * Created on Jan 16, 2005 4:48:39 PM
 * The JForum Project
 * http://www.jforum.net
 */
package net.jforum.view.forum;

import net.jforum.*;
import net.jforum.context.RequestContext;
import net.jforum.context.ResponseContext;
import net.jforum.dao.BookmarkDAO;
import net.jforum.dao.DataAccessDriver;
import net.jforum.entities.Bookmark;
import net.jforum.entities.BookmarkType;
import net.jforum.entities.Forum;
import net.jforum.entities.Topic;
import net.jforum.entities.User;
import net.jforum.repository.ForumRepository;
import net.jforum.repository.SecurityRepository;
import net.jforum.security.SecurityConstants;
import net.jforum.util.I18n;
import net.jforum.util.preferences.ConfigKeys;
import net.jforum.util.preferences.SystemGlobals;
import net.jforum.util.preferences.TemplateKeys;
import freemarker.template.SimpleHash;
import freemarker.template.Template;
import org.apache.commons.lang.StringUtils;

/**
 * @author Rafael Steil
 * @version $Id: BookmarkAction.java,v 1.17 2006/08/23 02:13:53 rafaelsteil Exp $
 */
public class BookmarkAction extends Command
{
	public void insert()
	{
		int type = request.getIntParameter("relation_type");
		if (type == BookmarkType.FORUM) {
			addForum();
		}
		else if (type == BookmarkType.TOPIC) {
			addTopic();
		}
		else if (type == BookmarkType.USER) {
			addUser();
		}
        else if (type == BookmarkType.MANGA) {
			addManga();
		}
		else {
			error("Bookmarks.invalidType");
		}
	}
	
	private void addForum()
	{
		Forum f = ForumRepository.getForum(request.getIntParameter("relation_id"));
		String title = f.getName();
		String description = f.getDescription();
		
		Bookmark b = DataAccessDriver.getInstance().newBookmarkDAO().selectForUpdate(
				f.getId(), BookmarkType.FORUM, SessionFacade.getUserSession().getUserId());
		if (b != null) {
			if (b.getTitle() != null) {
				title = b.getTitle();
			}
			
			if (b.getDescription() != null) {
				description = b.getDescription();
			}

			context.put("bookmark", b);
		}
		
		setTemplateName(TemplateKeys.BOOKMARKS_ADD_FORUM);
		context.put("title", title);
		context.put("description", description);
		context.put("relationType", BookmarkType.FORUM);
		context.put("relationId", f.getId());
	}
	
	private void addTopic()
	{
		Topic t = DataAccessDriver.getInstance().newTopicDAO().selectById(request.getIntParameter("relation_id"));
		String title = t.getTitle();
		
		Bookmark b = DataAccessDriver.getInstance().newBookmarkDAO().selectForUpdate(
				t.getId(), BookmarkType.TOPIC, SessionFacade.getUserSession().getUserId());
		if (b != null) {
			if (b.getTitle() != null) {
				title = b.getTitle();
			}
			
			context.put("description", b.getDescription());
			context.put("bookmark", b);
		}
		
		setTemplateName(TemplateKeys.BOOKMARS_ADD_TOPIC);
		context.put("title", title);
		context.put("relationType", BookmarkType.TOPIC);
		context.put("relationId", t.getId());
	}
	
	private void addUser()
	{
		User u = DataAccessDriver.getInstance().newUserDAO().selectById(
				request.getIntParameter("relation_id"));
		String title = u.getUsername();
		
		Bookmark b = DataAccessDriver.getInstance().newBookmarkDAO().selectForUpdate(
				u.getId(), BookmarkType.USER, SessionFacade.getUserSession().getUserId());
		if (b != null) {
			if (b.getTitle() != null) {
				title = b.getTitle();
			}
			
			context.put("description", b.getDescription());
			context.put("bookmark", b);
		}
		
		setTemplateName(TemplateKeys.BOOKMARKS_ADD_USER);
		context.put("title", title);
		context.put("relationType", BookmarkType.USER);
		context.put("relationId", u.getId());
	}

    private void addManga()
	{
        //todo
		String title = request.getParameter("title");
        int mangaId=request.getIntParameter("relation_id");
        String link=request.getParameter("link");
		Bookmark b = DataAccessDriver.getInstance().newBookmarkDAO().selectForUpdate( mangaId, BookmarkType.MANGA,link, SessionFacade.getUserSession().getUserId());
		if (b != null) {
			if (b.getTitle() != null) {
				title = b.getTitle();
			}

			context.put("description", b.getDescription());
			context.put("bookmark", b);
		}

		setTemplateName(TemplateKeys.BOOKMARKS_ADD_MANGA);
		context.put("title", title);
		context.put("relationType", BookmarkType.MANGA);
		context.put("relationId", mangaId);
		context.put("link", link);
	}
	
	public void insertSave()
	{
		Bookmark b = new Bookmark();
		b.setDescription(request.getParameter("description"));
		b.setTitle(request.getParameter("title"));
		
		String publicVisible = request.getParameter("visible");
		b.setPublicVisible(publicVisible != null && publicVisible.length() > 0);
		
		b.setRelationId(request.getIntParameter("relation_id"));
		b.setRelationType(request.getIntParameter("relation_type"));
		b.setUserId(SessionFacade.getUserSession().getUserId());
		
		DataAccessDriver.getInstance().newBookmarkDAO().add(b);
		setTemplateName(TemplateKeys.BOOKMARKS_INSERT_SAVE);
	}
	
	public void updateSave()
	{
		int id = request.getIntParameter("bookmark_id");
		BookmarkDAO bm = DataAccessDriver.getInstance().newBookmarkDAO();
		Bookmark b = bm.selectById(id);
		
		if (!sanityCheck(b)) {
			return;
		}
		
		b.setTitle(request.getParameter("title"));
		b.setDescription(request.getParameter("description"));
		
		String visible = request.getParameter("visible");
		b.setPublicVisible(StringUtils.isNotBlank(visible));
		
		bm.update(b);
		setTemplateName(TemplateKeys.BOOKMARKS_UPDATE_SAVE);
	}
	
	public void edit()
	{
		int id = request.getIntParameter("bookmark_id");
		BookmarkDAO bm = DataAccessDriver.getInstance().newBookmarkDAO();
		Bookmark b = bm.selectById(id);
		
		if (!sanityCheck(b)) {
			return;
		}
		
		setTemplateName(TemplateKeys.BOOKMARKS_EDIT);
		context.put("bookmark", b);
	}
	
	public void delete()
	{
		int id = request.getIntParameter("bookmark_id");
		BookmarkDAO bm = DataAccessDriver.getInstance().newBookmarkDAO();
		Bookmark b = bm.selectById(id);
		
		if (!sanityCheck(b)) {
			return;
		}
		
		bm.remove(id);
		
		JForumExecutionContext.setRedirect(request.getContextPath() + "/bookmarks/list/" + b.getUserId()
				+ SystemGlobals.getValue(ConfigKeys.SERVLET_EXTENSION));
	}
	
	private boolean sanityCheck(Bookmark b)
	{
		if (b == null) {
			error("Bookmarks.notFound");
			return false;
		}
		
		if (b.getUserId() != SessionFacade.getUserSession().getUserId()) {
			error("Bookmarks.notOwner");
			return false;
		}
		
		return true;
	}
	
	private void error(String message)
	{
		setTemplateName(TemplateKeys.BOOKMARKS_ERROR);
		context.put("message", I18n.getMessage(message));
	}
	
	public void disabled()
	{
		error("Bookmarks.featureDisabled");
	}
	
	public void anonymousIsDenied()
	{
		error("Bookmarks.anonymousIsDenied");
	}

	/**
	 * @see net.jforum.Command#list()
	 */
	public void list()
	{
		int userId = request.getIntParameter("user_id");
		
		setTemplateName(TemplateKeys.BOOKMARKS_LIST);
		context.put("bookmarks", DataAccessDriver.getInstance().newBookmarkDAO().selectByUser(userId));
		context.put("forumType", BookmarkType.FORUM);
		context.put("userType", BookmarkType.USER);
		context.put("topicType", BookmarkType.TOPIC);
		context.put("mangaType", BookmarkType.MANGA);
		User u=DataAccessDriver.getInstance().newUserDAO().selectById(userId);
		context.put("user", u);
		context.put("loggedUserId", SessionFacade.getUserSession().getUserId());
		context.put("pageTitle", I18n.getMessage("Bookmarks.for")+" "+u.getUsername());
	}
	
	/**
	 * @see net.jforum.Command#process(net.jforum.context.RequestContext, net.jforum.context.ResponseContext, freemarker.template.SimpleHash) 
	 */
	public Template process(RequestContext request, ResponseContext response, SimpleHash context)
	{
		if (SessionFacade.getUserSession().getUserId() == SystemGlobals.getIntValue(ConfigKeys.ANONYMOUS_USER_ID)
				&& !request.getAction().equals("list")) {
			request.addParameter("action", "anonymousIsDenied");
		}
		else if (!SecurityRepository.canAccess(SecurityConstants.PERM_BOOKMARKS_ENABLED)) {
			request.addParameter("action", "disabled");
		}

		return super.process(request, response, context);
	}
}
