component extends="../BaseTask" {

	function init(){
		super.init();
		variables.ioBound = asyncManager.newExecutor( name: "ioBound", threads: 10 );
	}

	function create(){
		// Where is this executing now?
		return asyncManager.newFuture( () => compute( 88 ), ioBound )
	}

	function run(){
		print.blueLine( "Starting from: #getThreadname()#" ).toConsole();

		create().then( ( data ) => {
			// Where is this executing now?
			print.redLine( "Then Executing from: #getThreadname()#" ).toConsole();
			print.greenLine( data ).toConsole();
		} );

		sleep( 2000 );
	}

}
