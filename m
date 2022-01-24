Content-Type: multipart/mixed; boundary="===============5624093518793838937=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [RFCv2 0/3] Encrypt secrets using systemd provided key
Date: Mon, 24 Jan 2022 11:49:33 -0800
Message-ID: <20220124194936.2988442-1-prestwoj@gmail.com>

--===============5624093518793838937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v1 -> v2:
 - Encrypt entire [Settings] group. Rather than needing to add a new
   'Encrypted' option for each key, encrypt the entire group. This makes
   8021x much easier to handle as well since those options are recursively
   filled (e.g. -Phase2). Handling these individually would be quite nasty.

 - Use a salt value when encrypting/decryption (EncryptedSalt)

 - Use AES-SIV instead of AES-CTR. The auth data is set to the encrypted
   salt and network->ssid. This ensures a unique encrypted value even if
   the passphrase is the same. AES-SIV also verifies the IV on decrypt
   automatically so you know if it failed or succeeded.

 - Added a new tool: decrypt-profile. This is nice for debugging and could
   be used to recover encrypted profiles if you know the secret.

Also if you want to play with this this yourself you can try it out even
without systemd. Systemd only sets the CREDENTIALS_DIRECTORY environment
variable which can be done manually. It should point to a file containing t=
he
decrypted secret:

Create a file named 'iwd-secret' with a secret (can be binary too). For
example:

/var/lib/iwd/iwd-secret:
secret123

Enable SystemdEncrypt=3Dtrue in main.conf

Start IWD with CREDENTIALS_DIRECTORY set:

CREDENTIALS_DIRECTORY=3D/var/lib/iwd ./src/iwd

You may also want to use a separate storage directory as IWD will encrypt
any profile once connected to that network (i.e. when IWD sync's).

James Prestwood (3):
  main: add SystemdEncrypt option, and initialize key
  network: add support for encrypted [Security] group
  tools: add decrypt-profile tool

 Makefile.am             |   8 +-
 src/iwd.h               |   1 +
 src/main.c              |  65 +++++++++++++
 src/network.c           | 177 +++++++++++++++++++++++++++++++----
 tools/decrypt-profile.c | 201 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 431 insertions(+), 21 deletions(-)
 create mode 100644 tools/decrypt-profile.c

-- =

2.31.1

--===============5624093518793838937==--

