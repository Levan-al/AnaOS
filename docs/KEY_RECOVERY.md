# Key recovery (TASK_024 / Shamir)

## Scheme

- Split master recovery secret with Shamir’s Secret Sharing  
- Recommended: **3-of-5** shares  
- Shares held by distinct people / locations; never store threshold shares together  

## Recovery drill

1. Gather threshold shares  
2. Reconstruct on air-gapped machine  
3. Unlock encrypted key store  
4. Re-seal with new passphrase; redistribute new shares  
5. Log drill date (no private material in the log)  

## Lost share

- If fewer than threshold remain → treat as potential compromise; rotate keys  
- If threshold still available → regenerate and redistribute shares  

## Rented / cloud hosts

Never place Shamir shares or private keys on Hetzner or any online build host.  
Build hosts receive only **public** keys and, for CI, short-lived signing via offline ceremony outputs when required.  
