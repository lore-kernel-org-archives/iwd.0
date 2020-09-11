Content-Type: multipart/mixed; boundary="===============6882239813708900533=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8] ap: Fix setting the basic rate in Supported Rates IE
Date: Fri, 11 Sep 2020 21:50:57 +0200
Message-ID: <20200911195103.385070-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200911195103.385070-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6882239813708900533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index ae33b461..2a979661 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -380,10 +380,10 @@ static size_t ap_build_beacon_pr_head(struct ap_state=
 *ap,
 				flag =3D 0x80;
 =

 			*rates++ =3D r | flag;
+			count++;
 		}
 =

-	ie_tlv_builder_set_length(&builder, rates -
-					ie_tlv_builder_get_data(&builder));
+	ie_tlv_builder_set_length(&builder, count);
 =

 	/* DSSS Parameter Set IE for DSSS, HR, ERP and HT PHY rates */
 	ie_tlv_builder_next(&builder, IE_TYPE_DSSS_PARAMETER_SET);
-- =

2.25.1

--===============6882239813708900533==--

