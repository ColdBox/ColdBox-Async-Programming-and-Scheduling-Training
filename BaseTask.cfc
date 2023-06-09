component {

	function init(){
		fileSystemUtil.createMapping( "/coldbox", resolvePath( "../coldbox" ) );
		variables.asyncManager = new coldbox.system.async.AsyncManager();
	}

	public Future function create(
		required any value,
		numeric timeout = randRange( 200, 1000 )
	){
		return asyncManager.newFuture( () => {
			return compute( value ?: nullValue(), timeout );
		} );
	}

	public any function compute(
		required any value,
		numeric timeout = 0
	){
		print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
		sleep( arguments.timeout );
		return arguments.value ?: nullValue();
	}

}
