Content-Type: multipart/mixed; boundary="===============7678151792232236143=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] client: add AKMSuite to diagnostics
Date: Wed, 24 Mar 2021 16:05:38 -0700
Message-ID: <20210324230538.583325-4-prestwoj@gmail.com>
In-Reply-To: <20210324230538.583325-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7678151792232236143==
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

--===============7678151792232236143==--

