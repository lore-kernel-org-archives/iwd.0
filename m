Content-Type: multipart/mixed; boundary="===============6985582482091294083=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] iwd: define a maximum password length
Date: Fri, 06 Mar 2020 11:16:26 -0800
Message-ID: <20200306191628.5461-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6985582482091294083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/iwd.h b/src/iwd.h
index 22223526..8b63aa7d 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -22,6 +22,13 @@
 =

 #define uninitialized_var(x) x =3D x
 =

+/*
+ * Set a maximum to prevent sending too much data to the kernel when hashi=
ng
+ * the password (or any other crypto operations involving the password).
+ * This value is not tied to IEEE or any RFC's, just chosen to be long eno=
ugh
+ */
+#define IWD_MAX_PASSWORD_LEN	2048
+
 struct l_genl;
 struct l_genl_family;
 =

-- =

2.17.1

--===============6985582482091294083==--

