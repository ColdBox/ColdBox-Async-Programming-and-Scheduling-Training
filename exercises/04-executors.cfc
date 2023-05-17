/**
 * This exercise goes over:
 *     + Creating executors
 *     + Using a custom executor for a Future
 *     + Cancelling running threads when cancelling a Future.
 *
 * You can run this exercise from the root in CommandBox by running:
 *     `task run exercises/04-executors.cfc`
 *
 * You can use the `print` helper provided by CommandBox to log messages.
 * (Use `print.line( "message" ).toConsole()` if you're not familiar with it.)
 * Make sure to end with `.toConsole()` so your message is flushed
 * to the console the moment it is printed.
 */
component extends="../BaseTask" {

	/**
	 * Create 10 futures that prints the current time after a 1 second sleep.
	 * Observe how frequent the futures complete.
	 */
	function partOne(){
		return;
	}

	/**
	 * Create a custom single executor
	 * Create 10 futures that prints the current time after a 1 second sleep.
	 * Run those futures using the custom single exector you created.
	 * Observe how frequent the futures complete.
	 */
	function partTwo(){
		return;
	}

	/**
	 * Create a custom fixed executor with 4 threads.
	 * Create 10 futures that prints the current time after a 1 second sleep.
	 * Run those futures using the custom fixed exector you created.
	 * Observe how frequent the futures complete.
	 */
	function partThree(){
		return;
	}

	/**
	 * Create a future that prints the current time after a 5 second sleep.
	 * After 2 seconds, cancel the future.
	 * Question: what do you see in the console?
	 */
	function partFour(){
		return;
	}

	/**
	 * Create a custom executor.
	 * Create a future that prints the current time after a 5 second sleep.
	 * Run that future using the custom exector you created.
	 * After 2 seconds, cancel the future and shutdown the custom executor.
	 * Question: what do you see in the console?
	 */
	function partFive(){
		return;
	}

	function run(){
		print.blueLine( "Running all `04-executors` exercises" ).toConsole();
		print
			.yellowLine( "Press Ctrl-C to exit" )
			.line()
			.toConsole();

		partOne();
		partTwo();
		partThree();
		partFour();
		partFive();

		while ( true ) {
			if ( !isNull( checkInterrupted() ) ) {
				return;
			}
			sleep( 100 );
		}
	}

}
