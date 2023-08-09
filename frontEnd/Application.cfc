component {

    this.datasource = 'frontEnd';

    // lifespan of an untouched application scope
    this.applicationTimeout = createTimespan(1, 0, 0, 0);


    // untouched session lifespan
    this.sessionTimeout = createTimespan(1, 0, 0, 0);

    // session handling enabled or not
    this.sessionManagement = true;

    this.javaSettings = {loadPaths: ['../lib/'], loadColdFusionClassPath: true, reloadOnChange: true};

    function onApplicationStart() {
        application.bcrypt = createObject('java', 'org.mindrot.jbcrypt.BCrypt');
        return true;
    }

}
