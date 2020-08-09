import os


def write_to_sql_file(file_name, content):
    try:
        with open(file_name, 'a+') as file:
            if os.stat(file_name).st_size == 0:
                file.write("use payrollDB;\n")

            file.write(content)
            file.write(";\n")
        file.close()
    except Exception as ex:
        print(ex)
