Content-Type: multipart/mixed; boundary="===============3650414479631985734=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] resolve: Fix check for incorrect function name
Date: Tue, 17 Dec 2019 14:53:36 -0800
Message-ID: <20191217225336.9500-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3650414479631985734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/resolve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/resolve.c b/src/resolve.c
index 1d9bbe0a..c8cda269 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -435,7 +435,7 @@ void resolve_add_domain_name(uint32_t ifindex, const ch=
ar *domain_name)
 	if (!domain_name)
 		return;
 =

-	if (!method.ops || !method.ops->add_dns)
+	if (!method.ops || !method.ops->add_domain_name)
 		return;
 =

 	method.ops->add_domain_name(ifindex, domain_name, method.data);
-- =

2.13.6

--===============3650414479631985734==--

