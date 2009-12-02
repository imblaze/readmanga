/*
 * Created on 04/09/2006 21:23:22
 */
package net.jforum.api.rest;

import java.util.List;

import net.jforum.dao.DataAccessDriver;
import net.jforum.dao.UserDAO;
import net.jforum.entities.User;
import net.jforum.exceptions.APIException;
import net.jforum.util.I18n;
import net.jforum.util.preferences.ConfigKeys;
import net.jforum.util.preferences.SystemGlobals;
import net.jforum.util.preferences.TemplateKeys;

/**
 * @author Rafael Steil
 * @version $Id: UserREST.java,v 1.3 2006/10/10 00:49:04 rafaelsteil Exp $
 */
public class UserREST extends CommonREST
{
	/**
	 * List all users
	 */
	public void list()
	{
		try {
			this.authenticate();
			
			UserDAO dao = DataAccessDriver.getInstance().newUserDAO();
			List users = dao.selectAll();
		
			this.setTemplateName(TemplateKeys.API_USER_LIST);
			this.context.put("users", users);
		}
		catch (Exception e) {
			this.setTemplateName(TemplateKeys.API_ERROR);
			this.context.put("exception", e);
		}
	}
	
	/**
	 * Creates a new user.
	 * Required parameters ara "username", "email" and "password".
	 */
	public void insert()
	{
		try {
			this.authenticate();
			
			String username = this.requiredRequestParameter("username");
			String email = this.requiredRequestParameter("email");
			String password = this.requiredRequestParameter("password");
			
			if (username.length() > SystemGlobals.getIntValue(ConfigKeys.USERNAME_MAX_LENGTH)) {
				throw new APIException(I18n.getMessage("User.usernameTooBig"));
			}
			
			if (username.indexOf('<') > -1 || username.indexOf('>') > -1) {
				throw new APIException(I18n.getMessage("User.usernameInvalidChars"));
			}
			
			UserDAO dao = DataAccessDriver.getInstance().newUserDAO();

			if (dao.isUsernameRegistered(username)) {
				throw new APIException(I18n.getMessage("UsernameExists"));
			}
			
			if (dao.findByEmail(email) != null) {
				throw new APIException(I18n.getMessage("User.emailExists", new Object[] { email }));
			}
			
			// Ok, time to insert the user
			User user = new User();
			user.setUsername(username);
			user.setEmail(email);
			user.setPassword(password);
			
			int userId = dao.addNew(user);
			
			this.setTemplateName(TemplateKeys.API_USER_INSERT);
			this.context.put("userId", userId);
		}
		catch (Exception e) {
			this.setTemplateName(TemplateKeys.API_ERROR);
			this.context.put("exception", e);
		}
	}
	
}
