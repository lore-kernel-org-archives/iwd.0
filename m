Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCF1D5CC6
	for <iwd@lists.linux.dev>; Thu, 25 Dec 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766687234; cv=none; b=aLeZYX3jlToJxEarZVJbavDOVoIA2Q3OSKFjns3DhvwD1tTsK4K6sNPsuq4nAS9KV1p9jXlhaYwxL9HkE3npi4qz196NnskyOSlpcVchG1PhUpq0Cka69RUA4xmkgW8bVACyZSTZ0LkfoNQM8qJrMeuRZXd0kMOxKuieA4fdzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766687234; c=relaxed/simple;
	bh=HbEKQ/j62SzWuC55Uld8mif7fBySDUfklSGKa89jaVY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=bFBFufQN+CjbeRrvujbm5vxodkBLBFEGjnZI8oEwHNuBQHE98Z3dlxqflb9PvFUpWQ4o0bCZJdlyBlBjhdpsIueo8rn8qhorI+q9CMm+8cq2H/l0pK0SQ8GfTJAZ0/ah5+Le93sVUtwmo0UaRA348PkvZ/thwpQ4yFiWKcD8GIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za; spf=pass smtp.mailfrom=deschouwer.co.za; dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b=TWajKij1; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b="TWajKij1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deschouwer.co.za;
	s=protonmail; t=1766687220; x=1766946420;
	bh=zJMg0edv6F8dDgUBW24XqyPA02h9Ahi5RNLpxN7T5zo=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TWajKij1I/CCHX69YkT9WyASlzfkuQ+9pvKEJYSHD4sWbnCOnPsnrFqzYyLfs8+7s
	 iWDGLDcxyMgGTnGB8+M++lAdckwbz3Mwl+mcJ2KtO05U5Sn3heLqWXELAK0q0E7Rnn
	 iy+7ADhw0wRmc5f3mpOPgctYuaU7BunyYZMPq/McVV2yhZzSQWN+i07jHeOtlG0Hu1
	 0FdcqZUw3k2Y4MsduuBE9d2z1PJEDdlnsCbxwfoCuXv+ZjxVRPhlRP637RmiAJF6I0
	 K+WjQ+/R9+MBTnfaP2TZmK+KC7l1Q8TzX+UFJFkMt4stLrmWkj73NVyGlDAsh02gKw
	 wdzpZBLgMNLxA==
Date: Thu, 25 Dec 2025 18:26:57 +0000
To: iwd@lists.linux.dev
From: berend <berend@deschouwer.co.za>
Subject: [PATCH] wiphy: check if ht_capabilities are actually set
Message-ID: <b22387f6f58e9be1af79a4585301fe64f83ced0d.camel@deschouwer.co.za>
Feedback-ID: 50941660:user:proton
X-Pm-Message-ID: 47db0bbd4c868ff80df55d98aa7a09a76bea17bc
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------03cd493543189675d4d5c15816a656d33867f9ff4a2a31ea22e85c5fd756e5a7"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------03cd493543189675d4d5c15816a656d33867f9ff4a2a31ea22e85c5fd756e5a7
Content-Type: multipart/mixed;
 boundary=d6738eca728535806165bf12b881ea087091d97fb902f07a2ea8ef3d3be6
Message-ID: <b22387f6f58e9be1af79a4585301fe64f83ced0d.camel@deschouwer.co.za>
Subject: [PATCH] wiphy: check if ht_capabilities are actually set
From: berend <berend@deschouwer.co.za>
To: iwd@lists.linux.dev
Date: Thu, 25 Dec 2025 20:26:41 +0200
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0

--d6738eca728535806165bf12b881ea087091d97fb902f07a2ea8ef3d3be6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

commit 928fba083c87147603702907940d7c263e62e4dd (HEAD -> master)
Author: Berend De Schouwer <berend@deschouwer.co.za>
Date:   Thu Dec 25 17:31:49 2025 +0200

    wiphy: check if ht_capabilities are actually set
   =20
    Some devices set HT, but only provide HT20.  When this is true,
    ap_validate_band_channel() will succeed with 40MHz width, but the
    device will refuse to start an AP.

diff --git a/src/wiphy.c b/src/wiphy.c
index b6774f69..85e31cf1 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1676,6 +1676,18 @@ static void parse_band_iftype_data(struct band
*band, struct l_genl_attr *ifdata
        }
 }
=20
+static bool parse_ht_capabilities(struct band *band)
+{
+       if (test_bit(band->ht_capabilities, 1))
+               return true;
+
+       if (test_bit(band->ht_capabilities, 6))
+               return true;
+
+       l_debug("no real 40 MHz found");
+       return false;
+}
+
 static void parse_supported_bands(struct wiphy *wiphy,
                                                struct l_genl_attr
*bands)
 {
@@ -1772,7 +1784,6 @@ static void parse_supported_bands(struct wiphy
*wiphy,
                                        continue;
=20
                                memcpy(band->ht_mcs_set, data, len);
-                               band->ht_supported =3D true;
                                break;
                        case NL80211_BAND_ATTR_HT_CAPA:
                                if (L_WARN_ON(len !=3D
@@ -1780,7 +1791,7 @@ static void parse_supported_bands(struct wiphy
*wiphy,
                                        continue;
=20
                                memcpy(band->ht_capabilities, data,
len);
-                               band->ht_supported =3D true;
+                               band->ht_supported =3D
parse_ht_capabilities(band);
                                break;
                        /*
                         * AMPDU factor/density are part of A-MPDU
Parameters,

--d6738eca728535806165bf12b881ea087091d97fb902f07a2ea8ef3d3be6
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
--d6738eca728535806165bf12b881ea087091d97fb902f07a2ea8ef3d3be6--

--------03cd493543189675d4d5c15816a656d33867f9ff4a2a31ea22e85c5fd756e5a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsGpBAEBCABdBYJpTYHvCZDbbuBxk4Cg6TUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnbInCLrujNOu4isZ++fzuFBYhBBKM1nGLSON6
q6UFAttu4HGTgKDpAADcTRAAll6KYySoYywsXOpvYk0kN2KK3+CBqaxKDQ1u
RmpORsJiQpAyiJPIz70pwzM1JweZAlA4Y3gOAutKoBFuL26eKHeloki4Shd/
vl2bkRSuXa9/gi5sFiwKsojD3s3Hw6Xr9QnLV21eSnSxOcCaMopYbbVnkdA5
vlsOIa24YFPqnceXW75YSiXV8DWSxyZFrKbdWn/Sfh2nq/1fs3MlJZduoqxG
xEFN23PeK8dLS+F2sjDlqWTbGXxe6bc2SQgyqWKM8MtwwFKtT1F3N00+qJ7+
LzTq2Cc0ouaqf5/erTLgtDUnsI/NsjVk2ZkK0selQ7KjP8dmImLOjPQvGppf
htLna0SIUB/ugkukvZw1o6YtK0+KbmfCBN9VJgvhWg4m5iN/7eiSMJxsQvul
qPIk2aycUrVBDHItFXaOTW6ncHb7TZdZ6cgpe/91fD8Orqy52mWHLMFaCnim
hOpzI97VU6l69SyIfVHqmli+VDG43FODULPRuefNh61iSs4UKPryQzCbc6IK
8RuivBZHWEVMVuUU/YqQWYM/hz/JTkFMQQ8KdsKIpnqEEjTAjySNE7le7fKb
tX1UXceXlaJOGSbP3/3aq3GuKzwEjynd754zeBYaoZfo1MwkkGq2ruLb3Kww
7A4tt60EAru4TWNfHO26AiorXb2sv/dgPHwxmQ2mbjczejU=
=VqWh
-----END PGP SIGNATURE-----


--------03cd493543189675d4d5c15816a656d33867f9ff4a2a31ea22e85c5fd756e5a7--

