component {

    function init() {
        variables.fileSystemUtil.createMapping( "/coldbox", getCwd() & "coldbox" );
        variables.asyncManager = new coldbox.system.async.AsyncManager();
    }

    function getThreadname() {
		return createObject( "java", "java.lang.Thread" ).currentThread().getName();
	}

}