import traceback
from pathlib import Path

from payroll.consts import MAIN_ENTITIES
from payroll.database import DB


def setup_database():
    """
    Setup database by reading configs from provided file.
    :return:
    """
    # Driver execution.....
    print("Setting up the database......")

    # DB API object
    db = DB(config_file="payroll\DBconfig.conf")
    database = "payrollDB"
    if not db.is_database_exists(database=database):
        if not db.create_database(database=database, drop_database_first=False):
            print("An error occurred while creating database {} ".format(database))
            return

        print("Created database {}".format(database))
        db.run_sql_file(Path("payroll/databasemodel.sql"))
        db.run_sql_file(Path("payroll/insert.sql"))
        db.run_sql_file(Path("payroll/transactions.sql"))

    print("\nSet up process finished\n")
    return db


def show_table_names():
    """
    Show all the tables names
    :param tables: a list with the tables names.
                   You can get it by calling the method
                   get_table_names() from DB object
    :return: VOID
    """
    print("\nTables:")
    for index, table in enumerate(MAIN_ENTITIES):
        print(f"{index}: {table}")


def get_table_name(index):
    """
    Get table name provide index
    :param index:
    :return:
    """
    for table, index_ in enumerate(MAIN_ENTITIES):
        if index == index_:
            return table


def show_menu():
    """
    Prints in console the main menu
    :return: VOID
    """
    print("User Menu \n"
          "1. Create Account \n"
          "2. Login \n"
          "3. Search \n"
          "4. Insert \n"
          "5. Update \n"
          "6. Delete \n"
          "7. Exit \n")


def register_account():
    """
    Register account for a given user
    :return:
    """
    email, password, name = None, None, None
    try:
        name = input("Name: ")
        email = input("Email: ")
        password = input("Password: ")

        print(f"Registering user account with Name {name}")
        db = DB(config_file="payroll/DBconfig.conf")
        if db.insert(table="user_login", attributes=("name", "email", "password"), values=(name, email, password)):
            print("Data successfully inserted into {} \n".format("user_login"))
    except:
        print(f"Error:", {(email, password, name)}, "failed to be inserted in user_login\n")


def login_account():
    """
    Login to user's account based on credentials provided
    :return:
    """
    email, password, name = None, None, None
    try:
        email = input("Email: ")
        password = input("Password: ")
        print("Logging in.....\n")

        query = f"""SELECT * FROM user_login WHERE email = %s AND password = %s"""
        db = DB(config_file="payroll/DBconfig.conf")
        results = db.select(query=query, values=(email, password))
        if len(results) == 0:
            return False

        for result in results:
            name = result[0]

    except Exception as ex:
        print(ex)
        print(f"Error: {(email, password)} Failed to be authenticate user\n")
    else:
        print(f"User with email {email} logged in successfully")
        return name


def search(is_logged_in, user):
    """
    Search for a particular field and value with selected tabele
    :return:
    """
    if not is_logged_in:
        print("Please Login to use this functionality....\n")
        return

    print(f"Tables with write/read permissions for {user}")
    try:
        db = DB(config_file="payroll/DBconfig.conf")
        show_table_names()

        # get user input
        table_selected = input("\nSelect a table to search: ")
        attribute_selected = input("Enter field (i.e name)? ")
        value_selected = input("Enter value: ")

        table_selected = get_table_name(table_selected)
        if table_selected == "admin":
            query = f"""SELECT a.permission as Admin_permission, emp.name, a.notes, emp.emp_id, emp.dob, 
                        emp.city, emp.mobile_number FROM Employee emp JOIN admin a ON a.Employee_emp_id = 
                        emp.emp_id WHERE a.{attribute_selected} = %s"""

        elif table_selected == "attendence":
            query = f"""SELECT emp.name, emp.city, a.type, a.status, a.check_in, a.check_out
                        FROM attendence a JOIN Employee_has_attendence ea ON 
                        ea.attendence_a_id = a.a_id JOIN Employee emp ON emp.emp_id = ea.Employee_emp_id 
                        WHERE a.{attribute_selected} = %s"""

        elif table_selected == "Employee_history":
            query = f"""SELECT emp.name, emp.city, h.start_date, h.experience, emp.city As employeeCity
                        FROM Employee emp JOIN Employee_history h ON 
                        h.h_id = emp.Employee_history_h_id WHERE h.{attribute_selected} = %s"""

        elif table_selected == "executive":
            query = f"""SELECT e.title as Title, emp.name, emp.emp_id, emp.dob, 
                        emp.city, emp.mobile_number FROM Employee emp JOIN executive e ON e.Employee_emp_id = 
                        emp.emp_id WHERE e.{attribute_selected} = %s"""

        elif table_selected == "payroll":
            query = f"""SELECT p.base_year as BaseYear, c.name, p.payrollcol as Payroll
                        FROM payroll p JOIN company c ON p.company_c_id = c.c_id 
                        WHERE p.{attribute_selected} = %s"""

        elif table_selected == "project":
            query = f"""SELECT p.name, t.description, t.field, t.name
                        FROM project p JOIN project_type t ON p.project_type_type_id = t.type_id 
                        WHERE p.{attribute_selected} = %s"""

        elif table_selected == "vp":
            query = f"""SELECT e.title as Title, emp.name, emp.emp_id, emp.dob, 
                        emp.city, emp.mobile_number FROM Employee emp JOIN vp e ON e.Employee_emp_id = 
                        emp.emp_id WHERE e.{attribute_selected} = %s"""

        elif table_selected == "salary":
            query = f"""SELECT s.start_date, s.hours_worked, e.name, e.city, e.dob FROM salary s JOIN 
                        Employee e ON s.Employee_emp_id = e.emp_id WHERE e.{attribute_selected} = %s"""

        elif table_selected == "salary_history":
            query = f"""SELECT s.date, s.salary, e.name, e.city, e.dob FROM salary_history s JOIN Employee 
                        e ON s.Employee_emp_id = e.emp_id WHERE s.{attribute_selected} = %s"""

        else:
            query = """SELECT * FROM {} WHERE {} = %s""".format(table_selected, attribute_selected)

        value = value_selected

        # get the results from the above query
        results, field_names = db.select(query=query, values=value)
        column_index = 0

        print("\n")
        print("Results from: " + table_selected)
        for column in field_names:
            for result in results:
                print(f"{column}: {result[column_index]}")
            column_index += 1
        print("\n")

    except Exception as err:
        print("The data requested couldn't be found\n")


def insert(is_logged_in, user):
    """
    Insert data provided by user into selected table    
    :return: 
    """
    if not is_logged_in:
        print("Please Login to use this functionality....\n")
        return

    print(f"Tables with write/read permissions for {user}")
    try:
        show_table_names()

        # get user input for insert
        table = input("\nEnter a table to insert data: ")
        attributes_str = input("Enter the name attribute/s separated by comma? ")
        values_str = input("Enter the values separated by comma: ")

        table = get_table_name(table)

        # from string to list of attributes and values
        if "," in attributes_str:  # multiple attributes
            attributes = attributes_str.split(",")
            values = values_str.split(",")
        else:  # one attribute
            attributes = [attributes_str]
            values = [values_str]

        db = DB(config_file="payroll/DBconfig.conf")
        if db.insert(table=table, attributes=attributes, values=values):
            print("Data successfully inserted into {} \n".format(table))

    except Exception as err:
        print("Error:", values_str, "failed to be inserted in ", table, "\n")


def update(is_logged_in, user):
    if not is_logged_in:
        print("Please Login to use this functionality....\n")
        return

    print(f"Tables with write/read permissions for {user}")
    try:
        show_table_names()
        table = input("\nEnter a table to insert data: ")
        attributes_str = input("Enter the name attribute/s separated by comma? ")
        values_str = input("Enter the values separated by comma: ")

        table = get_table_name(table)

        # from string to list of attributes and values
        if "," in attributes_str:  # multiple attributes
            attributes = attributes_str.split(",")
            values = values_str.split(",")
        else:  # one attribute
            attributes = [attributes_str]
            values = [values_str]

        query = """UPDATE {} SET {} = %s""".format(table, attributes)

        db = DB(config_file="payroll/DBconfig.conf")
        if db.update(query=query, values=values):
            print("Data successfully update to {} \n".format(table))

    except Exception as err:
        print("Error:", values_str, "failed to be updated to ", table, "\n")


def delete(is_logged_in, user):
    """
    This method verifies if the user is logged in and then deletes a row on input provided by user
    :return:
    """
    if not is_logged_in:
        print("Please Login to use this functionality....\n")
        return

    print(f"Tables with write/read permissions for {user}")
    try:
        show_table_names()
        # get user input for delete
        table = input("\nSelect a table to delete data: ")
        attribute_str = input("Enter field ")
        value_str = input("Enter the value: ")

        table = get_table_name(table)

        # Select query to verify if the values exist, before moving onto deletion
        db = DB(config_file="payroll/DBconfig.conf")
        query = f"""SELECT * FROM {table} WHERE {attribute_str} = %s"""
        results, _ = db.select(query=query, values=value_str)
        if not results:
            print("The information you have provided does not exist")
            return

        result = results[0]
        if table == "Specialization":
            query = """DELETE FROM Employee_has_Specialization WHERE Specialization_s_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "project_type":
            query = """SELECT * FROM project WHERE project_type_type_id = %s"""
            results, _ = db.select(query=query, values=value_str)

            query = """DELETE FROM Employee_has_project WHERE project_p_id = %s"""
            db.delete(query=query, values=results[0][0])

            query = """DELETE FROM project_has_bonus WHERE project_project_type_type_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM project WHERE project_type_type_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "project":
            query = """DELETE FROM project_has_bonus WHERE project_p_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM Employee_has_project WHERE project_p_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "payroll":
            query = """DELETE FROM bank_has_payroll WHERE payroll_p_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM payroll_has_bonus WHERE payroll_p_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "paygrade":
            query = """DELETE FROM department_has_paygrade WHERE paygrade_p_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "event_type":
            query = """SELECT * FROM Event WHERE event_type_e_id = %s"""
            results, _ = db.select(query=query, values=result[0])

            query = """DELETE FROM department_has_Event WHERE Event_e_id = %s"""
            db.delete(query=query, values=results[0][0])

            query = """DELETE FROM Event WHERE event_type_e_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "Event":
            query = """DELETE FROM department_has_Event WHERE Event_e_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "Employee":
            query = """DELETE FROM Employee_has_Specialization WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM Employee_has_project WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM Employee_has_attendence WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM vp WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM executive WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM admin WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM salary_history WHERE Employee_emp_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "department":
            query = """DELETE FROM department_has_Event WHERE department_d_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM department_has_paygrade WHERE department_d_id = %s"""
            db.delete(query=query, values=result[0])

            query = f"""SELECT * FROM Employee WHERE department_d_id = %s"""
            e_results, _ = db.select(query=query, values=result[0])
            for e_result in e_results:
                query = """DELETE FROM Employee_has_Specialization WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM Employee_has_project WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM Employee_has_attendence WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM vp WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM executive WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM admin WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM salary_history WHERE Employee_emp_id = %s"""
                db.delete(query=query, values=e_result[0])

                query = """DELETE FROM Employee WHERE emp_id = %s"""
                db.delete(query=query, values=e_result[0])

        elif table == "company":
            query = f"""SELECT * FROM department WHERE company_c_id = %s"""
            d_results, _ = db.select(query=query, values=result[0])
            for d_result in d_results:
                query = """DELETE FROM department_has_Event WHERE department_d_id = %s"""
                db.delete(query=query, values=d_result[0])

                query = """DELETE FROM department_has_paygrade WHERE department_d_id = %s"""
                db.delete(query=query, values=d_result[0])

                query = f"""SELECT * FROM Employee WHERE department_d_id = %s"""
                e_results, _ = db.select(query=query, values=d_result[0])
                for e_result in e_results:
                    query = """DELETE FROM Employee_has_Specialization WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM Employee_has_project WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM Employee_has_attendence WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM vp WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM executive WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM admin WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM salary_history WHERE Employee_emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                    query = """DELETE FROM Employee WHERE emp_id = %s"""
                    db.delete(query=query, values=e_result[0])

                query = """DELETE FROM department WHERE d_id = %s"""
                db.delete(query=query, values=d_result[0])

        elif table == "bonus":
            query = """DELETE FROM payroll_has_bonus WHERE bonus_b_id = %s"""
            db.delete(query=query, values=result[0])

            query = """DELETE FROM project_has_bonus WHERE bonus_b_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "bank":
            query = """DELETE FROM bank_has_payroll WHERE bank_b_id = %s"""
            db.delete(query=query, values=result[0])

        elif table == "attendence":
            query = """DELETE FROM Employee_has_attendence WHERE attendence_a_id = %s"""
            db.delete(query=query, values=result[0])

        query = """DELETE FROM {} WHERE {} = %s""".format(table, attribute_str)
        if db.delete(query=query, values=value_str):
            print(f"Data successfully deleted from {table} \n")

    except Exception as err:
        traceback.print_exc()
        print("Error:", value_str, "failed to be deleted from", table, "\n")
