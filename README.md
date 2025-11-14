# Azure IaC with Spacelift (OIDC) — OIDC (Web/SPA/Native) & SAML Apps + Group Assignments

This repo provisions Microsoft Entra ID (Azure AD) **applications** for **OIDC Web, SPA, Native** _and_ a **SAML 2.0 Enterprise App**, creates **groups**, and assigns those groups to **app roles** — all driven by **Terraform** and executed in **Spacelift** using **OIDC (short‑lived credentials)**.

## What you get
- ✅ OIDC app registration with Web, SPA, and Native platforms
- ✅ App roles (`Admin`, `User`) on the OIDC app
- ✅ SAML 2.0 Enterprise App SP with a token-signing certificate
- ✅ Two Entra ID security groups and role assignments to the apps
- ✅ Single environment layout, ready for a Spacelift Stack

## Prereqs
- A Microsoft Entra tenant and Azure subscription
- Permissions to create App Registrations, Service Principals, Groups, and role assignments
- A Spacelift account with Azure OIDC enabled

## Setup (Spacelift)
1. Create a **Stack** pointing to `terraform/env` (this is set in `.spacelift/config.yml`).
2. In the Stack **Environment**:
   - Set `ARM_USE_OIDC=true`
   - Set `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`, and (if needed) `ARM_CLIENT_ID` for federation.
3. Ensure the Stack’s OIDC token is mounted at `/mnt/workspace/spacelift.oidc` (default) or adjust `providers.tf`.

## Configure variables
Copy and edit the example tfvars:

```bash
cp terraform/env/terraform.tfvars.example terraform/env/terraform.tfvars
# edit tenant_id, subscription_id, prefix, location
```

## Apply
Push to the repo. In Spacelift, run **Plan** then **Apply**.

## Outputs
- `oidc_app_client_id`
- `oidc_app_service_principal_id`
- `saml_sp_id`

## Customize
- Change redirect URIs in `terraform/env/main.tf`.
- Add/remove app roles in `modules/app-registration` `app_roles` input.
- Extend SAML configuration (claims, attributes) via Microsoft Graph or Azure CLI if needed.

## Notes
- Fine-grained SAML claims mapping isn’t fully exposed in the Terraform provider yet. For advanced mappings, script post-provision steps with Graph API/CLI.
- This repo assumes Spacelift OIDC. If running locally, remove `use_oidc`/`oidc_token_file_path` and configure provider auth accordingly.
