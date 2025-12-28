Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC702189B84
	for <iwd@lists.linux.dev>; Sun, 28 Dec 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941454; cv=none; b=P08nF1tF9uymDMPHpJJpQl2mXSQkHAA4K+22zdaQfbIdP+RKOHXdi7IsZvcZB9Oj1Alts7jYpz328T4jbudfeuWQEc8IFBJ04+AlH1DX6TfBwO5FknWvcS1hRsgVNDLXRVKJuh+7sBCoDqi8qBkFao2a8v2jQDjoPKdO8W9QZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941454; c=relaxed/simple;
	bh=A3H5W/II7w8+YQiMmZQAe8Cu31Vtc7cUQFp02Dw7kDE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siSjyg2T5W9NBkcGaLxh1uN5/sKGd1QgcXVjfB/DuVOV+CwqfF+TkbkXSlUWM3GtBiFK/Cq2KSCxUKklnYvc/oeBP+qaFf9QGvpZzFLJOGHNdIV8lgl38y/kUT4YY6NJov8PBdRmjOubezOr6xGEIwfnKiNF62Dc4tnjHZm3USE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za; spf=pass smtp.mailfrom=deschouwer.co.za; dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b=ELYGzDn3; arc=none smtp.client-ip=185.70.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b="ELYGzDn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deschouwer.co.za;
	s=protonmail2; t=1766941439; x=1767200639;
	bh=WpSz0mjA9Gz3ELoD3p4L2qDjoZvBtzTmNq0WkDcnaS0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ELYGzDn3PbkZPNap/6f82Brs6wI6zrJ3dikLbMIyF9OGguOl86HV+uIvIbjjIfWBd
	 8zNhnnOvEC8HMV7P8ej5jIhp+zVXm/4/upBEZnMT24MniLA4jjgU9SRTqR5wEijfNe
	 rc00vUg1NliIkeOnm82jgiHU6ZJDj+9/A4cHXg8njZKBP4/CJauO24ilPWuco4Zzk/
	 sNueLZTFV2Fxmx2k4idNs1QtfOTVJqqv2OlEZC11+Bb/ufXkAvmZHjsBppk67adxU4
	 r8TFjoNFeZg4Q8Z6XE367kbnOIizjlqZaTfMh4A525XoiJdw4jk62yfoE7YyN+iFvL
	 KNC2fGKXD3NMQ==
Date: Sun, 28 Dec 2025 17:03:54 +0000
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: berend <berend@deschouwer.co.za>
Cc: iwd@lists.linux.dev
Subject: Re: [PATCH] wiphy: check if ht_capabilities are actually set
Message-ID: <37b819e0b8f7e5fdde4cd52f68f77342bd3b6cf5.camel@deschouwer.co.za>
In-Reply-To: <18db27c8c9a13c52c98f01c1c242b2b80812fca0.camel@deschouwer.co.za>
References: <b22387f6f58e9be1af79a4585301fe64f83ced0d.camel@deschouwer.co.za> <113d74f9-b051-49eb-96c8-799caa1ec8c6@molgen.mpg.de> <18db27c8c9a13c52c98f01c1c242b2b80812fca0.camel@deschouwer.co.za>
Feedback-ID: 50941660:user:proton
X-Pm-Message-ID: 8e509b282b0446545296e846d5aa650454ceba8d
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------3f6ad8ceaf357e0100b1f2fc7cbc50973a2789e1331b1b00e4dfc9b2cf48dc71"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------3f6ad8ceaf357e0100b1f2fc7cbc50973a2789e1331b1b00e4dfc9b2cf48dc71
Content-Type: multipart/mixed;
 boundary=d9ba332fb3743463c78cbf554718cdc27dd9f6003f3ce53e3c5a385f583a
Message-ID: <37b819e0b8f7e5fdde4cd52f68f77342bd3b6cf5.camel@deschouwer.co.za>
Subject: Re: [PATCH] wiphy: check if ht_capabilities are actually set
From: berend <berend@deschouwer.co.za>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: iwd@lists.linux.dev
Date: Sun, 28 Dec 2025 19:03:37 +0200
In-Reply-To: <18db27c8c9a13c52c98f01c1c242b2b80812fca0.camel@deschouwer.co.za>
References: 
	<b22387f6f58e9be1af79a4585301fe64f83ced0d.camel@deschouwer.co.za>
	 <113d74f9-b051-49eb-96c8-799caa1ec8c6@molgen.mpg.de>
	 <vEpbtzswJeknC8Jkfs6YiP2udZgdkXL6Dy_NNCIMDP8iqbaEF8ifRea2xgMCsmsIAPedr_h1tMKvsHoZW9Lr4g==@protonmail.internalid>
	 <18db27c8c9a13c52c98f01c1c242b2b80812fca0.camel@deschouwer.co.za>
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0

--d9ba332fb3743463c78cbf554718cdc27dd9f6003f3ce53e3c5a385f583a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Apologies.

Please ignore this patch.

There is another trigger at play than firmware version.  Sometimes, but
not always, HT40 is included in the report, but it never works.  Likely
related, once the driver is instructed to use HT40, scanning stops
working.

I'm working on a better solution.


Berend

--d9ba332fb3743463c78cbf554718cdc27dd9f6003f3ce53e3c5a385f583a
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
--d9ba332fb3743463c78cbf554718cdc27dd9f6003f3ce53e3c5a385f583a--

--------3f6ad8ceaf357e0100b1f2fc7cbc50973a2789e1331b1b00e4dfc9b2cf48dc71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsGpBAEBCABdBYJpUWL3CZDbbuBxk4Cg6TUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnHF5/dLQdERPVvJ8qJxNo1xYhBBKM1nGLSON6
q6UFAttu4HGTgKDpAADTGA/+KJ07iDCPYw+P3QclTENOwdpplUEWjZkLodsI
ES4uabMVDR2g7UDBX10fh/Fo9fxKuMGC2pU7/HLDKCG8CfnrdgmBC0ahUxoo
zXQcTHyaAM1kxIMIYimwTAzn1aQKWtrSShyA+krFfmbW2zdVi1Gcktc44oZJ
hay6M464nrocnybsYsBZ0E5fZLwQL1nJQ/4lz7cOJgYgCITTCATjSOl7pEuB
sVsrFzU7Fs9dvoidmz7s7Oa+ujryZv08up82zgYsQUQ4ru3WzCgDPiqmVavb
83hdzLwl7HaIoLglj4id31pqoNr0QHrMszSuaeJXxs4CLlWBSG3LALGzeWwd
TqbY9z9cc7pS+pjKqDkgGnnvwqy27nsRbhdbMhNxTfpzeayUx7XFCwRr7R9q
QEv9M8cGJ7kxGw3ede3QHyh+NKYEbfTry+618ZAhMEdzxQylFPicRw5kWwKx
XeuROIUnnS23lM+TT9TA5wzhLTBOlUN8h15eLPSFxjWJsRTWJSN0DuufDsLF
9YzOQjasx1Q/Z0qYd6tS0IT9M5/qckQKb0LORt/SLz04qr5/1f7GPaIHDf8b
xhcuaQyNlYPWejpH87Y9hmuEp5flljhb23ScllyZahtyGdeJaNcJPhkcLEZE
rDQY9pyGHzs/fjFwq6D1pD5bK35GR4AE3dg8Ijj9dgqluZE=
=1CW0
-----END PGP SIGNATURE-----


--------3f6ad8ceaf357e0100b1f2fc7cbc50973a2789e1331b1b00e4dfc9b2cf48dc71--

