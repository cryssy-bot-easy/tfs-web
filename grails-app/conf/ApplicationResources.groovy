/*
 * Description:    Added angular modules
 * Modified by:    Cedrick C. Nungay
 * Date Modified:  08/15/2018
 */
/*
 * Description:    Added angular module for mt759
 * Modified by:    Cedrick C. Nungay
 * Date Modified:  08/18/2018
 */
modules = {
    application {
        resource url:'js/application.js'
    }
    angularmodule {
    	resource url:'js/angular.js'
    	resource url:'js/angular-module-init.js'
    }
	requiredDoc {
		dependsOn 'angularmodule'
    	resource url:'js/angular/required-document.service.js'
    	resource url:'js/angular/required-document.controller.js'
	}
	additionalCondition {
		dependsOn 'angularmodule'
		resource url:'js/angular/additional-condition.service.js'
		resource url:'js/angular/additional-condition.controller.js'
	}
	mt759Details {
		dependsOn 'angularmodule'
		resource url:'js/angular/mt759-details.service.js'
		resource url:'js/angular/mt759-details.controller.js'
	}
}
