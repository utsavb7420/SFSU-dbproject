-- Script name: tests.sql
-- Author: ---
-- Purpose: insert sample data to test the integrity of this database system
-- the database used to test the integrity of database system

-- the database used to insert the data into.
SET SQL_SAFE_UPDATES = 0;

USE payrollDB;


# department table testing
DELETE FROM `department` WHERE `d_id`='4' and`company_c_id`='1' and`payroll_department_p_id`='1';
UPDATE `department` SET `name`='HR-1' WHERE `d_id`='5' and`company_c_id`='1' and`payroll_department_p_id`='1';

# project table testing
UPDATE `payrollDB`.`project` SET `name`='Marketing Project-1' WHERE `p_id`='2' and`name`='HR-1';
DELETE FROM `payrollDB`.`project` WHERE `p_id`='1' and`name`='HR-1';

# company table testing
UPDATE company SET `address`='USA' WHERE `c_id`='1';
UPDATE company SET `c_id`='4' WHERE `c_id`='3';
DELETE FROM company WHERE `c_id`='3';


# bank_has_payroll table testing
UPDATE `payrollDB`.`bank_has_payroll` SET `payroll_p_id`='2' WHERE `bank_b_id`='1' and`payroll_p_id`='1';
DELETE FROM `payrollDB`.`bank_has_payroll` WHERE `bank_b_id`='3' and`payroll_p_id`='1';

# specialization table testing
-- UPDATE `payrollDB`.`Specialization` SET `description`='for writing' WHERE `s_id`='1';
-- DELETE FROM `payrollDB`.`Specialization` WHERE `s_id`='1';

# bank table testing
UPDATE `payrollDB`.`bank` SET `address`='CA' WHERE `b_id`='1';
DELETE FROM `payrollDB`.`bank` WHERE `b_id`='3';

# insurance table testing
UPDATE `payrollDB`.`insurance` SET `details`='permanent' WHERE `i_id`='3';
DELETE FROM `payrollDB`.`insurance` WHERE `i_id`='6';

-- # bonus table testing
-- UPDATE `payrollDB`.`bonus` SET `note`='233434' WHERE `b_id`='1';
-- DELETE FROM `payrollDB`.`bonus` WHERE `b_id`='5';

# employee history testing
DELETE FROM `payrollDB`.`Employee_history` WHERE `h_id`='5';
UPDATE `payrollDB`.`Employee_history` SET `experience`='15' WHERE `h_id`='4';

# employee testing
UPDATE `payrollDB`.`Employee` SET `mobile_number`='1232344' WHERE `emp_id`='2' and`insurance_i_id`='5' and`department_d_id`='2';
DELETE FROM `payrollDB`.`Employee` WHERE `emp_id`='3' and`insurance_i_id`='2' and`department_d_id`='4';

# attendence table testing
DELETE FROM `payrollDB`.`attendence` WHERE `a_id`='4' and`admin_a_id`='1' and`admin_Employee_emp_id`='1';
UPDATE `payrollDB`.`attendence` SET `check_in`='2020-02-02 00:00:00' WHERE `a_id`='3' and`admin_a_id`='1' and`admin_Employee_emp_id`='1';

# bank table testing
UPDATE `payrollDB`.`bank` SET `address`='CA' WHERE `b_id`='1';
DELETE FROM `payrollDB`.`bank` WHERE `b_id`='3';

# department_has_event table testing
UPDATE `payrollDB`.`department_has_Event` SET `department_d_id`='2', `Event_e_id`='1' WHERE `department_d_id`='1' and`department_company_c_id`='1' and`Event_e_id`='2';
DELETE FROM `payrollDB`.`department_has_Event` WHERE `department_d_id`='1' and`department_company_c_id`='1' and`Event_e_id`='3';

# event table testing
UPDATE `payrollDB`.`Event` SET `event_type_e_id`='1' WHERE `e_id`='2';
DELETE FROM `payrollDB`.`Event` WHERE `e_id`='3';

# project_type table testing
UPDATE `payrollDB`.`project_type` SET `description`='immunization based research' WHERE `type_id`='1';
DELETE FROM `payrollDB`.`project_type` WHERE `type_id`='4';

# event_type table testing
UPDATE `payrollDB`.`event_type` SET `description`='testing purposes' WHERE `e_id`='1';
DELETE FROM `payrollDB`.`event_type` WHERE `e_id`='3';

# employee_has_attendece table testing
DELETE FROM `payrollDB`.`Employee_has_attendence` WHERE `Employee_emp_id`='3' and`attendence_a_id`='3';
UPDATE `payrollDB`.`Employee_has_attendence` SET `attendence_a_id`='1' WHERE `Employee_emp_id`='2' and`attendence_a_id`='2';

# desingation table testing
DELETE FROM Designation where name="Sales-Manager";
UPDATE Designation SET d_id = 4 WHERE name = 'Sales-Manager';

# payroll_department table testing
DELETE FROM `payroll_department` WHERE `p_id`='6';
UPDATE `payroll_department` SET `type`='2' WHERE `p_id`='5';

# payroll_department table testing
DELETE FROM `payroll_department` WHERE `p_id`='5';
UPDATE `payroll_department` SET `type`='2' WHERE `p_id`='3';new_table