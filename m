Content-Type: multipart/mixed; boundary="===============2129424484047678307=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] iwd: define a maximum passphrase length
Date: Fri, 06 Mar 2020 09:48:40 -0800
Message-ID: <20200306174843.26578-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2129424484047678307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/iwd.h b/src/iwd.h
index 22223526..5371d8e5 100644
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
+#define IWD_MAX_PASSPHRASE_LEN	2048
+
 struct l_genl;
 struct l_genl_family;
 =

-- =

2.17.1

--===============2129424484047678307==--

