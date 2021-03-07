## Extending Your GPG Key

Find the KeyID of the key to extend:

```console
gpg --list-keys
```
Edit the key:

```console
gpg --edit-key KEYID
```

Extend the expiration for "1y":

```console
gpg> expire
```

Select the subkey:

```console
gpg> key 1
```

Extend the expiration for "1y":

```console
gpg> expire
```

Persist the changes:

```console
gpg> save
```

Backup keys:
```console
gpg -a --export KEYID > key.public
gpg -a --export-secret-keys KEYID > key.private
```
