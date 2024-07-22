/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/7/12
 * Time: 2:49 PM
 * To change this template use File | Settings | File Templates.
 */

function generateGuid ()
{
    var S4 = function ()
    {
        return Math.floor(
            Math.random() * 0x10000 /* 65536 */
        ).toString(16);
    };

    return (
        S4() + S4() + "-" +
            S4() + "-" +
            S4() + "-" +
            S4() + "-" +
            S4() + S4() + S4()
        );
}

