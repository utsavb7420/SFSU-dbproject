CREATE SCHEMA IF NOT EXISTS `payrollDB` DEFAULT CHARACTER SET utf8 ;
USE `payrollDB` ;

-- -----------------------------------------------------
-- Table `payrollDB`.`user_login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`user_login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `payrollDB`.`Designation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Designation` (
  `d_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`d_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Employee_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Employee_history` (
  `h_id` INT NOT NULL,
  `start_date` DATETIME NULL,
  `experience` TEXT NULL,
  PRIMARY KEY (`h_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`insurance` (
  `i_id` INT NOT NULL,
  `details` TEXT NULL,
  `period` DATETIME NULL,
  `registered_on` DATETIME NULL,
  PRIMARY KEY (`i_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`company` (
  `c_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(500) NULL,
  PRIMARY KEY (`c_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`payroll_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`payroll_department` (
  `p_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`p_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`department` (
  `d_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `company_c_id` INT NOT NULL,
  `payroll_department_p_id` INT NOT NULL,
  PRIMARY KEY (`d_id`, `company_c_id`, `payroll_department_p_id`),
  INDEX `fk_department_company1_idx` (`company_c_id` ASC),
  INDEX `fk_department_payroll_department1_idx` (`payroll_department_p_id` ASC),
  CONSTRAINT `fk_department_company1`
    FOREIGN KEY (`company_c_id`)
    REFERENCES `payrollDB`.`company` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_payroll_department1`
    FOREIGN KEY (`payroll_department_p_id`)
    REFERENCES `payrollDB`.`payroll_department` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Employee` (
  `emp_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `dob` DATETIME NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `mobile_number` VARCHAR(45) NULL,
  `Designation_d_id` INT NOT NULL,
  `Employee_history_h_id` INT NULL,
  `insurance_i_id` INT NULL,
  `department_d_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `fk_Employee_Designation1_idx` (`Designation_d_id` ASC),
  CONSTRAINT `fk_Employee_Designation1`
    FOREIGN KEY (`Designation_d_id`)
    REFERENCES `payrollDB`.`Designation` (`d_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Employee_history1`
    FOREIGN KEY (`Employee_history_h_id`)
    REFERENCES `payrollDB`.`Employee_history` (`h_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `fk_Employee_department1`
    FOREIGN KEY (`department_d_id`)
    REFERENCES `payrollDB`.`department` (`d_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Specialization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Specialization` (
  `s_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`s_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Employee_has_Specialization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Employee_has_Specialization` (
  `Employee_emp_id` INT NOT NULL,
  `Specialization_s_id` INT NOT NULL,
  PRIMARY KEY (`Employee_emp_id`, `Specialization_s_id`),
  INDEX `fk_Employee_has_Specialization_Specialization1_idx` (`Specialization_s_id` ASC),
  INDEX `fk_Employee_has_Specialization_Employee_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_Employee_has_Specialization_Employee`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_Specialization_Specialization1`
    FOREIGN KEY (`Specialization_s_id`)
    REFERENCES `payrollDB`.`Specialization` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`salary_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`salary_history` (
  `s_id` INT NOT NULL,
  `date` DATETIME NULL,
  `salary` INT NULL,
  `Employee_emp_id` INT NOT NULL,
  `Employee_insurance_i_id` INT NULL,
  PRIMARY KEY (`s_id`, `Employee_emp_id`),
  INDEX `fk_salary_history_Employee1_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_salary_history_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`paygrade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`paygrade` (
  `p_id` INT NOT NULL,
  `bonus` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `basic` VARCHAR(45) NULL,
  PRIMARY KEY (`p_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`department_has_paygrade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`department_has_paygrade` (
  `department_d_id` INT NOT NULL,
  `paygrade_p_id` INT NOT NULL,
  PRIMARY KEY (`department_d_id`, `paygrade_p_id`),
  INDEX `fk_department_has_paygrade_paygrade1_idx` (`paygrade_p_id` ASC),
  INDEX `fk_department_has_paygrade_department1_idx` (`department_d_id` ASC),
  CONSTRAINT `fk_department_has_paygrade_department1`
    FOREIGN KEY (`department_d_id`)
    REFERENCES `payrollDB`.`department` (`d_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_has_paygrade_paygrade1`
    FOREIGN KEY (`paygrade_p_id`)
    REFERENCES `payrollDB`.`paygrade` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`event_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`event_type` (
  `e_id` INT NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`e_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Event` (
  `e_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `address` TEXT NULL,
  `event_type_e_id` INT NOT NULL,
  PRIMARY KEY (`e_id`),
  INDEX `fk_Event_event_type1_idx` (`event_type_e_id` ASC),
  CONSTRAINT `fk_Event_event_type1`
    FOREIGN KEY (`event_type_e_id`)
    REFERENCES `payrollDB`.`event_type` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`department_has_Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`department_has_Event` (
  `department_d_id` INT NOT NULL,
  `department_company_c_id` INT NOT NULL,
  `Event_e_id` INT NOT NULL,
  PRIMARY KEY (`department_d_id`, `department_company_c_id`, `Event_e_id`),
  INDEX `fk_department_has_Event_Event1_idx` (`Event_e_id` ASC),
  INDEX `fk_department_has_Event_department1_idx` (`department_d_id` ASC, `department_company_c_id` ASC),
  CONSTRAINT `fk_department_has_Event_department1`
    FOREIGN KEY (`department_d_id` , `department_company_c_id`)
    REFERENCES `payrollDB`.`department` (`d_id` , `company_c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_has_Event_Event1`
    FOREIGN KEY (`Event_e_id`)
    REFERENCES `payrollDB`.`Event` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`project_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`project_type` (
  `type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `field` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`project` (
  `p_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `project_type_type_id` INT NOT NULL,
  PRIMARY KEY (`p_id`, `project_type_type_id`),
  INDEX `fk_project_project_type1_idx` (`project_type_type_id` ASC),
  CONSTRAINT `fk_project_project_type1`
    FOREIGN KEY (`project_type_type_id`)
    REFERENCES `payrollDB`.`project_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Employee_has_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Employee_has_project` (
  `Employee_emp_id` INT NOT NULL,
  `project_p_id` INT NOT NULL,
  PRIMARY KEY (`Employee_emp_id`, `project_p_id`),
  INDEX `fk_Employee_has_project_project1_idx` (`project_p_id` ASC),
  INDEX `fk_Employee_has_project_Employee1_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_Employee_has_project_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_project_project1`
    FOREIGN KEY (`project_p_id`)
    REFERENCES `payrollDB`.`project` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`bonus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`bonus` (
  `b_id` INT NOT NULL,
  `amount` INT NOT NULL,
  `note` TEXT NULL,
  PRIMARY KEY (`b_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`project_has_bonus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`project_has_bonus` (
  `project_p_id` INT NOT NULL,
  `project_project_type_type_id` INT NOT NULL,
  `bonus_b_id` INT NOT NULL,
  PRIMARY KEY (`project_p_id`, `project_project_type_type_id`, `bonus_b_id`),
  INDEX `fk_project_has_bonus_bonus1_idx` (`bonus_b_id` ASC),
  INDEX `fk_project_has_bonus_project1_idx` (`project_p_id` ASC, `project_project_type_type_id` ASC),
  CONSTRAINT `fk_project_has_bonus_project1`
    FOREIGN KEY (`project_p_id` , `project_project_type_type_id`)
    REFERENCES `payrollDB`.`project` (`p_id` , `project_type_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_bonus_bonus1`
    FOREIGN KEY (`bonus_b_id`)
    REFERENCES `payrollDB`.`bonus` (`b_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`payroll` (
  `p_id` INT NOT NULL,
  `base_year` DATE NOT NULL,
  `payrollcol` TEXT NULL,
  `company_c_id` INT NULL,
  PRIMARY KEY (`p_id`),
  INDEX `fk_payroll_company1_idx` (`company_c_id` ASC),
  CONSTRAINT `fk_payroll_company1`
    FOREIGN KEY (`company_c_id`)
    REFERENCES `payrollDB`.`company` (`c_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`payroll_has_bonus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`payroll_has_bonus` (
  `payroll_p_id` INT NOT NULL,
  `bonus_b_id` INT NOT NULL,
  PRIMARY KEY (`payroll_p_id`, `bonus_b_id`),
  INDEX `fk_payroll_has_bonus_bonus1_idx` (`bonus_b_id` ASC),
  INDEX `fk_payroll_has_bonus_payroll1_idx` (`payroll_p_id` ASC),
  CONSTRAINT `fk_payroll_has_bonus_payroll1`
    FOREIGN KEY (`payroll_p_id`)
    REFERENCES `payrollDB`.`payroll` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payroll_has_bonus_bonus1`
    FOREIGN KEY (`bonus_b_id`)
    REFERENCES `payrollDB`.`bonus` (`b_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`admin` (
  `a_id` INT NOT NULL,
  `notes` TEXT NULL,
  `permission` VARCHAR(45) NOT NULL,
  `Employee_emp_id` INT NOT NULL,
  PRIMARY KEY (`a_id`, `Employee_emp_id`),
  INDEX `fk_admin_Employee1_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_admin_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`bank` (
  `b_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`b_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`salary` (
  `s_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `hours_worked` INT NULL,
  `Employee_emp_id` INT NOT NULL,
  `admin_a_id` INT NOT NULL,
  `bank_b_id` INT NOT NULL,
  PRIMARY KEY (`s_id`, `Employee_emp_id`, `admin_a_id`, `bank_b_id`),
  INDEX `fk_salary_Employee1_idx` (`Employee_emp_id` ASC),
  INDEX `fk_salary_admin1_idx` (`admin_a_id` ASC),
  INDEX `fk_salary_bank1_idx` (`bank_b_id` ASC),
  CONSTRAINT `fk_salary_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salary_admin1`
    FOREIGN KEY (`admin_a_id`)
    REFERENCES `payrollDB`.`admin` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salary_bank1`
    FOREIGN KEY (`bank_b_id`)
    REFERENCES `payrollDB`.`bank` (`b_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`executive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`executive` (
  `e_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `notes` TEXT NULL,
  `Employee_emp_id` INT NOT NULL,
  PRIMARY KEY (`e_id`, `Employee_emp_id`),
  INDEX `fk_executive_Employee1_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_executive_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`vp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`vp` (
  `v_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `notes` TEXT NULL,
  `Employee_emp_id` INT NOT NULL,
  PRIMARY KEY (`v_id`, `Employee_emp_id`),
  INDEX `fk_vp_Employee1_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_vp_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`bank_has_payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`bank_has_payroll` (
  `bank_b_id` INT NOT NULL,
  `payroll_p_id` INT NOT NULL,
  PRIMARY KEY (`bank_b_id`, `payroll_p_id`),
  INDEX `fk_bank_has_payroll_payroll1_idx` (`payroll_p_id` ASC),
  INDEX `fk_bank_has_payroll_bank1_idx` (`bank_b_id` ASC),
  CONSTRAINT `fk_bank_has_payroll_bank1`
    FOREIGN KEY (`bank_b_id`)
    REFERENCES `payrollDB`.`bank` (`b_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bank_has_payroll_payroll1`
    FOREIGN KEY (`payroll_p_id`)
    REFERENCES `payrollDB`.`payroll` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`attendence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`attendence` (
  `a_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `status` TINYINT(1) NULL,
  `check_in` DATETIME NULL,
  `check_out` DATETIME NULL,
  `admin_a_id` INT NULL,
  `admin_Employee_emp_id` INT NOT NULL,
  PRIMARY KEY (`a_id`),
  INDEX `fk_attendence_admin1_idx` (`admin_a_id` ASC, `admin_Employee_emp_id` ASC),
  CONSTRAINT `fk_attendence_admin1`
    FOREIGN KEY (`admin_a_id`)
    REFERENCES `payrollDB`.`admin` (`a_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollDB`.`Employee_has_attendence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollDB`.`Employee_has_attendence` (
  `Employee_emp_id` INT NOT NULL,
  `attendence_a_id` INT NOT NULL,
  PRIMARY KEY (`Employee_emp_id`, `attendence_a_id`),
  INDEX `fk_Employee_has_attendence_attendence1_idx` (`attendence_a_id` ASC),
  INDEX `fk_Employee_has_attendence_Employee1_idx` (`Employee_emp_id` ASC),
  CONSTRAINT `fk_Employee_has_attendence_Employee1`
    FOREIGN KEY (`Employee_emp_id`)
    REFERENCES `payrollDB`.`Employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_attendence_attendence1`
    FOREIGN KEY (`attendence_a_id`)
    REFERENCES `payrollDB`.`attendence` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;