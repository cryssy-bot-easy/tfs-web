class BootStrap {

    def dropdownService
    def grailsApplication

    def init = { servletContext ->
		if (grailsApplication.config.tfs.web.config.external != null) {
			new File(grailsApplication.config.tfs.web.config.external).delete()
		}	

        println("| Initializing dropdown values...")
        servletContext.dropdownValues = dropdownService.initializeDropdowns()
        println("| Dropdown values initialized.")
    }
    def destroy = {
    }

}
