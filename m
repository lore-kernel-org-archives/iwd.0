Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76F1F03C5
	for <iwd@lists.linux.dev>; Wed, 24 Dec 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572138; cv=none; b=bX0pqZbrss+2o4x+fujZPmJV+kN3tIWbwjlXjv4RFpvNQXHkPjh5T+LKoBI3PWSddH1duzr3+yk+tX5T04D5WlfNJP90sV4gKrx9T6gdspqnN20u4hfMDFhx0SD66hBFBNAHRC4Kt4Tbcw8rdkAdmW3E7+7MKOUi2fwyfJGouIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572138; c=relaxed/simple;
	bh=9RvJWrcPHwJ4NkC+EXYxKNVxazhk1dVQiyYO5LnxyEA=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=TcpOraBI6nwTzbgC0l23+GHaWHi0Mpi+d9e+JltQurPJtx59uHuCBs/76IjpkfulZxGSWhOGKczdA5HICB4UWloenfumzzxvRM4XF0kMBI5vD57E7dXVMkFQnc/LQh/xTGz1uXvjju9t8X1LjyU4KPeBtMsi70Zq/eyqTj8zTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za; spf=pass smtp.mailfrom=deschouwer.co.za; dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b=NAsyUuRj; arc=none smtp.client-ip=185.70.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b="NAsyUuRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deschouwer.co.za;
	s=protonmail; t=1766572123; x=1766831323;
	bh=AIgqXc+8nhy/UNjVT0FMUR4CBbguauW0/MbGsQxPofs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NAsyUuRjaHMMs8PZKsiaixeFm8NZLS0DkR1SYyUaysw8eL9kM1VW3OkK1ico0DcTq
	 J3wwrd3UyIh/a3wAM0W8HX37l/oYSyhBFcjATRJHhp9HOTViA1KjokDSjcrVd2RSRY
	 Pc1PlvSEc+LfgG5LJRgtIENvGApATl3KH1LgXtzHWv/UFox7ooWb/V7G7rwqX5yQAi
	 tSNQF0NBcB5+qY+6XhRLk0kRdn1ecUB2kik/d2+G5Pr26Spv8K1Z/L2UusMM7O2ZDA
	 JzyochDrv/c8kUiPb4VF1Mkl5E7wanSZJKDAJuG47wd0Y+7FS+IUol5+Fexbx5OSnj
	 wzoHwOqCkDjNA==
Date: Wed, 24 Dec 2025 10:28:40 +0000
To: iwd@lists.linux.dev
From: berend <berend@deschouwer.co.za>
Subject: [PATCH] ap: add vendor quirk for reused nonce in handshake
Message-ID: <475b4065883774c297edb6e26c494e72bc094575.camel@deschouwer.co.za>
Feedback-ID: 50941660:user:proton
X-Pm-Message-ID: 16ec42c4f8ea6af59d0104566120916f15ccbfec
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------52cc4b944b3c16770ea46776d0beb1706030ab98695a5edfb73d0c327314159d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------52cc4b944b3c16770ea46776d0beb1706030ab98695a5edfb73d0c327314159d
Content-Type: multipart/mixed;
 boundary=555c03b5285c6ef426ed57ee823b8febfc4cfbb03b7056604f8bc59a0e8e
Message-ID: <475b4065883774c297edb6e26c494e72bc094575.camel@deschouwer.co.za>
Subject: [PATCH] ap: add vendor quirk for reused nonce in handshake
From: berend <berend@deschouwer.co.za>
To: iwd@lists.linux.dev
Date: Wed, 24 Dec 2025 12:28:31 +0200
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0

--555c03b5285c6ef426ed57ee823b8febfc4cfbb03b7056604f8bc59a0e8e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

commit 486cd7b1cd20bfa81437d89cdd7c8f8df7e23bfa
Author: Berend De Schouwer <berend@deschouwer.co.za>
Date:   Wed Dec 24 11:28:17 2025 +0200

    ap: add vendor quirk for reused nonce in handshake
   =20
    Add a vendor quirk when IWD is an AP, to allow some
    Garmin IoT devices to connect.
   =20
    handshake_reuse_nonce:
      When a supplicant does a handshake, the nonce in message 4 should
      be set to zero.  On some devices it's left identical to message
2.

diff --git a/src/ap.c b/src/ap.c
index af6a1709..1f805a81 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -59,6 +59,7 @@
 #include "src/diagnostic.h"
 #include "src/band.h"
 #include "src/common.h"
+#include "src/vendor_quirks.h"
=20
 struct ap_state {
        struct netdev *netdev;
@@ -143,6 +144,7 @@ struct sta_state {
        struct l_dhcp_lease *ip_alloc_lease;
        bool ip_alloc_sent;
        uint64_t rekey_time;
+       struct vendor_quirk vendor_quirks;
=20
        bool ht_support : 1;
        bool ht_greenfield : 1;
@@ -1384,6 +1386,7 @@ static void ap_start_handshake(struct sta_state
*sta, bool use_eapol_start,
        handshake_state_set_ssid(sta->hs, (void *) ap->ssid, strlen(ap-
>ssid));
        handshake_state_set_authenticator_address(sta->hs, own_addr);
        handshake_state_set_supplicant_address(sta->hs, sta->addr);
+       handshake_state_set_vendor_quirks(sta->hs, sta->vendor_quirks);
=20
        ap_set_rsn_info(ap, &rsn);
        /*
@@ -2974,6 +2977,7 @@ static void ap_handle_new_station(struct ap_state
*ap, struct l_genl_msg *msg)
        const void *data;
        const uint8_t *mac =3D NULL;
        uint8_t *assoc_rsne =3D NULL;
+       const char *vendor_quirks;
=20
        if (!l_genl_attr_init(&attr, msg))
                return;
@@ -3014,6 +3018,13 @@ static void ap_handle_new_station(struct
ap_state *ap, struct l_genl_msg *msg)
        sta->assoc_rsne =3D assoc_rsne;
        sta->aid =3D ++ap->last_aid;
=20
+       vendor_quirks_append_for_mac(sta->addr, &sta->vendor_quirks);
+
+       vendor_quirks =3D vendor_quirks_to_string(sta->vendor_quirks);
+       if (vendor_quirks)
+               l_debug("vendor quirks for "MAC": %s",
+                               MAC_STR(sta->addr), vendor_quirks);
+
        sta->associated =3D true;
=20
        if (!ap->sta_states)
diff --git a/src/eapol.c b/src/eapol.c
index ab77746f..b603ae39 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -605,7 +605,8 @@ bool eapol_verify_ptk_3_of_4(const struct eapol_key
*ek, bool is_wpa,
        return true;
 }
=20
-bool eapol_verify_ptk_4_of_4(const struct eapol_key *ek, bool is_wpa)
+bool eapol_verify_ptk_4_of_4(const struct eapol_key *ek, bool is_wpa,
+                               const uint8_t *quirk_nonce)
 {
        uint16_t key_len;
=20
@@ -636,7 +637,9 @@ bool eapol_verify_ptk_4_of_4(const struct eapol_key
*ek, bool is_wpa)
        key_len =3D L_BE16_TO_CPU(ek->key_length);
        L_WARN_ON(key_len !=3D 0);
=20
-       VERIFY_IS_ZERO(ek->key_nonce);
+       if ((!quirk_nonce) || memcmp(ek->key_nonce, quirk_nonce,
+                                       sizeof(ek->key_nonce)))
+               VERIFY_IS_ZERO(ek->key_nonce);
        VERIFY_IS_ZERO(ek->eapol_key_iv);
        VERIFY_IS_ZERO(ek->key_rsc);
        VERIFY_IS_ZERO(ek->reserved);
@@ -2122,10 +2125,15 @@ static void eapol_handle_ptk_4_of_4(struct
eapol_sm *sm,
                                        const struct eapol_key *ek)
 {
        const uint8_t *kck;
+       const uint8_t *quirk_nonce =3D NULL;
=20
        l_debug("ifindex=3D%u", sm->handshake->ifindex);
=20
-       if (!eapol_verify_ptk_4_of_4(ek, false))
+       if (sm->handshake->vendor_quirks.handshake_nonce_reuse &&
+                       sm->handshake->have_snonce)
+               quirk_nonce =3D sm->handshake->snonce;
+
+       if (!eapol_verify_ptk_4_of_4(ek, false, quirk_nonce))
                return;
=20
        if (L_BE64_TO_CPU(ek->key_replay_counter) !=3D sm-
>replay_counter)
diff --git a/src/eapol.h b/src/eapol.h
index 43dc224d..36946017 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -70,7 +70,8 @@ bool eapol_verify_ptk_1_of_4(const struct eapol_key
*ek, size_t mic_len,
 bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek, bool
ptk_complete);
 bool eapol_verify_ptk_3_of_4(const struct eapol_key *ek, bool is_wpa,
                                size_t mic_len);
-bool eapol_verify_ptk_4_of_4(const struct eapol_key *ek, bool is_wpa);
+bool eapol_verify_ptk_4_of_4(const struct eapol_key *ek, bool is_wpa,
+                               const uint8_t *quirk_nonce);
 bool eapol_verify_gtk_1_of_2(const struct eapol_key *ek, bool is_wpa,
                                size_t mic_len);
 bool eapol_verify_gtk_2_of_2(const struct eapol_key *ek, bool is_wpa);
diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
index 4fba0c33..001fcb13 100644
--- a/src/vendor_quirks.c
+++ b/src/vendor_quirks.c
@@ -47,6 +47,17 @@ static const struct {
        },
 };
=20
+static const struct {
+       uint8_t mac[3];
+       struct vendor_quirk quirks;
+} mac_quirk_db[] =3D {
+       {
+               /* Garmin International */
+               { 0x90, 0xf1, 0x57 },
+               { .handshake_nonce_reuse =3D true },
+       },
+};
+
 void vendor_quirks_append_for_oui(const uint8_t *oui,
                                        struct vendor_quirk *quirks)
 {
@@ -65,6 +76,22 @@ void vendor_quirks_append_for_oui(const uint8_t
*oui,
        }
 }
=20
+void vendor_quirks_append_for_mac(const uint8_t *mac,
+                                       struct vendor_quirk *quirks)
+{
+       size_t i;
+
+       for (i =3D 0; i < L_ARRAY_SIZE(mac_quirk_db); i++) {
+               const struct vendor_quirk *quirk =3D
&mac_quirk_db[i].quirks;
+
+               if (memcmp(mac_quirk_db[i].mac, mac, 3))
+                       continue;
+
+               quirks->handshake_nonce_reuse |=3D
+                               quirk->handshake_nonce_reuse;
+       }
+}
+
 const char *vendor_quirks_to_string(struct vendor_quirk quirks)
 {
        static char out[1024];
@@ -77,6 +104,9 @@ const char *vendor_quirks_to_string(struct
vendor_quirk quirks)
        if (quirks.replay_counter_mismatch)
                s +=3D snprintf(pos, sizeof(out) - s,
"ReplayCounterMismatch");
=20
+       if (quirks.handshake_nonce_reuse)
+               s +=3D snprintf(pos, sizeof(out) - s,
"HandshakeNonceReuse");
+
        if (!s)
                return NULL;
=20
diff --git a/src/vendor_quirks.h b/src/vendor_quirks.h
index b5d726ca..0e199c3a 100644
--- a/src/vendor_quirks.h
+++ b/src/vendor_quirks.h
@@ -29,11 +29,15 @@
 struct vendor_quirk {
        bool ignore_bss_tm_candidates : 1;
        bool replay_counter_mismatch : 1;
+       bool handshake_nonce_reuse : 1;
 };
=20
 void vendor_quirks_append_for_oui(const uint8_t *oui,
                                        struct vendor_quirk *quirks);
=20
+void vendor_quirks_append_for_mac(const uint8_t *oui,
+                                       struct vendor_quirk *quirks);
+
 const char *vendor_quirks_to_string(struct vendor_quirk quirks);
=20
 #endif /* __IWD_VENDOR_QUIRKS_H */

--555c03b5285c6ef426ed57ee823b8febfc4cfbb03b7056604f8bc59a0e8e
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - Berend De Schouwer -
 0x128CD671.asc"; name="publickey - Berend De Schouwer - 0x128CD671.asc"
Content-Type: application/pgp-keys; filename="publickey - Berend De Schouwer
 - 0x128CD671.asc"; name="publickey - Berend De Schouwer - 0x128CD671.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOC4yCgp4c0ZOQkZXS2tVRUJFQURYdWlFWVcx
WUlnTm5yYXpFby8wemVsVHp4YkhDRy93V3huN0FTdWQ4eEhMMWpxWks1CnF4UVMvNldSYm5RdjVj
NURQdmsxT2Y2RS8yWFZzRlVRSmdSMVlGeEd0TnQxUUFsNVIwdmo3cnZyOG5CYmVRaGMKbUhzdndH
cFQ3YWJrZXZXRnZtY0hiTktmWGJjL3NmRHJDTW90UkZRQm9oYzdveW8rTnpPSk9RcEpxQ2J6d2sr
awpWbVZoVkhwdzhZenZuRDJzVkRxYlFPeHRXbXJjb2ZtOURiMjhORTBOY04yUDlBQmJOSnV0MVFV
Wld0WjFsbVc2CnJ5aGdLckM0dXhTei9ZTmNjNXpzMlo3NjFTR0tPU1k4UFZ6dlZrTGJLOWZiZFk3
amNnR0NGZDZHUllPQjJJM0IKN0NPOXVhZnVUb0NEeWhscWx1Z1dYcEdvQTVCN28vYTRaMWI3cWxO
c0VtcWxHaCtlRDk0SDhNL0xXOGR3WU5SSQpvVU5ZSWF5UkYxT1FwcmM1UHozaUN4YW9ub0lpR2Z4
R1pxTktUOVFXb0lnOHJPQzA4dGNyOHVqNG0xUmpKcnN6ClNqdGt3c29tMFV3cEJ5Z0hlLzNCcDR4
WlN4Z2FmTXc2ZEdTS1JzRFRBSGoyRkpGV2N0Tmx1WTRqdnhSWDdDdVcKNTlRMzVKSUU4bStPZ1li
Z0xrR1FmRWRVeWhjUnFCMCtWUjJXUmxYNXNLVVprV2cxQWhnY0w3RmltTmxsM2YwNgp5ZS91emJy
YVVZSFg3eGMzdjVDSjJaNnd4Nk1waFp6aGh4dUJxTGNZSkViTjlmTnNldlRPWWtFUUlzR0M3Tldv
ClQyaHkzdWplWUJQajNjbzJOZDRpV085dHB5c0xaOGdLMTUvZE5qTUJUc3ByUys5UlBxZ3o1QnRG
bXdBUkFRQUIKelN4Q1pYSmxibVFnUkdVZ1UyTm9iM1YzWlhJZ1BHSmxjbVZ1WkVCa1pYTmphRzkx
ZDJWeUxtTnZMbnBoUHNMQgplQVFUQVFJQUlnVUNWWXFSUVFJYkF3WUxDUWdIQXdJR0ZRZ0NDUW9M
QkJZQ0F3RUNIZ0VDRjRBQUNna1EyMjdnCmNaT0FvT25YZGcvOUVGZFJyL1h0T1liQmVsdGIwc05I
YVNQN1M0dmtscWNBdE9udFRZVjN5TUZOdjlYQlhYdkYKU0thR2wwbTVMaGVOQWtJdS9ZYkFkR1h5
U3pOVWQ3V3NmeWIrMjNpcTVVS0d0K3dEK1JvY0xaWTA5NHVBS2NRUQpUWndKS1R3NHRLSWdONHFC
dE9hTmlKd0x1cnNOWllBUDdKSUpGUFFZNTVwYSt5ZWMzanhmVFgwYTdydWllY29zCm16YXZRMTgy
VitMZGV2Mmtvckd2WTFjejQzclA4eGlMMURqdGNCVW5laWdiajUrTjBaOFVsam5SNlFrU1J1YWoK
ZHNHQkFYSG1rT3NCVi9vOE04dkZXYThOODN1czFHa3k1SzU0eFFPYVZ5TlJWclI0RUlTdjh5MGkz
M3J3R1l2UApCRCtSS2FMYWN1S2I4KzhLTlZ1UTVNMHYrNHBHci9GZVhwUCtuUHpWRGZiWlpoWDFp
d2VRMDY5TEthOXJlZjhxCkV3NFZWdDdBdVlGU3dlSFZNSUNBMFpHeUtKNWhaejdMZEkwdkFGQU55
VXQwS29XZWVLNjl4aWs4cnZGNzVlbzQKZnovV0p0Zi9BZG5DdVlwNjBvYm94L3NKQTdLclpyV1FO
YkRjbEplZmlTWlY3dHVIaDdqTEpxUXVma201RDVnbwp3QUFvNWdyTS82V0FOSFZ3NWlvak0vVUc2
ZjArdEZaWGdGTXlrMkpaeTljMnM4VlFnSTJVenJiVThKc0N0ZERqCkJVU1RDNjRSN2tsdlY1Ymt1
MzFBbTNSUEMyOWwxaGZZKzNVTGc0dzhtbXBKMjhwcSsvejBvS0g4Q3d5aWN1RlAKRkJHOTVsbi83
dHRlNGlmV2tmek1MOE9oMmJwdUtFYjJQV1I0NHNRMVpxOCtJQWpTMlh3TDQ1N093VTBFVllxUgpR
UUVRQUtYYUwvaEhueXdzRnlVUVVHNVdxYm9xSHRWODNTNEc5aEpMQ25MOWhnU0J2Z2twbTRjNi85
Mmt6Lzh5CmdvRTRjUjNHSmZsZm40OHRUNFkvWDZzTkZiSXY5VkhpWVo4aW9YVUc0bHBhMFIyN3pk
MVZZT1pXUStvS3RjRnoKb1djVlViOHQrT1BoM2tuME5WQWxFRnlya0k5YWdUc0p1OFJ0alNpMEV6
Wi9iQ0xaTStFMU9UQnpZUzFuelZlcgp1NVVid1FWbXAzbUlzS2JSVTRRbnpZSElWVGNFeDF5SGxC
M1ZkZFd6M0pnenVsWlF4SDdRREVGaTVBaDhjcUVDCjJSZ2w2K2JkdVBqYnJBK2RwV2VaTGtvUGhH
d0xZcVM0YnJxN0ZBbmtMMjFSTGVGQzkvY203dTNaMnozd1o5QXkKZWt2bmtPNnhxdGlqcDB2Y0RD
V3kxbldiV0tpN2Y5K1NQWW5xTTNKVFBqWnlobk9CQ2pWTFhUcnlYQ3BhRGFCYgpnWGZRSlpMOWwx
bTRqVzBoQjNEdlU5eGQ2Zi8zdW1vODMzS1BnMm5XenpnZ0tRODREUUd3L0hYdkFSdDVtR0ZTCmQv
REtkMlliTHc5QjJKSlpqb2kzc2VGWlN6YVZKZ0FWZk9neUk0NHRnN3pJSlVUZDk2VzVpeEE3SEVP
TkV4cG0KQ0JrZ3ArMmswZEg1SU84c1lXd1o0c3lXQk5kZ1cxeGd2Qzc1dm94TmZTZGJmcGRhMG91
YU5xYVR0YjdzcnlVZApsTFZ3bExZZkV4NU9EeFFVY1VyNHRKUDhsR1I4dkEwemhGSEJhTEdCcjBa
SU16UU5TcS9jS3NrNnNESXI0Wms1ClZMT0VVN3R3SFRrZjQ3bXpWTExCQmZ6alJJc2hXRnJvNnBj
NDFBaGk5Y3ArQ3hLYkFCRUJBQUhDd1Y4RUdBRUMKQUFrRkFsV0trVUVDR3d3QUNna1EyMjdnY1pP
QW9PbXkzUkFBdGpNMGtPQjN1OTZ0S0pieGpERnlUTjZhTk9WLwo5WXk2V2doRjJITldvN0hzbk55
dnNRTkF1cHhWMndBTGF0UGVjUFgrL04vdWVGUUtyQTMvd3FVUTkwMkw0VXhWCnJMa1d5a2RZb09P
cGd4TUxkUXB6Z2NRT1RTV1BDdlAwVi9jVnNYY1dKaVZFRGg5VGp1SzBLc1loRm1XR2E2bmUKNHVS
MVY2VkJ5SUtaay9vRGthSVhCanJaU1ZUT1M2ZzZWRi9XaWhHKy9NL0MyZU94eEJZMzdqWm5xREpR
bjNxWApoWTJjVE4wbTlrTFFQdjJqUE9LcjAzUHIvbFdIV1Rpc1EzRkNWbG1ZUTBJSUcyRlpKSmNS
RGNELzhOOGpoMWVhCnpFQmowK1lSMitMUUxzVWN6bDBQSkM0TGV4eERTUVg4MlRlV21nUklXc3Mv
UTM2VUNIOVNyOFl6Sk9BSkxWWEYKNUJMQXgybFlVQWk4bmN0cjhIMmdML0RQOHlOT3hBZ05QSVhy
QjNnQk9XYTF4MmNROHNOeDMvVXVYZFIyNXQyYgo3eGpseFdlWmM5ejJnTzlyZUVKRWt6a21HVjhR
Sk1QSFAvejZRdTZIUVlqUFlyL3I0T1FSSGFpN1RMSkZsTFBNCkJLQTJGVWlZNzFaTUxZWHRXUms1
WG85SnVGL0F0dncwU3JxcFoyRE5PeUtLZmJzMTRNOS84RXkzUUFVTklTSXQKUDQyMlJNQUQxdzha
WGcxWlBqSEo4TGo3Qms3RTJGN0YzVlUwSXFCSVVsc1J5eUJvMUs3SDdRT1pwdmJFeERRSgpnMWx4
YlhhS1lrRFEwREdhb2FnT3pVYVo5ckxCdkpFNHo3QzBTZ3BjWFpaMHJuT3lkdm5GMGhCWG93djdX
YkYrCmk0WlB5REJjM242OHJxcz0KPTlTWGwKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0st
LS0tLQ==
--555c03b5285c6ef426ed57ee823b8febfc4cfbb03b7056604f8bc59a0e8e--

--------52cc4b944b3c16770ea46776d0beb1706030ab98695a5edfb73d0c327314159d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsGpBAEBCABdBYJpS8BXCZDbbuBxk4Cg6TUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnClxNvSea8Ztxt9NaU71bwhYhBBKM1nGLSON6
q6UFAttu4HGTgKDpAADaQRAAtwGWgQiGlE8PoJKnR/GKoRorEXMXDspZgPQs
TFmGqS+ndFaVNxPtOsGglhaOv8bKcpzuxCLvx4GhxpZIcbUvdL/33yomyESJ
8puzExVIyUPStxz5xEUL9OB0DN1ah5Ssxus8O33Xm3Wrz+8S3jblonoLMHAF
WVpISxh1fvrVe0wj9vBGMYMmAHrxzN5pz9vhMf4xlfYeR0F+yR7+TYMqWJCF
JqbDWaUMjkh9xSNskVK/9Fo0kR3ylLAWdpdypXBUo8LkKE7z04Fyu+DHugkK
REV/+BbscT8uH1KeBVkLzg7DyHPqVcpUgU8qm8dl1ymYvrBFeziY0JzKU4v1
Bg6bT2JfewE+giCoeiT+YVuICAGyyOg09rIE43GZRlW22Ve1cn/jNwIWcaJD
oa5rnDVGwgGhA6jcY+K3uy00n+NCZKU/qWClpxUbEoCrbZ0eM2oS+4yfhPyT
1I0VgvY+8HZ5FS/U1kG/N+vmTvKfqFn2kH7Ezd9sClr1wJiV5xzGLCXIzGk0
s0yQ+ek1tQ7Ks67BSuRLQDqC5boyERh4GtghJM1LRAbYBmf4okuYH3ByCG6A
7P1+cV31nhZFl1BmT10H/AFI/jvOFZHA93A7fy6VP8vU97bTtmJYG/t7P0Cu
nh69pFDsvkX9MqD2fuVESv5sUAHb8+ibmBZ8tiB1bS3XFxk=
=1mnd
-----END PGP SIGNATURE-----


--------52cc4b944b3c16770ea46776d0beb1706030ab98695a5edfb73d0c327314159d--

