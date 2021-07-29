Content-Type: multipart/mixed; boundary="===============0623588471721330281=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] test-runner: remove TLS debugging artifact
Date: Thu, 29 Jul 2021 15:21:48 -0700
Message-ID: <20210729222154.159542-3-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0623588471721330281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When logging is enabled TLS debugging is turned on which creates
a PEM file during runtime. There is no way for IWD itself to clean
this up since its meant to be there for debugging.
---
 tools/test-runner | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 98164f7a..fa3c434f 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1192,6 +1192,10 @@ def post_test(ctx, to_copy):
 				dbg("\n")
 				os.remove('/tmp/' + f)
 =

+	# Special case for when logging is enabled
+	if os.path.isfile('/tmp/iwd-tls-debug-server-cert.pem'):
+		os.remove('/tmp/iwd-tls-debug-server-cert.pem')
+
 	allowed =3D ['phonesim.conf', 'certs', 'secrets', 'iwd']
 	for f in [f for f in os.listdir('/tmp') if f not in allowed]:
 		dbg("File %s was not cleaned up!" % f)
-- =

2.31.1

--===============0623588471721330281==--

