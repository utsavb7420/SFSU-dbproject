# Final Course Project 

In this project, you will create a real application by using the database model you created in homework 1 and 2. Please refer to the following guidelines to complete your project. 

## Project Guidelines 

Using your database model, and your favorite programming language, create a functional application (console, terminal or GUI) to represent the functionality of your database model with real users. Your program must meet the following high level requeriments: 
 
 * Make sure that your app creates a periodically back up of the database and also saves user transactions to a transactions.sql file that happen between the time the backup was done until the next database backup. Once the next database backup is created, delete the content in the transactions.sql and start again the process. In case of system failure, you may beed to backup using your database backup + the transactions saved in the transactions.sql file until that moment. 

 * The first thing your program needs to do after it is executed is to create your database, tables and insert some sample data using your database model from HW2. Note that this database model should have all the errors encountered in HW2 fixed already. Then, read your transactions.sql file (which is empty at this point). Once this is done show the following menu to the user. All the credentials needed to create the database must be readed from a configuration file. This config file should have at least the following values (host, database_name, username and password). The following will be the initial menu that the program needs to show to the user in screen. 
        
        > User Menu 
        > 1. Create Account 
        > 2. Login 
        > 3. Search
        > 4. Insert 
        > 5. Update
        > 6. Delete 
        > 7. Exit
        
        > Select an option: 1

  * Create user account: the user should be able to create an account in your system. The info provided here depends on the attributes you are required to enter in your account or user table. The following is an example that takes the name, email and password from user input. 
        
        > Name: Jose
        > Email: jortizco@sfsu.com
        > Password: 12345
        
        > Account sucessfully created!
        
        > User Menu 
        > 1. Create Account 
        > 2. Login 
        > 3. Search
        > 4. Insert 
        > 5. Update
        > 6. Delete 
        > 7. Exit
        
        > Select an option: 2
 
 * Login: the user can log into the system using the data provided at registration time. 
 
        > 1. email: jortizco@sfsu.edu
        > 2. password: 12345
        
        >  You are logged as Jose!
        
        > User Menu 
        > 1. Create Account 
        > 2. Login 
        > 3. Search
        > 4. Insert 
        > 5. Update
        > 6. Delete 
        > 7. Exit
        
        > Select an option: 3
        
  * Search: when user selects this option, the user must be able to search for data based on the main entities implemented in your database model.  Take into consideration that a good search functionality should be able to search data from different tables, and show the data organized in the console or terminal. For example, if your database model was modeled for a library system, a good example of a search service in your system would be the following: 
 
       
         > Tables with write/read permissions for Jose. 
         > 1. Book
         > 2. Videos
         > 3. Music
         
         > Select a table to search: 1
         > Enter field: title
         > Enter value: Database System Concepts
         
         > Results: 
         > ISBN:      87736778838
         > Title:     Database System Concepts
         > Author:    Avi Silberschatz
         > Publisher: Parson
           
         > User Menu 
         > 1. Create Account 
         > 2. Login 
         > 3. Search
         > 4. Insert 
         > 5. Update
         > 6. Delete 
         > 7. Exit
        
         > Select an option: 4
         
         
   * Insert: the user of your program must be able to insert data from your database model like in the following example: 
   
         > Tables with write/read permissions for Jose. 
         > 1. Book
         > 2. Videos
         > 3. Music 
           
         > Select a table to insert data: 2
         > Enter fields: ISBM, title, author, length
         > Enter values: 87736773456, my video, jose ortiz, 34
         
         Data succesfully inserted in Video!. 
         
         > User Menu 
         > 1. Create Account 
         > 2. Login 
         > 3. Search
         > 4. Insert 
         > 5. Update
         > 6. Delete 
         > 7. Exit
        
         > Select an option: 5
         
   * Update: the user must be able to update data from your database model. Take into consideration that for update and delete options, you must update or delete all the weak entities that referenced the primary keys of the updated or deleted records. 
         
         > Tables with write/read permissions for Jose. 
         > 1. Book
         > 2. Videos
         > 3. Music 
           
         > Select a table to update data: 2
         > Enter fields: length
         > Enter values: 37
         
         Data succesfully updated in Video!. 
         
         > User Menu 
         > 1. Create Account 
         > 2. Login 
         > 3. Search
         > 4. Insert 
         > 5. Update
         > 6. Delete 
         > 7. Exit
        
         > Select an option: 6
         
         
   * Delete: the user must be able to delete data from your database model
   
         > Tables with write/read permissions for Jose. 
         > 1. Book
         > 2. Videos
         > 3. Music 
         
         > Select a table to delete data: 1
         > Enter field: ISBM
         > Enter value: 87736778838
         
         Data succesfully deleted from Book!. 
         
         > User Menu 
         > 1. Create Account 
         > 2. Login 
         > 3. Search
         > 4. Insert 
         > 5. Update
         > 6. Delete 
         > 7. Exit
        
         > Select an option: 7 
         
## Testing your program

   * This is one of the use cases (among many others) that I will use to test your program. 
       
       1. I will run your program for the first time, and then I will do some inserts, deletes......
       2. I will exit from your program
       3. I will go manually to your database and delete it 
       4. I will run your program again
       5. Your program should detect that the database is not there, and therefore recreate it to its original consistent   
          status before failure. So, it needs to restore the backup database, and any transactions saved in the 
          transactions.sql file until the failure point. The transaction file must only contain write operations.  
           
## Grading Rubrics
  
   * Your program must run in a UNIX terminal, or in a Windows console. You are also free to implement this program using GUI. 
   * If your program does not run, then you´ll get a zero in the project 
   * You must provide clear and complete documentation about how to run your program. If you do not provide docs, you´ll be penalized with 3% of the final grade in this assignment. 
   * If I cannot understand your code, then your code is not good, and you´ll be penalized with 3% of the final grade in this assignment 
   * This assignment is 10% worth of your final grade, for each option that is not implemented, you´ll loose 2%.  
   
## Submission Guidelines 
   * By the due date of this assignment, send an email to the class instructor jortizco@sfsu.edu with the link to your source code in this directory. Don´t forget to add the documentation of your program, including intructions about how to run your program. Late submissions won´t be accepted. 
        
