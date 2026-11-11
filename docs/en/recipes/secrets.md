# Store and use secrets

Keep encrypted values in app vars as `ENC[...]`. Encrypt a value with the host's age key:

```sh
printf '%s' 'secret-value' | gitsail secrets encrypt --key-file ./gitsail.agekey
```

Copy the output into the YAML value. Configure `age_key_file` in the host configuration and keep the private key outside Git. GitSail decrypts encrypted values before merging app vars and rendering templates. Rendered state contains plaintext, so keep `state_dir` private and outside the repository. Secret values are not included in reports.

To decrypt a value for inspection, use `gitsail secrets decrypt --key-file ./gitsail.agekey` and provide the encrypted value on standard input. Do not commit decrypted output or the private key.
