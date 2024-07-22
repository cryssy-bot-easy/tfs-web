// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

import com.ucpb.tfsweb.utilities.CryptoService

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

grails.plugin.xframeoptions.sameOrigin = true

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}
tfs.report.location.base='http://' + InetAddress.getLocalHost().getHostAddress() + ':8081/tfs-report'
tfs.core.api.query.url = 'http://localhost:9090/tfs-core/api/query/'
tfs.core.api.command.url = 'http://localhost:9090/tfs-core/api/command/'
tfs.command.service.url = "rmi://localhost:1099/commandBusService"
tfs.command.service.interface = "com.incuventure.cqrs.command.CommandBus"
tfs.query.service.url = "rmi://localhost:1099/queryBusService"
tfs.query.service.interface = "com.incuventure.cqrs.query.QueryBus"

tfs.core.api.query2.url = "http://localhost:9090/tfs-core/api/"
tfs.core.api.webapi.url = "http://localhost:9090/tfs-core/api/"

tfs.core.api.cdt.upload.url = "http://localhost:9090/tfs-core/api/cdt/upload"

tfs.constants.sender.address = "TLBPHMM0A"
tfs.constants.sender.suffix = "XXX"

tfs.web.upload.location='/opt/tfs/ATTACHMENTS/'

CryptoService cryptoService = new CryptoService()
String jettyHomeDir = System.getProperty("jetty.home")

File inputFileDir = ((jettyHomeDir != null) && (new File(jettyHomeDir
		+ File.separator + "resources")).isDirectory()) ?
		new File(jettyHomeDir
		+ File.separator + "resources") :
		new File(System.getProperty("user.dir")
		+ File.separator + "grails-app"
		+ File.separator + "conf")

File inputFile = new File(inputFileDir.getAbsolutePath()
	+ File.separator + "tfs-web.properties")

File decryptedFile = new File(inputFileDir.getAbsolutePath()
	+ File.separator + "tfs-web-decrypted.properties")

if (decryptedFile.exists()) {
	decryptedFile.delete()
}

String key = System.getenv().get('APP_ENCRYPTION_PASSWORD').toString()

if ((inputFile.exists()) && (!key.equals("null")) && (!decryptedFile.exists())) {
	cryptoService.decryptFile(key, inputFile, decryptedFile)
}

grails.config.locations = [ "classpath:" + decryptedFile.name ]

tfs.web.config.external = decryptedFile.getAbsolutePath()

tfs.sellingRate.rateNumber = 17

tfs.tfs2.api.url='http://172.22.0.7:8080/tfs-link/'
tfs.tfs2.api.key='apikey12345'