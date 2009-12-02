import org.apache.shiro.authc.AccountException
import org.apache.shiro.authc.IncorrectCredentialsException
import org.apache.shiro.authc.UnknownAccountException
import org.apache.shiro.authc.SimpleAccount
import org.apache.shiro.authz.permission.WildcardPermission
import common.api.SharedMap
import ru.readmanga.*

class ShiroDbRealm {
    static authTokenClass = ru.readmanga.UserRequestToken

    def credentialMatcher
    def shiroPermissionResolver

    def authenticate(authToken) {
        def request = authToken.request
        def value = authToken.forumSessionId
//        println "ShiroDbRealm sessionId: $value"
        def user = SharedMap.get("forumCache")?.get("sessions/logged", value)?.user

        if (!user) {
//            println "getting user from Facade ${SharedMap.get("forumFacade")}"
            user = SharedMap.get("forumFacade")?.getUserByCookie(request.cookies)
//            user = [id:12, username:"testUser"]  // todo for testing
            if (user) {
                def session = request.getSession(true)
                session.autoLogin = true
//                println "ShiroDbRealm AutoLogin: true"
            }
//            println "user ${user}"
        }
//        println "getting user from forumCache $user"

        if (!user) {
            throw new UnknownAccountException("No account found for user ")
        }

        def shiroUser = ShiroUser.findByForumId(user.id)
        if (!shiroUser) {
            shiroUser = new ShiroUser(username: user.username, forumId:user.id)
            shiroUser.addToPermissions("*:*")

            shiroUser.addToRoles(ShiroRole.findByName("USER"))
            if (!shiroUser.save())
                println(shiroUser.errors)
        }
//        println "Shiro user is $shiroUser"
        return new SimpleAccount(shiroUser, "null", "ShiroDbRealm")
    }

    def hasRole(principal, roleName) {
        def roles = ShiroUser.withCriteria {
            roles {
                eq("name", roleName)
            }
            eq("username", principal.username)
        }

        return roles.size() > 0
    }

    def hasAllRoles(principal, roles) {
        def r = ShiroUser.withCriteria {
            roles {
                'in'("name", roles)
            }
            eq("username", principal.username)
        }

        return r.size() == roles.size()
    }

    def isPermitted(principal, requiredPermission) {
        // Does the user have the given permission directly associated
        // with himself?
        //
        // First find all the permissions that the user has that match
        // the required permission's type and project code.
        def user = ShiroUser.findByUsername(principal.username)

        def permissions = user.permissions

        // Try each of the permissions found and see whether any of
        // them confer the required permission.
        def retval = permissions?.find { permString ->
            // Create a real permission instance from the database
            // permission.
            def perm = shiroPermissionResolver.resolvePermission(permString)

            // Now check whether this permission implies the required
            // one.
            if (perm.implies(requiredPermission)) {
                // User has the permission!
                return true
            }
            else {
                return false
            }
        }

        if (retval != null) {
            // Found a matching permission!
            return true
        }

        // If not, does he gain it through a role?
        //
        // Get the permissions from the roles that the user does have.
        def results = ShiroUser.executeQuery("select distinct p from ShiroUser as user join user.roles as role join role.permissions as p where user.username = '$principal.username'")
        println "Results: $results"

        // There may be some duplicate entries in the results, but
        // at this stage it is not worth trying to remove them. Now,
        // create a real permission from each result and check it
        // against the required one.
        retval = results.find { permString ->
            // Create a real permission instance from the database
            // permission.
            def perm = shiroPermissionResolver.resolvePermission(permString)

            // Now check whether this permission implies the required
            // one.
            if (perm.implies(requiredPermission)) {
                // User has the permission!
                return true
            }
            else {
                return false
            }
        }

        if (retval != null) {
            // Found a matching permission!
            return true
        }
        else {
            return false
        }
    }
}
