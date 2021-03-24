Content-Type: multipart/mixed; boundary="===============6092660458047255972=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] client: add AKMSuite to diagnostics
Date: Wed, 24 Mar 2021 15:25:59 -0700
Message-ID: <20210324222559.577225-4-prestwoj@gmail.com>
In-Reply-To: <20210324222559.577225-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6092660458047255972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/diagnostic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 58c646d7..d5ff7738 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -92,6 +92,7 @@ static const struct diagnostic_dict_mapping diagnostic_ma=
pping[] =3D {
 	{ "RxMCS", 'y' },
 	{ "TxMCS", 'y' },
 	{ "Frequency", 'u' },
+	{ "AKMSuite", 's' },
 	{ NULL }
 };
 =

-- =

2.26.2

--===============6092660458047255972==--

