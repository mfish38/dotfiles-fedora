gpg --import gpg-export/private-keys.gpg
gpg --import gpg-export/public-keys.gpg
gpg --import-ownertrust gpg-export/trustdb.txt

gpg --list-secret-keys --keyid-format LONG
