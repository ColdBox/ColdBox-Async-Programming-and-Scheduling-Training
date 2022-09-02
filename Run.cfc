component{

    function init() {
        fileSystemUtil.createMapping( "/coldbox", getCwd() & "coldbox" );
        variables.asyncManager = new coldbox.system.async.AsyncManager();
    }

}