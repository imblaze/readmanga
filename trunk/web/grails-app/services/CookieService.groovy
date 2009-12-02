import javax.servlet.http.Cookie

class CookieService {

    boolean transactional = false

    def getCookie(request,name) {
        request.cookies.find {it.name == name }
    }

    def setCookieValue(request,response, name, value) {
        def cookie = getCookie(request,name)
        if(!cookie) {
            cookie = new Cookie(name, value)
            cookie.maxAge = 3600 * 90 // 90 days
        }
        cookie.value = value
        cookie.path = "/"
        response.addCookie(cookie)
    }
}
