Content-Type: multipart/mixed; boundary="===============7829403425897107235=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] resolve: Add IPv6 handler for systemd msg appender
Date: Wed, 09 Oct 2019 16:28:32 -0700
Message-ID: <20191009232832.7761-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7829403425897107235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/resolve.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/resolve.c b/src/resolve.c
index 932c891b..b502feb8 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -97,6 +97,13 @@ static bool systemd_builder_add_dns(struct l_dbus_messag=
e_builder *builder,
 		buf_size =3D 4;
 =

 		break;
+	case AF_INET6:
+		if (inet_pton(AF_INET6, dns, buf) < 1)
+			return false;
+
+		buf_size =3D 16;
+
+		break;
 	default:
 		return false;
 	}
-- =

2.13.6

--===============7829403425897107235==--

