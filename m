Content-Type: multipart/mixed; boundary="===============3557257931739878774=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] doc: Add warning to SystemdEncrypt as highly experimental
Date: Tue, 15 Feb 2022 16:28:26 -0800
Message-ID: <20220216002826.1361879-2-prestwoj@gmail.com>
In-Reply-To: 20220216002826.1361879-1-prestwoj@gmail.com

--===============3557257931739878774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index d64bf5c2..f0bb020d 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -189,6 +189,8 @@ The group ``[General]`` contains general settings.
        be disabled here.
 =

    * - SystemdEncrypt
+
+       **Warning: This is a highly experimental feature**
      - Value: Systemd key ID
 =

        Enables network profile encryption using a systemd provided secret =
key.
-- =

2.34.1

--===============3557257931739878774==--

