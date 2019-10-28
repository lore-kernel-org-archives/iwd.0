Content-Type: multipart/mixed; boundary="===============8749560294461070447=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] manpages: replace shorthand words
Date: Mon, 28 Oct 2019 09:10:13 -0700
Message-ID: <20191028161013.7725-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8749560294461070447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replaces cases of 'certs' with 'certificates', and 8021x with IEEE 802.1x
---
 src/iwd.network.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 33efd3f4..4a843b7e 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -234,10 +234,10 @@ authentication configuration.
 Embedded PEMs
 -------------
 =

-Rather than including an absolute path to a PEM file (for certs or keys), =
the
-PEM itself can be included inside the settings file and referenced directl=
y.
-This allows 8021x network provisioning using a single file without any
-references to certificates/keys on the system.
+Rather than including an absolute path to a PEM file (for certificates and
+keys), the PEM itself can be included inside the settings file and referen=
ced
+directly. This allows IEEE 802.1x network provisioning using a single file
+without any references to certificates or keys on the system.
 =

 An embedded PEM can appear anywhere in the settings file using the followi=
ng
 format (this example the PEM is named 'my_ca_cert'):
@@ -255,8 +255,8 @@ elsewhere in the settings file by prefixing the value w=
ith 'embed:'
 =

 EAP-TLS-CACert=3Dembed:my_ca_cert
 =

-This is not limited to CA Certs either. Client certs, client keys (encrypt=
ed
-or not), and certificate chains can be included.
+This is not limited to CA Certificates either. Client certificates, client=
 keys
+(encrypted or not), and certificate chains can be included.
 =

 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
-- =

2.17.1

--===============8749560294461070447==--

