Content-Type: multipart/mixed; boundary="===============7440980998411218565=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] manpage: add section on embedding PEMs in settings
Date: Fri, 25 Oct 2019 12:11:32 -0400
Message-ID: <20191025161132.28367-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7440980998411218565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 75b8297a..2410aa57 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -235,6 +235,33 @@ authentication configuration.
        method's negotiation is encrypted, a secure identity string can be
        provided.
 =

+Embedded PEMs
+-------------
+
+Rather than including an absolute path to a PEM file (for certs or keys), =
the
+PEM itself can be included inside the settings file and referenced directl=
y.
+This allows 8021x network provisioning using a single file without any
+references to certificates/keys on the system.
+
+An embedded PEM can appear anywhere in the settings file using the followi=
ng
+format (this example the PEM is named 'my_ca_cert'):
+
+.. code-block::
+
+  [@pem(a)my_ca_cert]
+  ----- BEGIN CERTIFICATE -----
+  <PEM data>
+  ----- END CERTIFICATE -----
+
+After this special group tag its as simple as pasting in a PEM file includ=
ing
+the BEGIN/END tags. Now 'my_ca_cert' can be used to reference the certific=
ate
+elsewhere in the settings file by prefixing the value with 'embed:'
+
+EAP-TLS-CACert=3Dembed:my_ca_cert
+
+This is not limited to CA Certs either. Client certs, client keys (encrypt=
ed
+or not), and certificate chains can be included.
+
 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.21.0

--===============7440980998411218565==--

