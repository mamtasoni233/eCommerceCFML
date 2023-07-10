component {
    this.datasource="ecommerce";
    this.javaSettings = {
        loadPaths: [
            "../lib/"
        ],
        loadColdFusionClassPath: true,
        reloadOnChange: true
    };

    function onApplicationStart() {
        application.bcrypt = createObject( "java", "org.mindrot.jbcrypt.BCrypt" );
        return true;
    }
}