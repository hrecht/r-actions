# Test out passing data from R to Github Env

# Final result should look like:
# 'echo "POST_BSKY=false" >> "$GITHUB_ENV"'
send_env <- function(var_name,
										 var_value,
										 convert_boolean = TRUE,
										 send_output = FALSE) {
	# Convert R booleans to bash booleans
	if (convert_boolean == TRUE & var_value == TRUE ) {
		env_part <- paste0('"', var_name, '=true"', ' >> "$GITHUB_ENV"')
	}	else if (convert_boolean == TRUE & var_value == FALSE) {
		env_part <- paste0('"', var_name, '=false"', ' >> "$GITHUB_ENV"')
	} else {
		env_part <- paste0('"', var_name, "=", var_value, '"', ' >> "$GITHUB_ENV"')
	}
	
	print(env_part)
	system(paste('echo', env_part))
	
	# Save to Github output for use in future jobs
	# Should look like
	#system(echo "STRING_TEST=${{env.STRING_TEST}}" >> $GITHUB_OUTPUT)
	if (send_output == TRUE) {
		if (convert_boolean == TRUE & var_value == TRUE ) {
			ouput_part <- paste0('"', var_name, '=true"', ' >> "$GITHUB_OUTPUT"')
		}	else if (convert_boolean == TRUE & var_value == FALSE) {
			output_part <- paste0('"', var_name, '=false"', ' >> "$GITHUB_OUTPUT"')
		} else {
			output_part <- paste0('"', var_name, "=", var_value, '"', ' >> "$GITHUB_OUTPUT"')
		}
		
		print(output_part)
		system(paste('echo', output_part))
	}
}

send_env("STRING_TEST", "Hello world", send_output = TRUE)
send_env("BOOLEAN_TEST", FALSE, send_output = TRUE)
send_env("NUMERIC_TEST", 5, send_output = TRUE)
send_env("DATE_TEST", Sys.time())

# Try getting from the env
repo <- Sys.getenv("github_repository")
print(repo)
