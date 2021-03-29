Content-Type: multipart/mixed; boundary="===============7063952974286169780=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] client: add Security key to diagnostics
Date: Mon, 29 Mar 2021 10:33:10 -0700
Message-ID: <20210329173310.706671-4-prestwoj@gmail.com>
In-Reply-To: <20210329173310.706671-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7063952974286169780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/diagnostic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 58c646d7..9e255918 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -92,6 +92,7 @@ static const struct diagnostic_dict_mapping diagnostic_ma=
pping[] =3D {
 	{ "RxMCS", 'y' },
 	{ "TxMCS", 'y' },
 	{ "Frequency", 'u' },
+	{ "Security", 's' },
 	{ NULL }
 };
 =

-- =

2.26.2

--===============7063952974286169780==--

