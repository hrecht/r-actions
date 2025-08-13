# Test out passing data from R to Github Env

# Final result should look like:
# 'echo "POST_BSKY=false" >> "$GITHUB_ENV"'
send_env <- function(var_name,
										 var_value,
										 convert_boolean = TRUE,
										 send_output = FALSE) {
	post_part <- paste0(var_name, "=", var_value, ' >> "$GITHUB_ENV"')
	
	# Convert R booleans to bash booleans
	if (convert_boolean == TRUE) {
		if (var_value == TRUE) {
			post_part <- paste0(var_name, '=true >> "$GITHUB_ENV"')
		}	else if (var_value == FALSE) {
			post_part <- paste0(var_name, '=false >> "$GITHUB_ENV"')
		}
	}
	
	print(post_part)
	system(paste('echo', post_part))
	
	# Save to Github output for use in future jobs
	# Should look like
	#system(echo "STRING_TEST=${{env.STRING_TEST}}" >> $GITHUB_OUTPUT)
	if (send_output == TRUE) {
		output_part <- paste0('"', var_name, "=${{env.", var_name, '}}" >> "$GITHUB_OUTPUT"')
		print(output_part)
		system(paste('echo', output_part))
	}
}

send_env("STRING_TEST", "Hello world", send_output = TRUE)
send_env("BOOLEAN_TEST", TRUE)
send_env("NUMERIC_TEST", 2)
send_env("DATE_TEST", Sys.time())
