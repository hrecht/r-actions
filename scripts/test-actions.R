# Test out passing data from R to Github Env

# Final result should look like:
# 'echo "POST_BSKY=false" >> "$GITHUB_ENV"'
send_env <- function(var_name, var_value, convert_boolean = TRUE) {
	post_part <- paste0(var_name, "=", var_value, ' >> "$GITHUB_ENV"')
	
	if (convert_boolean == TRUE) {
		if (var_value == TRUE) {
			post_part <- paste0(var_name, '=true >> "$GITHUB_ENV"')
		}	else if (var_value == FALSE) {
			post_part <- paste0(var_name, '=false >> "$GITHUB_ENV"')
		}
	}
	
	print(post_part)
	system(paste('echo ', post_part))
}

send_env("TEXT_TEST", "Hello world")
send_env("BOOLEAN_TEST", TRUE)
send_env("NUMERIC_TEST", 2)
send_env("DATE_TEST", Sys.time())
