# BigQuery Auth Troubleshooting

You are helping diagnose and fix authentication issues with the BigQuery MCP server. Your goal is to identify the root cause and guide the user through the appropriate fix.

## Common BigQuery Auth Errors

### "reauth related error (invalid_rapt)"
- OAuth token has expired or needs reauthentication
- Usually occurs after token TTL expires or from permission changes
- Fix: Re-authenticate Google credentials

### "permission denied" or "access denied"
- User lacks permissions for the project/dataset
- Service account key doesn't have required roles
- Fix: Verify IAM roles and permissions

### "failed to fetch token"
- Credentials file is missing or corrupted
- Application-default credentials not set up
- Fix: Re-authenticate or set up service account

### "invalid_client" or "invalid credentials"
- Credentials file is malformed
- Wrong type of credentials for the setup
- Fix: Clear and re-authenticate

## Diagnostic Process

1. **Identify the error type** from the error message
2. **Determine credential method** - application-default, service account, or gcloud auth
3. **Check setup** - how was BigQuery MCP initially configured
4. **Apply appropriate fix** - based on credential type
5. **Verify** - test the connection with a simple query

## Common Fixes

### Fix 1: Re-authenticate Application Default Credentials
Use this if you're getting "invalid_rapt" or token expiration errors:

```bash
gcloud auth application-default login
```

Then restart the MCP server or the Nimbalyst editor.

### Fix 2: Clear and Re-authenticate
If Fix 1 doesn't work:

```bash
rm ~/.config/gcloud/application_default_credentials.json
gcloud auth application-default login
```

Then restart the editor/MCP server.

### Fix 3: Service Account Re-authentication
If using a service account key:

```bash
gcloud auth activate-service-account --key-file=/path/to/service-account-key.json
gcloud config set project max-sg
```

Then restart the MCP server.

### Fix 4: Check BigQuery Permissions
Verify the authenticated user/service account has these IAM roles:
- `roles/bigquery.user` - Basic BigQuery access
- `roles/bigquery.dataEditor` - Read/write data
- `roles/bigquery.admin` - Full admin access (if needed)

View current permissions:
```bash
gcloud projects get-iam-policy max-sg
```

## Diagnosis Flow

1. **What error message are you seeing?**
   - If "invalid_rapt" → Try Fix 1
   - If "access denied" → Check IAM roles (Fix 4)
   - If "credentials not found" → Try Fix 2 or Fix 3

2. **How was BigQuery MCP configured?**
   - Check `.claude/settings.json` or `.claude/settings.local.json`
   - Look for how the MCP server was initialized

3. **Is the MCP server running?**
   - May need to restart after authentication
   - Check if there's a daemon process that needs restarting

4. **Test the fix**
   - Run a simple query after re-authenticating
   - Verify the connection is working

## MCP Server Restart

If authentication is fixed but the server is still having issues:

```bash
# Find and kill the MCP process (example names)
pkill -f "mcp.*bigquery"
pkill -f "bigquery"

# Restart the editor or relevant service
# This depends on your setup - may be automatic or manual
```

## Verification Query

Once you think the issue is fixed, test with:

```sql
SELECT 'Connection successful' as message
```

If this runs without errors, the authentication is working.

## When to Escalate

If none of these fixes work:
1. Check the GCP project is still active and billing is enabled
2. Verify the user account still has access to the project
3. Check if multi-factor authentication is required (can cause token issues)
4. Review recent GCP security changes or policy updates
5. Contact your GCP admin to verify permissions are correct

## Your Approach

1. **First response**: Ask what error message they're seeing
2. **Identify the pattern**: Map to one of the common errors
3. **Ask about setup**: How was the MCP initially configured
4. **Suggest specific fix**: Based on error type + setup method
5. **Guide through execution**: Provide exact commands to run
6. **Verify success**: Have them test with a simple query
7. **Document learnings**: If it's an unusual case, note it for future reference

## Starting Now

The user will report an auth issue. Ask clarifying questions to identify the specific error and setup method, then guide them through the appropriate fix.
