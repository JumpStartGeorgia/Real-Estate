 DELIMITER //
 drop procedure if exists crosstab_count;
 
 CREATE PROCEDURE crosstab_count(field_rows varchar(255), field_cols varchar(255), locale varchar(5))
   BEGIN

      set SESSION group_concat_max_len = 1024*2;

      SET @sql := CONCAT("SELECT 
					    CONCAT('SELECT ",
				    SQL_ESC(field_rows),
				    ",	', GROUP_CONCAT(DISTINCT CONCAT('sum(IF(",
                       SQL_ESC(field_cols),
				    "=', QUOTE(",
				    SQL_ESC(field_cols),
				    "),', 1,0)) AS ',SQL_ESC(",
				    SQL_ESC(field_cols),
				    ") )), ' FROM  postings where locale = \"', locale, '\" and ", SQL_ESC(field_rows), " != \"\" GROUP BY ",
				    SQL_ESC(field_rows),
				    "')
         INTO   @sql
         FROM   postings
	      where locale = '", locale, "' and ", SQL_ESC(field_cols), " != '' " 
      );

    PREPARE stmt FROM @sql; 
    EXECUTE stmt; 
    DEALLOCATE PREPARE stmt;

    PREPARE stmt FROM @sql; 
    EXECUTE stmt; 
    DEALLOCATE PREPARE stmt;
        
   END //
 DELIMITER ;
