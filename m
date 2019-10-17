Content-Type: multipart/mixed; boundary="===============1058404962837701844=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] eapol: do not parse RSN for WPA1 in 1 of 4
Date: Thu, 17 Oct 2019 16:43:16 -0700
Message-ID: <20191017234316.4271-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1058404962837701844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A recent change checked the return value of ie_parse_rsne_from_data
inside the ptk 1/4 handler. This seemed safe, but actually caused
the eapol unit test to fail.

The reason was because eapol was parsing the IEs assuming they were
an RSN, when they could be a WPA IE (WPA1 not WPA2). The WPA case
does not end up using the rsn_info at all, so having rsn_info
uninitialized did not pose a problem. After adding the return value
check it was found this fails every time for WPA1.

Since the rsn_info is not needed for WPA1 we can only do the RSN
parse for WPA2 and leave rsn_info uninitialized.
---
 src/eapol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 6f04dbc5..349e824f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1106,8 +1106,11 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm =
*sm,
 	pmkid =3D handshake_util_find_pmkid_kde(EAPOL_KEY_DATA(ek, sm->mic_len),
 					EAPOL_KEY_DATA_LEN(ek, sm->mic_len));
 =

-	if (ie_parse_rsne_from_data(own_ie, own_ie[1] + 2, &rsn_info) < 0)
-		goto error_unspecified;
+	if (!sm->handshake->wpa_ie) {
+		if (ie_parse_rsne_from_data(own_ie, own_ie[1] + 2,
+						&rsn_info) < 0)
+			goto error_unspecified;
+	}
 =

 	/*
 	 * Require the PMKID KDE whenever we've sent a list of PMKIDs in
-- =

2.17.1

--===============1058404962837701844==--

