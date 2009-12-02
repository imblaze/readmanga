package net.jforum.api.rest;

import net.jforum.Command;
import net.jforum.JForumExecutionContext;
import net.jforum.context.RequestContext;
import net.jforum.context.ResponseContext;
import net.jforum.exceptions.APIException;
import freemarker.template.Template;
import freemarker.template.SimpleHash;

public abstract class CommonREST extends Command {
    /**
     * Retrieves a parameter from the request and ensures it exists
     * @param paramName the parameter name to retrieve its value
     * @return the parameter value
     * @throws net.jforum.exceptions.APIException if the parameter is not found or its value is empty
     */
    protected String requiredRequestParameter(String paramName)
    {
        String value = this.request.getParameter(paramName);

        if (value == null || value.trim().length() == 0) {
            throw new APIException("The parameter '" + paramName + "' was not found");
        }

        return value;
    }

    /**
     * Tries to authenticate the user accessing the API
     * @throws APIException if the authentication fails
     */
    protected void authenticate()
    {
        String apiKey = this.requiredRequestParameter("api_key");

        RESTAuthentication auth = new RESTAuthentication();

        if (!auth.validateApiKey(apiKey)) {
            throw new APIException("The provided API authentication information is not valid");
        }
    }

    public Template process(RequestContext request, ResponseContext response, SimpleHash context)
    {
        JForumExecutionContext.setContentType("text/xml");
        return super.process(request, response, context);
    }

}
