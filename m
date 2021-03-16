Content-Type: multipart/mixed; boundary="===============4707456861020981568=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] client: add AverageRSSI to list of diagnostic values
Date: Tue, 16 Mar 2021 08:38:36 -0700
Message-ID: <20210316153836.218175-4-prestwoj@gmail.com>
In-Reply-To: <20210316153836.218175-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4707456861020981568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/diagnostic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 153598ed..58c646d7 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -88,6 +88,7 @@ static const struct diagnostic_dict_mapping diagnostic_ma=
pping[] =3D {
 	{ "TxBitrate", 0, NULL, display_bitrate_100kbps },
 	{ "ExpectedThroughput", 'u', "Kbit/s" },
 	{ "RSSI", 'n', "dBm" },
+	{ "AverageRSSI", 'n', "dBm" },
 	{ "RxMCS", 'y' },
 	{ "TxMCS", 'y' },
 	{ "Frequency", 'u' },
-- =

2.26.2

--===============4707456861020981568==--

