/**
 * =================================================================================
 * THIS IS THE SOLUTION FILE. TO WORK ON THE EXERCISES GO TO THE `exercises` FOLDER.
 * =================================================================================
 *
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
    function partOne() {
        var futures = [];
        for ( var i = 1; i <= 10; i++ ) {
            futures.append(
                asyncManager.newFuture( () => {
                    sleep( 1000 );
                    print.line( dateTimeFormat( now(), "full" ) ).toConsole();
                } )
            );
        }

        for ( var future in futures ) {
            future.get();
        }

        return asyncManager.newCompletedFuture( true );
    }

    /**
     * Create a custom single executor
     * Create 10 futures that prints the current time after a 1 second sleep.
     * Run those futures using the custom single exector you created.
     * Observe how frequent the futures complete.
     */
    function partTwo() {
        var executor = asyncManager.newSingleExecutor( "custom-single-executor" );
        var futures = [];
        for ( var i = 1; i <= 10; i++ ) {
            futures.append(
                asyncManager.newFuture( () => {
                    sleep( 1000 );
                    print.line( dateTimeFormat( now(), "full" ) ).toConsole();
                }, executor )
            );
        }

        for ( var future in futures ) {
            future.get();
        }

        return asyncManager.newCompletedFuture( true );
    }

    /**
     * Create a custom fixed executor with 4 threads.
     * Create 10 futures that prints the current time after a 1 second sleep.
     * Run those futures using the custom fixed exector you created.
     * Observe how frequent the futures complete.
     */
    function partThree() {
        var executor = asyncManager.newExecutor( "custom-fixed-executor", "fixed", 4 );
        var futures = [];
        for ( var i = 1; i <= 10; i++ ) {
            futures.append(
                asyncManager.newFuture( () => {
                    sleep( 1000 );
                    print.line( dateTimeFormat( now(), "full" ) ).toConsole();
                }, executor )
            );
        }

        for ( var future in futures ) {
            future.get();
        }

        return asyncManager.newCompletedFuture( true );
    }

    /**
     * Create a future that prints the current time after a 5 second sleep.
     * After 2 seconds, cancel the future.
     * Question: what do you see in the console?
     */
    function partFour() {
        var future = asyncManager.newFuture( () => {
            sleep( 5000 );
            print.line( dateTimeFormat( now(), "full" ) ).toConsole();
        } );

        sleep( 2000 );

        future.cancel();

        return asyncManager.newCompletedFuture( true );
    }

    /**
     * Create a custom executor.
     * Create a future that prints the current time after a 5 second sleep.
     * Run that future using the custom exector you created.
     * After 2 seconds, cancel the future and shutdown the custom executor.
     * Question: what do you see in the console?
     */
    function partFive() {
        var executor = asyncManager.newExecutor( "custom-cancellable-executor" );

        var future = asyncManager.newFuture( () => {
            sleep( 5000 );
            print.line( dateTimeFormat( now(), "full" ) ).toConsole();
        }, executor );

        sleep( 2000 );

        future.cancel();
        executor.shutdownNow();

        return asyncManager.newCompletedFuture( true );
    }

    function run() {
        print.blueLine( "Running all `04-executors` exercises" ).toConsole();

        print.line().line( "Part One" ).toConsole();
        partOne().get();

        print.line().line( "Part Two" ).toConsole();
        partTwo().get();

        print.line().line( "Part Three" ).toConsole();
        partThree().get();

        print.line().line( "Part Four" ).toConsole();
        partFour().get();

        print.line().line( "Part Five" ).toConsole();
        partFive().get();
    }

}