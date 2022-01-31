Content-Type: multipart/mixed; boundary="===============4997080150949901828=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] doc: document SystemdEncrypt
Date: Mon, 31 Jan 2022 12:11:54 -0800
Message-ID: <20220131201155.3878756-4-prestwoj@gmail.com>
In-Reply-To: 20220131201155.3878756-1-prestwoj@gmail.com

--===============4997080150949901828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst  | 16 ++++++++++++++++
 src/iwd.network.rst |  6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 54943702..a3d19fe5 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -188,6 +188,22 @@ The group ``[General]`` contains general settings.
        by the kernel so if kernels/drivers exist which don't support OCV i=
t can
        be disabled here.
 =

+   * - SystemdEncrypt
+     - Value: Systemd key ID
+
+       Enables network profile encryption using a systemd provided secret =
key.
+       Once enabled all PSK/8021x network profiles will be encrypted
+       automatically. Once the profile is encrypted there is no way of goi=
ng
+       back using IWD alone. A tool, decrypt-profile, is provided assuming=
 the
+       secret is known which will decrypt a profile. This decrypted profile
+       could manually be set to /var/lib/iwd to 'undo' any profile encrypt=
ion,
+       but its going to be a manual process.
+
+       Setting up systemd to provide the secret is left up to the user as =
IWD
+       has no way of performing this automatically. The systemd options re=
quired
+       are LoadCredentialEncrypted or SetCredentialEncrypted, and the secr=
et
+       identifier should be named whatever SystemdEncrypt is set to.
+
 Network
 -------
 =

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index e3d1a90a..34f8de1a 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -179,7 +179,11 @@ Network Authentication Settings
 -------------------------------
 =

 The group ``[Security]`` contains settings for Wi-Fi security and
-authentication configuration.
+authentication configuration. This group can be encrypted by enabling
+``SystemdEncrypt``, see *iwd.config* for details on this option. If this s=
ection
+is encrypted (only contains EncryptedSalt/EncryptedSecurity) it should not=
 be
+modified. Modifying these values will result in the inability to connect t=
o that
+network.
 =

 .. list-table::
    :header-rows: 0
-- =

2.31.1

--===============4997080150949901828==--

