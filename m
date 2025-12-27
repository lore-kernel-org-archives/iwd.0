Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA364191F84
	for <iwd@lists.linux.dev>; Sat, 27 Dec 2025 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766810746; cv=none; b=r1GMrckVF3QuVbklw2THVmlfLin+JDMc1Ct7X82XayaIr2oEDxmtbzfQJyVxRNXwq63+z7n9Jf7uU97QEUJkYCvBTpifG+hmVZ+FXG3PXMtPH0i3yypDFBEWoNCB0O51TDbOOFtjLMNw+YckL37tbk5d6jwNVK0ODeoPuWxN+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766810746; c=relaxed/simple;
	bh=4nwAx1u90WX88B52ULL4LrPKZriqweZyWzx+ugWOZl4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cR6GKQ2rqCgaSWKH77sw3qKqHjoZ6LHpyoWA/R2BNKsNVCa+SSWnq15mroBbDjmWzO+FlVUUkQKa4oyxh3+AZ+Ot8Wkf3M5QBIOCmZM4YxWbUa9NzO70vuIaWB1sUzHyruIWHqWCBNxjNyofG9POM/ojpXWVTsfHdvO7wHDZbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za; spf=pass smtp.mailfrom=deschouwer.co.za; dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b=BKCpCZgc; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b="BKCpCZgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deschouwer.co.za;
	s=protonmail; t=1766810732; x=1767069932;
	bh=y+ZkcwP0P4yKWvsWJANT8gZm+XEKgi2gFsS7mMf96jg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BKCpCZgcJouRX9MwxgO3biGyIes5LK/xxaGi8EScSDzA/4AOuD1OGhj3QjvMN+waI
	 Krn2nshxJehg7lQOL0O5aiMhB8d+qjV1olRrfAGtPLLSVmasp8Fm0VJmH0dwMsAUXp
	 uRZWXnZ5LYQVJ99ozHFXwa6LVvS3j9onrq05l+HTvgQ3SiNTiQ01CYjJFgXQ69Fnv5
	 tt33NvcHC6ex8uFZA7MOGgNfAUrbmimT72l3GgQwKpS7VAz8LXsTsmzzfl0gs6T2Rn
	 gk2UX+cXFA7/6vdSaqaLMrilK9D03pVElH5ZRnCjJ5udZdn+DwQo35UmzxQri+xft/
	 oRIY+cIpMtzLw==
Date: Sat, 27 Dec 2025 04:45:27 +0000
To: iwd@lists.linux.dev
From: berend de schouwer <berend@deschouwer.co.za>
Cc: Berend De Schouwer <berend@deschouwer.co.za>
Subject: [PATCH] wiphy: check if ht_capabilities are actually set
Message-ID: <20251227044504.1234728-1-berend@deschouwer.co.za>
Feedback-ID: 50941660:user:proton
X-Pm-Message-ID: 4754b5be522099f734b8af0a5c9b7d3d130b1238
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------e5d11f4e3e2e2b0610cb119234419c4a2c1fcff916f61df30dc0c8aa70b5b89a"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e5d11f4e3e2e2b0610cb119234419c4a2c1fcff916f61df30dc0c8aa70b5b89a
Content-Type: multipart/mixed;
 boundary=1b8408bc96092f5baa8c84f4459d0c5ec84ce7cf2fcc703d798145ec5394
From: berend de schouwer <berend@deschouwer.co.za>
To: iwd@lists.linux.dev
Cc: Berend De Schouwer <berend@deschouwer.co.za>
Subject: [PATCH] wiphy: check if ht_capabilities are actually set
Date: Sat, 27 Dec 2025 06:45:04 +0200
Message-ID: <20251227044504.1234728-1-berend@deschouwer.co.za>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0

--1b8408bc96092f5baa8c84f4459d0c5ec84ce7cf2fcc703d798145ec5394
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Berend De Schouwer <berend@deschouwer.co.za>

Some devices set HT, but only provide HT20.  When this is true,
ap_validate_band_channel() will succeed with 40MHz width, but the
device will refuse to start an AP.

One such device is the brcmfmac on the Raspberry Pi 5 and
earlier.
---
 src/wiphy.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index b6774f69..85e31cf1 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1676,6 +1676,18 @@ static void parse_band_iftype_data(struct band *band, struct l_genl_attr *ifdata
 	}
 }
 
+static bool parse_ht_capabilities(struct band *band)
+{
+	if (test_bit(band->ht_capabilities, 1))
+		return true;
+
+	if (test_bit(band->ht_capabilities, 6))
+		return true;
+
+	l_debug("no real 40 MHz found");
+	return false;
+}
+
 static void parse_supported_bands(struct wiphy *wiphy,
 						struct l_genl_attr *bands)
 {
@@ -1772,7 +1784,6 @@ static void parse_suppo
rted_bands(struct wiphy *wiphy,
 					continue;
 
 				memcpy(band->ht_mcs_set, data, len);
-				band->ht_supported = true;
 				break;
 			case NL80211_BAND_ATTR_HT_CAPA:
 				if (L_WARN_ON(len !=
@@ -1780,7 +1791,7 @@ static void parse_supported_bands(struct wiphy *wiphy,
 					continue;
 
 				memcpy(band->ht_capabilities, data, len);
-				band->ht_supported = true;
+				band->ht_supported = parse_ht_capabilities(band);
 				break;
 			/*
 			 * AMPDU factor/density are part of A-MPDU Parameters,
-- 
2.52.0


--1b8408bc96092f5baa8c84f4459d0c5ec84ce7cf2fcc703d798145ec5394
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
--1b8408bc96092f5baa8c84f4459d0c5ec84ce7cf2fcc703d798145ec5394--

--------e5d11f4e3e2e2b0610cb119234419c4a2c1fcff916f61df30dc0c8aa70b5b89a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsGpBAEBCABdBYJpT2RmCZDbbuBxk4Cg6TUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3Jnlu++caGyNKNAT3AeP7/KhRYhBBKM1nGLSON6
q6UFAttu4HGTgKDpAABjmBAAuJflVHqgRgcEc38+0VnVHUDNEAWapc7Tpsno
VyT+fBL4HUo65lMrlgK+iVL3xEVhzDnHPftfrPP/Z8RAiLyutAuf/H9TUrOy
EGWy98Pg53D4/FOX2jARDqKA9qFyevksJqZFfBvguWs6pdOfH6CyWL1HwpzO
LknzXYgzDuJbZq9CcZ/C7gXJ/D7KS0VUQiCNN4zMRU5IvNuUotxjeUv1HaEW
1IYkMGq8PoaKoC6T4YmnRBKYsjwFH+f6VFEnhTsSnUa6OkPe/ZXCWI8PmLUf
0HgnQvHf3L75bdvjDGqK5cXuSlf3eiuQ41Q1vCuqMgsLy8y5R13hSBAe/jWY
fSbKAevQtptKR+NHqUXb3oS6o668X2RI0nWYDwadrt2jrMJLg7zYJq9upR5B
h4CtGCRnPDcjxq4H+zczMXtUcxTAzNdE5w+KDSUD13/K48zVjxw+DG8ZtnqT
xPA4zji2CbYfk9l9p9gcQthkk06iujUIxOvvBAk1AKD687W2Zb6cv4yBVhl0
SqRh/EA80mkeP5M+WvLzn/HutwtJ6SF3mGLtGP5dX8tvW3nASGCq78SvSUel
OUJ4CRc/6ClXV9a+2nTyM6pe6q25zMXE9Yg+7eZzExOMUlOHwVRLWr2HnAgI
/T4TH79QIibjhyyv0suwDBsSa3g3BcMf9Wm8s/2t9xY8Qdw=
=stg/
-----END PGP SIGNATURE-----


--------e5d11f4e3e2e2b0610cb119234419c4a2c1fcff916f61df30dc0c8aa70b5b89a--

