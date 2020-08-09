-- Script name: insert.sql
-- Author: ---
-- Purpose: insert sample data to test the integrity of this database system
-- the database used to test the integrity of database system

-- the database used to insert the data into.
USE payrollDB;

# designation table inserts
INSERT INTO `payrollDB`.`Designation` (`d_id`, `name`, `type`, `description`) VALUES ('1', 'Executive', 'senior', 'senior as executive');
INSERT INTO `payrollDB`.`Designation` (`d_id`, `name`, `type`) VALUES ('2', 'Manager', 'senior');
INSERT INTO `payrollDB`.`Designation` (`d_id`, `name`, `type`) VALUES ('3', 'Sales manager', 'junior');

# Company table inserts
INSERT INTO `payrollDB`.`company` (`c_id`, `name`, `address`) VALUES ('1', 'Facebook', 'SA');
INSERT INTO `payrollDB`.`company` (`c_id`, `name`, `address`) VALUES ('2', 'IBM', 'San Jose');
INSERT INTO `payrollDB`.`company` (`c_id`, `name`, `address`) VALUES ('3', 'Google', 'CA');

# table inserts
INSERT INTO `payrollDB`.`payroll_department` (`p_id`, `name`, `type`, `description`) VALUES ('1', 'payroll1', '1', 'for payroll tracking purposes');
INSERT INTO `payrollDB`.`payroll_department` (`p_id`, `name`, `type`) VALUES ('2', 'payroll2', '1');
INSERT INTO `payrollDB`.`payroll_department` (`p_id`, `name`, `type`, `description`) VALUES ('3', 'payroll3', '1', 'for tracking');

# department table inserts
INSERT INTO `payrollDB`.`department` (`d_id`, `name`, `company_c_id`, `payroll_department_p_id`) VALUES ('1', 'HR', '1', '1');
INSERT INTO `payrollDB`.`department` (`d_id`, `name`, `company_c_id`, `payroll_department_p_id`) VALUES ('2', 'Marketing', '1', '2');
INSERT INTO `payrollDB`.`department` (`d_id`, `name`, `company_c_id`, `payroll_department_p_id`) VALUES ('3', 'Software', '1', '3');

# bank table inserts
INSERT INTO `payrollDB`.`bank` (`b_id`, `name`, `address`) VALUES ('1', 'Microfinance', 'SA');
INSERT INTO `payrollDB`.`bank` (`b_id`, `name`, `address`) VALUES ('2', 'SC', 'SA');
INSERT INTO `payrollDB`.`bank` (`b_id`, `name`, `address`) VALUES ('3', 'Maxx', 'SA');

# payroll table inserts
INSERT INTO `payrollDB`.`payroll` (`p_id`, `base_year`, `payrollcol`, `company_c_id`) VALUES ('1', '2018-01-01', '40k', '1');
INSERT INTO `payrollDB`.`payroll` (`p_id`, `base_year`, `payrollcol`, `company_c_id`) VALUES ('2', '2000-01-01', '22k', '1');
INSERT INTO `payrollDB`.`payroll` (`p_id`, `base_year`, `payrollcol`, `company_c_id`) VALUES ('3', '2020-01-01', '50k', '1');

# project_table inserts
INSERT INTO `payrollDB`.`project_type` (`type_id`, `name`, `field`, `description`) VALUES ('1', 'Research Propoasal', 'Immunization', '...');
INSERT INTO `payrollDB`.`project_type` (`type_id`, `name`, `field`, `description`) VALUES ('2', 'Printing', 'Science', '...');
INSERT INTO `payrollDB`.`project_type` (`type_id`, `name`, `field`) VALUES ('3', 'Marketing catalog', 'Scoence');

# project table inserts
INSERT INTO `payrollDB`.`project` (`p_id`, `name`, `project_type_type_id`) VALUES ('1', 'HR', '1');
INSERT INTO `payrollDB`.`project` (`p_id`, `name`, `project_type_type_id`) VALUES ('2', 'Marketing Project', '2');
INSERT INTO `payrollDB`.`project` (`p_id`, `name`, `project_type_type_id`) VALUES ('3', 'Photoshoot', '3');

# bank_has_payroll table inserts
INSERT INTO `payrollDB`.`bank_has_payroll` (`bank_b_id`, `payroll_p_id`) VALUES ('1', '1');
INSERT INTO `payrollDB`.`bank_has_payroll` (`bank_b_id`, `payroll_p_id`) VALUES ('2', '1');
INSERT INTO `payrollDB`.`bank_has_payroll` (`bank_b_id`, `payroll_p_id`) VALUES ('3', '1');

# bonus table inserts
INSERT INTO `payrollDB`.`bonus` (`b_id`, `amount`) VALUES ('1', '10');
INSERT INTO `payrollDB`.`bonus` (`b_id`, `amount`) VALUES ('2', '20');
INSERT INTO `payrollDB`.`bonus` (`b_id`, `amount`) VALUES ('3', '50');

# specializationtable inserts
INSERT INTO `payrollDB`.`Specialization` (`s_id`, `name`, `type`) VALUES ('1', 'Writing', '1');
INSERT INTO `payrollDB`.`Specialization` (`s_id`, `name`, `type`) VALUES ('2', 'Business', '1');
INSERT INTO `payrollDB`.`Specialization` (`s_id`, `name`, `type`) VALUES ('3', 'Photography', '1');

# insurance table inserts
INSERT INTO `payrollDB`.`insurance` (`i_id`, `details`, `period`, `registered_on`) VALUES ('1', 'temp', now(), now());
INSERT INTO `payrollDB`.`insurance` (`i_id`, `details`, `period`, `registered_on`) VALUES ('2', 'temp', now(), now());
INSERT INTO `payrollDB`.`insurance` (`i_id`, `details`, `period`, `registered_on`) VALUES ('3', 'temp', now(), now());


# employee_history table inserts
INSERT INTO `payrollDB`.`Employee_history` (`h_id`, `start_date`, `experience`) VALUES ('1', '1999-02-02', '5');
INSERT INTO `payrollDB`.`Employee_history` (`h_id`, `start_date`, `experience`) VALUES ('2', '1999-02-02', '10');
INSERT INTO `payrollDB`.`Employee_history` (`h_id`, `start_date`, `experience`) VALUES ('3', '1999-02-02', '15');

# employee table inserts
INSERT INTO `payrollDB`.`Employee` (`emp_id`, `name`, `dob`, `state`, `city`, `email`, `mobile_number`, `Designation_d_id`, `Employee_history_h_id`, `insurance_i_id`, `department_d_id`) VALUES ('1', 'hina', '2000-02-02', 'FL', 'miami', 'hina@yahoo.com', '1334', '1', '1', '1', '1');
INSERT INTO `payrollDB`.`Employee` (`emp_id`, `name`, `dob`, `state`, `city`, `email`, `mobile_number`, `Designation_d_id`, `Employee_history_h_id`, `insurance_i_id`, `department_d_id`) VALUES ('2', 'allen', '2000-05-05', 'FL', 'miami', 'allen@123.com', '12323', '2', '2', '2', '2');
INSERT INTO `payrollDB`.`Employee` (`emp_id`, `name`, `dob`, `state`, `city`, `email`, `mobile_number`, `Designation_d_id`, `Employee_history_h_id`, `insurance_i_id`, `department_d_id`) VALUES ('3', 'Tom', '1994-05-02', 'SA', 'san jose', 'tom@fb.com', '12313', '3', '3', '2', '2');

# admin table inserts
INSERT INTO `payrollDB`.`admin` (`a_id`, `notes`, `permission`, `Employee_emp_id`) VALUES ('1', 'there can be only one admin', 'ALL', '1');

# attendence table inserts
INSERT INTO `payrollDB`.`attendence` (`a_id`, `type`, `status`, `check_in`, `check_out`, `admin_a_id`, `admin_Employee_emp_id`) VALUES ('1', '1', '1', '2020-02-05', '2020-02-10', '1', '1');
INSERT INTO `payrollDB`.`attendence` (`a_id`, `type`, `status`, `check_in`, `check_out`, `admin_a_id`, `admin_Employee_emp_id`) VALUES ('2', '1', '1', '2020-02-05', '2020-02-10', '1', '1');
INSERT INTO `payrollDB`.`attendence` (`a_id`, `type`, `status`, `check_in`, `check_out`, `admin_a_id`, `admin_Employee_emp_id`) VALUES ('3', '1', '1', '2020-02-05', '2020-02-10', '1', '1');
INSERT INTO `payrollDB`.`attendence` (`a_id`, `type`, `status`, `check_in`, `check_out`, `admin_a_id`, `admin_Employee_emp_id`) VALUES ('4', '1', '1', '2020-02-05', '2020-02-10', '1', '1');

# event_type table inserts
INSERT INTO `payrollDB`.`event_type` (`e_id`, `location`) VALUES ('1', 'conference hall');
INSERT INTO `payrollDB`.`event_type` (`e_id`, `location`) VALUES ('2', 'meeting room');
INSERT INTO `payrollDB`.`event_type` (`e_id`, `location`) VALUES ('3', 'hall');

# event table inserts
INSERT INTO `payrollDB`.`Event` (`e_id`, `name`, `date`, `address`, `event_type_e_id`) VALUES ('1', 'orientation', '2020-02-08', '1C, 15road', '1');
INSERT INTO `payrollDB`.`Event` (`e_id`, `name`, `date`, `address`, `event_type_e_id`) VALUES ('2', 'inaugration', '2020-02-08', '2C', '2');
INSERT INTO `payrollDB`.`Event` (`e_id`, `name`, `date`, `address`, `event_type_e_id`) VALUES ('3', 'meeting', '2020-02-08', '3C', '3');

# department_has_event table inserts
INSERT INTO `payrollDB`.`department_has_Event` (`department_d_id`, `department_company_c_id`, `Event_e_id`) VALUES ('1', '1', '2');
INSERT INTO `payrollDB`.`department_has_Event` (`department_d_id`, `department_company_c_id`, `Event_e_id`) VALUES ('1', '1', '3');
INSERT INTO `payrollDB`.`department_has_Event` (`department_d_id`, `department_company_c_id`, `Event_e_id`) VALUES ('1', '1', '1');

# employee_has_attendence table inserts
INSERT INTO `payrollDB`.`Employee_has_attendence` (`Employee_emp_id`, `attendence_a_id`) VALUES ('1', '1');
INSERT INTO `payrollDB`.`Employee_has_attendence` (`Employee_emp_id`, `attendence_a_id`) VALUES ('2', '2');
INSERT INTO `payrollDB`.`Employee_has_attendence` (`Employee_emp_id`, `attendence_a_id`) VALUES ('3', '3');
INSERT INTO `payrollDB`.`Employee_has_attendence` (`Employee_emp_id`, `attendence_a_id`) VALUES ('1', '2');

# employee_has_project table inserts
INSERT INTO `payrollDB`.`Employee_has_project` (`Employee_emp_id`, `project_p_id`) VALUES ('1', '1');
INSERT INTO `payrollDB`.`Employee_has_project` (`Employee_emp_id`, `project_p_id`) VALUES ('2', '1');
INSERT INTO `payrollDB`.`Employee_has_project` (`Employee_emp_id`, `project_p_id`) VALUES ('3', '1');

# employee_has_specialization table inserts
INSERT INTO `payrollDB`.`Employee_has_Specialization` (`Employee_emp_id`, `Specialization_s_id`) VALUES ('1', '1');
INSERT INTO `payrollDB`.`Employee_has_Specialization` (`Employee_emp_id`, `Specialization_s_id`) VALUES ('2', '2');
INSERT INTO `payrollDB`.`Employee_has_Specialization` (`Employee_emp_id`, `Specialization_s_id`) VALUES ('3', '3');

# executive table inserts
INSERT INTO `payrollDB`.`executive` (`e_id`, `title`, `Employee_emp_id`) VALUES ('1', 'EX', '3');
INSERT INTO `payrollDB`.`executive` (`e_id`, `title`, `Employee_emp_id`) VALUES ('2', 'EX', '2');

# paygrade table inserts
INSERT INTO `payrollDB`.`paygrade` (`p_id`, `bonus`, `name`, `basic`) VALUES ('1', '10', 'test', '1');
INSERT INTO `payrollDB`.`paygrade` (`p_id`, `bonus`, `name`, `basic`) VALUES ('2', '11', 'basic', '1');
INSERT INTO `payrollDB`.`paygrade` (`p_id`, `bonus`, `name`, `basic`) VALUES ('3', '20', 'premium', '1');

# department_has_paygrade table inserts
INSERT INTO `payrollDB`.`department_has_paygrade` (`department_d_id`, `paygrade_p_id`) VALUES ('1', '3');
INSERT INTO `payrollDB`.`department_has_paygrade` (`department_d_id`, `paygrade_p_id`) VALUES ('2', '2');
INSERT INTO `payrollDB`.`department_has_paygrade` (`department_d_id`, `paygrade_p_id`) VALUES ('3', '1');

# payroll_has_bonus table inserts
INSERT INTO `payrollDB`.`payroll_has_bonus` (`payroll_p_id`, `bonus_b_id`) VALUES ('1', '1');
INSERT INTO `payrollDB`.`payroll_has_bonus` (`payroll_p_id`, `bonus_b_id`) VALUES ('2', '2');
INSERT INTO `payrollDB`.`payroll_has_bonus` (`payroll_p_id`, `bonus_b_id`) VALUES ('3', '3');

# vp table inserts
INSERT INTO `payrollDB`.`vp` (`v_id`, `title`, `Employee_emp_id`) VALUES ('1', 'VP', '2');

# project_has_bonus inserts
INSERT INTO `payrollDB`.`project_has_bonus` (`project_p_id`, `project_project_type_type_id`, `bonus_b_id`) VALUES ('1', '1', '1');
INSERT INTO `payrollDB`.`project_has_bonus` (`project_p_id`, `project_project_type_type_id`, `bonus_b_id`) VALUES ('2', '2', '2');
INSERT INTO `payrollDB`.`project_has_bonus` (`project_p_id`, `project_project_type_type_id`, `bonus_b_id`) VALUES ('3', '3', '3');

# salary_history table inserts
INSERT INTO `payrollDB`.`salary_history` (`s_id`, `date`, `salary`, `Employee_emp_id`, `Employee_insurance_i_id`) VALUES ('1', '2020-08-02', '110', '1', '1');
INSERT INTO `payrollDB`.`salary_history` (`s_id`, `date`, `salary`, `Employee_emp_id`, `Employee_insurance_i_id`) VALUES ('3', '2020-08-02', '159', '1', '1');
INSERT INTO `payrollDB`.`salary_history` (`s_id`, `date`, `salary`, `Employee_emp_id`, `Employee_insurance_i_id`) VALUES ('4', '2020-08-02', '110', '1', '1');
