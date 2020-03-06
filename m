Content-Type: multipart/mixed; boundary="===============4963500579681445033=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] iwd: define a maximum passphrase length
Date: Fri, 06 Mar 2020 10:34:35 -0800
Message-ID: <20200306183437.31440-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4963500579681445033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

v2:
 - Renamed to IWD_MAX_PASSWORD_LEN

diff --git a/src/iwd.h b/src/iwd.h
index 22223526..426af743 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -22,6 +22,15 @@
 =

 #define uninitialized_var(x) x =3D x
 =

+/*
+ * Set a maximum to prevent sending too much data to the kernel when hashi=
ng
+ * the passphrase (or any other crypto operations involving the passphrase=
).
+ * This will also prevent potential stack overflows if the passphrase is p=
ut
+ * into EAP packets on the stack (EAP-GTC). This value is not tied to IEEE=
 or
+ * any RFC's, just chosen to be long enough to not restrict a normal user.
+ */
+#define IWD_MAX_PASSWORD_LEN	2048
+
 struct l_genl;
 struct l_genl_family;
 =

-- =

2.17.1

--===============4963500579681445033==--

