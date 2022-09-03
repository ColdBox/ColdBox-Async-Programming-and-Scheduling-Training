component extends="../BaseTask" {

	function run() {
		asyncManager.newFuture( () => 1 / 0 );

        sleep( 500 );

        print.line( "Still running" ).toConsole();
	}

}