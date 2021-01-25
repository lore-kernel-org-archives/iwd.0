Content-Type: multipart/mixed; boundary="===============3892248417116841648=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/7] doc: Update EAP-TLS client key setting information
Date: Mon, 25 Jan 2021 18:56:15 +0100
Message-ID: <20210125175617.2417412-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3892248417116841648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index cb3afc67..c0548052 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -211,20 +211,27 @@ authentication configuration.
    * - EAP-TLS-ClientCert
      - absolute file path or embedded pem
 =

-       Path to a PEM-formatted client X.509 certificate or certificate cha=
in
-       to send on server request.
+       Path to the client X.509 certificate or certificate chain to send on
+       server request.
    * - EAP-TLS-ClientKey
      - absolute file path or embedded pem
 =

-       Path to a PEM-formatted client PKCS#8 private key corresponding to =
the
-       public key provided in *EAP-TLS-ClientCert*.
+       Path to the client private key corresponding to the public key prov=
ided
+       in *EAP-TLS-ClientCert*.  The recommended format is PKCS#8 PEM.
+   * - EAP-TLS-ClientKeyBundle
+     - absolute file path
+
+       As an alternative to *EAP-TLS-ClientCert* and *EAP-TLS-ClientKey* I=
WD
+       can load both the certificate and the private key from a container =
file
+       pointed by this setting.  The recommended format is PKCS#12 when th=
is
+       is used.
    * - | EAP-TLS-
        | ClientKeyPassphrase
      - string
 =

-       Decryption key for the client private key file.  This is used if the
-       private key given by *EAP-TLS-ClientKey* is encrypted.  If not prov=
ided,
-       then the agent is asked for the passphrase at connection time.
+       Decryption key for the client key files.  This should be used if the
+       certificate or the private key in the files mentioned above is encr=
ypted.
+       When not given, the agent is asked for the passphrase at connection=
 time.
    * - | EAP-TLS-ServerDomainMask,
        | EAP-TTLS-ServerDomainMask,
        | EAP-PEAP-ServerDomainMask
-- =

2.27.0

--===============3892248417116841648==--

