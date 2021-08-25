Content-Type: multipart/mixed; boundary="===============4775914023608542213=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/5] scan: set force_default_sae_group if OUI matches
Date: Wed, 25 Aug 2021 10:12:55 -0700
Message-ID: <20210825171258.764596-2-prestwoj@gmail.com>
In-Reply-To: <20210825171258.764596-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4775914023608542213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 4 +++-
 src/scan.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 3faa6eb4..16bd2a87 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -924,7 +924,9 @@ static bool scan_parse_vendor_specific(struct scan_bss =
*bss, const void *data,
 			return false;
 =

 		bss->hs20_capable =3D true;
-	} else
+	} else if (is_ie_default_sae_group_oui(data, len))
+		bss->force_default_sae_group =3D true;
+	else
 		return false;
 =

 	return true;
diff --git a/src/scan.h b/src/scan.h
index 81c84bae..8a57c2b3 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -83,6 +83,7 @@ struct scan_bss {
 	bool vht_capable : 1;
 	bool anqp_capable : 1;
 	bool hs20_capable : 1;
+	bool force_default_sae_group : 1;
 };
 =

 struct scan_parameters {
-- =

2.31.1

--===============4775914023608542213==--

