# Test out passing data from R to Github Env

# Final result should look like:
# 'echo "POST_BSKY=false" >> "$GITHUB_ENV"'

send_var <- function(var_name,
										 var_value,
										 destination) {
	send_part <- paste0('"', var_name, "=", var_value, '"', ' >> "$', destination, '"')
	print(send_part)
	system(paste('echo', send_part))
}
send_env <- function(var_name,
										 var_value,
										 send_output = FALSE) {
	
	send_var(var_name, var_value, "GITHUB_ENV")
	
	# Save to Github output for use in future jobs
	if (send_output == TRUE) {
		send_var(var_name, var_value, "GITHUB_OUTPUT")
	}
}

send_env("STRING_TEST", "Hello world", send_output = TRUE)
send_env("BOOLEAN_TEST", F, send_output = TRUE)
send_env("NUMERIC_TEST", 5, send_output = TRUE)
send_env("DATE_TEST", Sys.time())
send_env("ARB_TEST", nrow(mtcars))
send_env("LIST_TEST", '["foo", "bar"]')

# Try getting from the env
repo <- Sys.getenv("github.repository")
print(repo)

system(
'echo
MULTI_TEST=$(cat << EOF
						 Line 1
						 Line 2
						 Line 3
						 EOF
)')
system('echo "MULTI_TEST<<EOF" >> "$GITHUB_ENV"')
system('echo "$MULTI_TEST" >> "$GITHUB_ENV"')
system('echo "EOF" >> "$GITHUB_ENV"')

