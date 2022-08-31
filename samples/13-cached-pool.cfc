component {

	property name="asyncManager" inject="wirebox:asyncManager";

	function init() {
		variables.ioBound = asyncManager.newExecutor( name : "ioBound", type: "cached" );
	}

	function compute(){
		sleep( 1000 );
		print.blueLine( "Computing from: #getThreadname()#" ).toConsole();
		return 2;
	}

	function create(){
		// Where is this executing now?
		return asyncManager.newFuture( () => compute(), ioBound )
	}

	function run() {

		print.blueLine( "Starting from: #getThreadname()#" ).toConsole();

		create().then( (data) => {
			// Where is this executing now?
			print.redLine( "Executing from: #getThreadname()#" ).toConsole();
			print.greenLine( data ).toConsole();
		} );

		sleep( 2000 );

	}

	function getThreadname(){
		return createObject( "java", "java.lang.Thread" ).currentThread().getName();
	}

}
