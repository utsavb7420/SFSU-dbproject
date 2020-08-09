from payroll.utils import *

if __name__ == "__main__":
    is_logged_in = False
    user = None
    try:
        db = setup_database()
        show_menu()
        option = int(input("Select one option from the menu: "))
        while option != 7:
            if option == 1:
                register_account()

            elif option == 2:
                user = login_account()
                if user:
                    is_logged_in = True

            elif option == 3:
                search(is_logged_in, user)

            elif option == 4:
                insert(is_logged_in, user)

            elif option == 5:
                update(is_logged_in, user)

            elif option == 6:
                delete(is_logged_in, user)

            show_menu()
            option = int(input("Select one option from the menu: "))

    except Exception as ex:
        print("The program has terminated due to internal ERROR")
        exit(1)
