set SESSION group_concat_max_len = 1024*2;
set @field_rows = 'type';
set @field_cols = 'property_type';
set @locale = 'en';

SET @sql := CONCAT("SELECT 
					CONCAT('SELECT ",
				SQL_ESC(@field_rows),
				",	', GROUP_CONCAT(DISTINCT CONCAT('sum(IF(",
                   SQL_ESC(@field_cols),
				"=', QUOTE(",
				SQL_ESC(@field_cols),
				"),', 1,0)) AS ',SQL_ESC(",
				SQL_ESC(@field_cols),
				") )), ' FROM  postings where locale = \"', @locale, '\" and ', SQL_ESC(@field_rows), ' != \"\" GROUP BY ",
				SQL_ESC(@field_rows),
				"')
     INTO   @sql
     FROM   postings
	  where locale = '", @locale, "' and ", SQL_ESC(@field_cols), " != '' " 
  );

PREPARE stmt FROM @sql; 
EXECUTE stmt; 
DEALLOCATE PREPARE stmt;

PREPARE stmt FROM @sql; 
EXECUTE stmt; 
DEALLOCATE PREPARE stmt;
    
