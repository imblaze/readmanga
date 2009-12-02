package ru.readmanga

import org.apache.shiro.authc.UsernamePasswordToken
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

public class UserRequestToken extends UsernamePasswordToken{
    HttpServletRequest request
    HttpServletResponse response
    String forumSessionId


    def UserRequestToken(request, response, forumSessionId) {
        this.request = request;
        this.forumSessionId = forumSessionId
        this.response = response
    }
}