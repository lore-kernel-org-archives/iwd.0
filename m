Content-Type: multipart/mixed; boundary="===============0048865919681346216=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] eap: warn on too small of buffer
Date: Mon, 08 Feb 2021 13:18:10 -0800
Message-ID: <20210208211812.612391-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0048865919681346216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In practice a caller will know the contents of their buffer,
but just in case it would be nice to print a warning. This
may not satisfy static analysis, but at least with this the
developer will be informed what they are doing is wrong.
---
 src/eap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/eap.c b/src/eap.c
index dea0c3cf..39c950a2 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -167,6 +167,9 @@ static void eap_send_response(struct eap_state *eap, en=
um eap_type type,
 	buf[4] =3D type;
 =

 	if (type =3D=3D EAP_TYPE_EXPANDED) {
+		if (L_WARN_ON(len < 12))
+			return;
+
 		memcpy(buf + 5, eap->method->vendor_id, 3);
 		l_put_be32(eap->method->vendor_type, buf + 8);
 	}
-- =

2.26.2

--===============0048865919681346216==--

