import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

// Place your Spring DSL code here
beans = {
//    dateService(org.springframework.remoting.rmi.RmiProxyFactoryBean) {
//        serviceUrl = "rmi://localhost:1199/DateServiceRMI"
//        serviceInterface = "com.earldouglas.springremoting.DateService"
//    }
    commandBusService(org.springframework.remoting.rmi.RmiProxyFactoryBean) {
        serviceUrl = CH.config.tfs.command.service.url
        serviceInterface = CH.config.tfs.command.service.interface
	refreshStubOnConnectFailure = true
	cacheStub = true
	lookupStubOnStartup = false
    }

    queryBusService(org.springframework.remoting.rmi.RmiProxyFactoryBean) {
        serviceUrl = CH.config.tfs.query.service.url
        serviceInterface = CH.config.tfs.query.service.interface
	refreshStubOnConnectFailure = true
	cacheStub = true
	lookupStubOnStartup = false
    }

    commandFactory(com.ucpb.tfsweb.utilities.CommandFactory,
            [
                    "addInstructions" : com.ucpb.tfs.application.command.AddInstructionsCommand.class,
                    "updateInstructions" : com.ucpb.tfs.application.command.UpdateInstructionsCommand.class,
                    "createLoan" : com.ucpb.tfs.application.command.CreateLoanCommand.class,
                    "updateLoan" :  com.ucpb.tfs.application.command.UpdateLoanCommand.class
            ]){
    }

//    importBeans('classpath*:swift/config/swift-builder.xml')
//      importBeans('swift/swift.xml')

    cacheControl(net.ipc.utils.CacheControl)
}
