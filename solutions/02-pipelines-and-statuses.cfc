/**
 * =================================================================================
 * THIS IS THE SOLUTION FILE. TO WORK ON THE EXERCISES GO TO THE `exercises` FOLDER.
 * =================================================================================
 *
 * This exercise goes over:
 *     + Passing futures to pipelines
 *     + The differences between `then` (`thenAccept` and `thenApply`) and `thenRun`
 *     + The different states of a Future
 *
 * You can run this exercise from the root in CommandBox by running:
 *     `task run exercises/02-pipelines-and-statuses.cfc`
 *
 * You can use the `print` helper provided by CommandBox to log messages.
 * (Use `print.line( "message" ).toConsole()` if you're not familiar with it.)
 * Make sure to end with `.toConsole()` so your message is flushed
 * to the console the moment it is printed.
 */
component extends="../BaseTask" {

    variables.secretKey = "My6406GWQxqDkMthMhQ3NA==";

    /**
     * Create a future that computes a strong hash of a string.
     * (Use the `strongHash( string )` function to compute the hash.)
     * When the task is complete, asynchronously output the hash to the console.
     */
    function partOne() {
        return asyncManager.newFuture( () => strongHash( "password" ) )
            .then( ( hash ) => print.line( hash ).toConsole() );
    }

    /**
     * Create a future that computes a strong hash of a string.
     * (Use the `strongHash( string )` function to compute the hash.)
     * Then, encrypt the hash using the `strongEncrypt( string )` function.
     * Finally, output that value to the console asynchronously.
     */
    function partTwo() {
        return asyncManager.newFuture( () => strongHash( "password" ) )
            .then( ( hash ) => strongEncrypt( hash ) )
            .then( ( encryptedHash ) => print.line( encryptedHash ).toConsole() );
    }

    /**
     * Create a future that computes a strong hash of a string.
     * (Use the `strongHash( string )` function to compute the hash.)
     * Then, encrypt the hash using the `strongEncrypt( string )` function.
     * Then, send that string to a remote server using the `syncToReliableServer( string )` function.
     *
     * While that code is running, display a waiting message that updates every second
     * until the pipeline has completed successfully. For example:
     * ```sh
     * > Starting the process to securely hash, encrypt, and store your password.
     * > Please wait...
     * > Please wait...
     * > Please wait...
     * > Please wait...
     * > Operation completed successfully.
     * ```
     */
    function partThree() {
        print.line( "Starting the process to securely hash, encrypt, and store your password." ).toConsole();

        var future = asyncManager.newFuture( () => strongHash( "password" ) )
            .then( ( hash ) => strongEncrypt( hash ) )
            .then( ( encryptedHash ) => syncToReliableServer( encryptedHash ) );

        while ( true ) {
            sleep( 1000 );
            if ( future.isDone() ) {
                break;
            }
            print.line( "Please wait..." ).toConsole();
        }
        print.line( "Operation completed successfully." ).toConsole();

        return future;
    }

    /**
     * Create a future that computes a strong hash of a string.
     * (Use the `strongHash( string )` function to compute the hash.)
     * Then, encrypt the hash using the `strongEncrypt( string )` function.
     * Then, send that string to a remote server using the `syncToFlakyServer( string )` function.
     *
     * While that code is running, display a waiting message that updates every second
     * until the pipeline has completed successfully. For example:
     * ```sh
     * > Starting the process to securely hash, encrypt, and store your password.
     * > Please wait...
     * > Please wait...
     * > Please wait...
     * > Please wait...
     * > Operation completed successfully.
     * ```
     *
     * Make sure to account for the error case:
     * * ```sh
     * > Starting the process to securely hash, encrypt, and store your password.
     * > Please wait...
     * > Please wait...
     * > Operation failed. Please try again later.
     * ```
     */
    function partFour() {
        print.line( "Starting the process to securely hash, encrypt, and store your password." ).toConsole();

        var future = asyncManager.newFuture( () => strongHash( "password" ) )
            .then( ( hash ) => strongEncrypt( hash ) )
            .then( ( encryptedHash ) => syncToFlakyServer( encryptedHash ) );

        while ( true ) {
            sleep( 1000 );
            if ( future.isDone() ) {
                break;
            }
            print.line( "Please wait..." ).toConsole();
        }
        if ( future.isCompletedExceptionally() ) {
            print.redLine( "Operation failed. Please try again later." ).toConsole();
        } else {
            print.line( "Operation completed successfully." ).toConsole();
        }

        return future;
    }

    function run() {
        print.blueLine( "Running all `02-pipelines-and-statuses` exercises" ).toConsole();

        print.line().line( "Part One" ).toConsole();
        partOne().get();

        print.line().line( "Part Two" ).toConsole();
        partTwo().get();

        print.line().line( "Part Three" ).toConsole();
        partThree().get();

        print.line().line( "Part Four" ).toConsole();
        partFour().get();
    }

    private string function strongHash( required any value ) {
        return getInstance( "@BCrypt" ).hashPassword( arguments.value, 15 );
    }

    private string function strongEncrypt( required any value ) {
        return encrypt( arguments.value, variables.secretKey, "BLOWFISH", "base64" );
    }

    private boolean function syncToReliableServer( required any value ) {
        sleep( randRange( 4000, 8000 ) );
        return true;
    }

    private boolean function syncToFlakyServer( required any value ) {
        if ( randRange( 1, 2 ) == 1 ) {
            sleep( randRange( 2000, 4000 ) );
            throw( "Uh oh...server is being flaky" );
        }
        sleep( randRange( 3000, 6000 ) );
        return true;
    }

    function init() {
        super.init();
        loadModule( shell.pwd() & "modules/bCrypt" );
    }

}