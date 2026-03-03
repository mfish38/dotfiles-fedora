mkdir gpg-export
gpg --export-secret-keys --armor > gpg-export/private-keys.gpg
gpg --export --armor > gpg-export/public-keys.gpg
gpg --export-ownertrust > gpg-export/trustdb.txt
