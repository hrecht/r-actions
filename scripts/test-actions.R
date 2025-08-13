# Test out passing data from R to Github Env

# Final result should look like:
# 'echo "POST_BSKY=false" >> "$GITHUB_ENV"'
send_env <- function(var_name,
										 var_value,
										 send_output = FALSE) {
	env_part <- paste0('"', var_name, "=", var_value, '"', ' >> "$GITHUB_ENV"')
	print(env_part)
	system(paste('echo', env_part))
	
	# Save to Github output for use in future jobs
	# Should look like
	#system(echo "STRING_TEST=${{env.STRING_TEST}}" >> $GITHUB_OUTPUT)
	if (send_output == TRUE) {
		output_part <- paste0('"', var_name, "=", var_value, '"', ' >> "$GITHUB_OUTPUT"')
		print(output_part)
		system(paste('echo', output_part))
	}
}

send_env("STRING_TEST", "Hello world", send_output = TRUE)
send_env("BOOLEAN_TEST", FALSE, send_output = TRUE)
send_env("NUMERIC_TEST", 5, send_output = TRUE)
send_env("DATE_TEST", Sys.time())
send_env("ARB_TEST", nrow(mtcars))
send_env(c("LIST_TEST", "LIST_TEST2"), var_value = c("foo", "bar"))

# Try getting from the env
repo <- Sys.getenv("github.repository")
print(repo)
