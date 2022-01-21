Content-Type: multipart/mixed; boundary="===============6953232493427221923=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Thu, 20 Jan 2022 16:41:28 -0800
Message-ID: <20220121004130.2473281-1-prestwoj@gmail.com>

--===============6953232493427221923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There has been interest in enabling IWD users to store their network
credentials in some encrypted form. Recently systemd added support for
passing secrets/credentials to services only accessible by the service
they are intended. This provides a clean way of obtaining a secret key
which IWD can use to encrypt anything it writes to the FS. In addition
there is no hard dependency on systemd since the credential is provided
as a file (i.e. no Dbus API or linked library etc).

At the moment setting up the IWD service to use this feature will be
left up to the user. But setting this up is very straight forward. I
used docs for systemd-creds (Example 2):

https://www.freedesktop.org/software/systemd/man/systemd-creds.html

The only difference is the --name argument should be iwd-secret.

Note: systemd version 250 is required.

The reason this is being sent as an RFC is because of some open questions
I had and wanted feedback on:

 1. What options specifically do we want encrypted? These patches only
    address Passphrase and PreSharedKey but really any option could be
    encrypted. Obviously we would also want 802.1x secrets, but are there
    other non-obvious options with privacy concerns?

 2. What is the stance on existing provisioning files? Currently these
    changes overwrite any existing files with the new *Encrypted options
    automatically. Is this desirable? or should user have to opt-in their
    existing provisioning files.

 3. Is the secret provided via a file enough? (the secret is still stored
    as plaintext *somewhere*, though systemd limits permissions). Systemd
    supports an IPC mechanism to obtain the secret. Is this more secure?

 4. Should full provisioning file encryption be optional/supported? I felt
    it was best to only encrypt sensitive options like PSK/Passphrase which
    would allow editing of the provisioning file without extra steps of
    decrypting, editing, and encrypting. I think this is above the capabili=
ty
    or desire of most users.
    =

    If, though, a provisioning file is never expected to change or issued by
    a network administrator that does not want it edited I could see full
    file encryption being ok.

James Prestwood (2):
  main: add SystemdEncrypt option, and initialize key
  network: add support for encrypted Passphrase/PSK

 src/iwd.h     |   1 +
 src/main.c    |  64 ++++++++++++++++++
 src/network.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 242 insertions(+), 6 deletions(-)

-- =

2.31.1

--===============6953232493427221923==--

