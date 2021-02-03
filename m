Content-Type: multipart/mixed; boundary="===============7661145429482373959=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] client: add Frequency to station show
Date: Wed, 03 Feb 2021 09:20:45 -0800
Message-ID: <20210203172045.180677-3-prestwoj@gmail.com>
In-Reply-To: <20210203172045.180677-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7661145429482373959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/diagnostic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 9d6b599d..c94178d6 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -87,6 +87,7 @@ static const struct diagnostic_dict_mapping diagnostic_ma=
pping[] =3D {
 	{ "RSSI", 'n', "dBm" },
 	{ "RxMCS", 'y' },
 	{ "TxMCS", 'y' },
+	{ "Frequency", 'u' },
 	{ NULL }
 };
 =

-- =

2.26.2

--===============7661145429482373959==--

