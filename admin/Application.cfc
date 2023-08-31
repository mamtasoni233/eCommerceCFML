component {

    this.datasource = 'admin';

    // lifespan of an untouched application scope
	this.applicationTimeout = createTimeSpan( 1, 0, 0, 0 );


    // untouched session lifespan
	this.sessionTimeout = createTimeSpan( 1, 0, 0, 0 );

    // session handling enabled or not
    this.sessionManagement = true;
    
    this.javaSettings = {loadPaths: ['../lib/'], loadColdFusionClassPath: true, reloadOnChange: true};

    //this.mappings = structNew();

    //this.mappings["/assets"] =   expandPath('./../assets/'); 
    // this.mappings["/assets"] = expandPath('./../assets/')&"assets";

    function onApplicationStart() {
        application.bcrypt = createObject('java', 'org.mindrot.jbcrypt.BCrypt');
        return true;
    }
/* 
    function onRequest( string targetPage ) {
        if(structKeyExists(URL,'reloadApp')){
            onApplicationStart();
        }
        include arguments.targetPage;
    } */

}
