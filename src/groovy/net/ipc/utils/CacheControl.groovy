package net.ipc.utils

/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 4/24/13
 * Time: 7:35 PM
 * To change this template use File | Settings | File Templates.
 */
class CacheControl {

    private static final String HEADER_PRAGMA = "Pragma"
    private static final String HEADER_EXPIRES = "Expires"
    private static final String HEADER_CACHE_CONTROL = "Cache-Control"

    public preventCache (response) {
        response.setHeader(HEADER_PRAGMA, "no-cache")
        response.setDateHeader(HEADER_EXPIRES, 1L)
        response.setHeader(HEADER_CACHE_CONTROL, "no-cache")
        response.addHeader(HEADER_CACHE_CONTROL, "no-store")
    }

}
