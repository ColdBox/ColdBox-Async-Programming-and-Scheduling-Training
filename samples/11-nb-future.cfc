component extends="../BaseTask" {

	function compute(){
		//sleep( 1000 );
		print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
		return 2;
	}

	function create(){
		return asyncManager.newFuture( () => compute() )
	}

	function run() {

		print.blueLine( "Starting from: #getThreadname()#" ).toConsole();

		create().thenRun( (data) => {
			// Where is this executing? same thread?
			// Think about it, we want a non-blocking mode.
			print.redLine( "Executing from: #getThreadname()#" ).toConsole();
			print.redLine( data ).toConsole();
		} );

		sleep( 2000 );

	}

	function getThreadname(){
		return createObject( "java", "java.lang.Thread" ).currentThread().getName();
	}

}
