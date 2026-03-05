mkdir gpg-export
gpg --export-secret-keys --armor > gpg-export/private-keys.gpg
[ -s gpg-export/private-keys.gpg ] || echo "Error: gpg-export/private-keys.gpg is empty" >&2
gpg --export --armor > gpg-export/public-keys.gpg
[ -s gpg-export/public-keys.gpg ] || echo "Error: gpg-export/public-keys.gpg is empty" >&2
gpg --export-ownertrust > gpg-export/trustdb.txt
[ -s gpg-export/trustdb.txt ] || echo "Error: gpg-export/trustdb.txt is empty" >&2
