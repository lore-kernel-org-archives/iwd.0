Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848180BE3
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698347; cv=none; b=I0nf7qtHuhWwpZPsm236S5G+ARScEGa23IaZPSRPQTB/REZ/t9LbVV5onaI3DWycchYlhVGLRls9+9/xzmcqy5aDZ6Cnso0LnvkEJ7cYyanHj9r10g/4+c5CHDP55syEG3SJaw1MuadcSQ3oaZU/QTSrgV8EaAn0DCjunzTeyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698347; c=relaxed/simple;
	bh=mMy+BDFWjYtc3Vxbb+nI60L2ZL5jgcYyegeAK7NIAN0=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=l76T0K9PiPgPE6flWGzbyVz8D/P1+gsOliQXt2CMt7vceI73bspwdGI9kOUQbkoJfK/nemLUBBShrQDTR01FRT9x5rFpwMO5fSxC+wkxh4vikhhhSkpSa6f5Xm6eWfIzMG9b38zhKy4PUiL1huC1hpUMvtkRWNn69nVyQsu/XkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no; spf=pass smtp.mailfrom=yartys.no; dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b=L9zB5mVD; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yartys.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b="L9zB5mVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yartys.no;
	s=protonmail2; t=1708698341; x=1708957541;
	bh=mMy+BDFWjYtc3Vxbb+nI60L2ZL5jgcYyegeAK7NIAN0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L9zB5mVDSdA6DDqecfutuHI4bFFfPlyT0eA8s7ElmCFmNq2uMSrOpNApDXsRIRTjv
	 37F/fY6LCKJlkj2celYTi2KAxCZaLvkB+3MmKM2REgmehUoWBKajnlOfwDCik2iBR+
	 NwjZBDTXUI/Ayu0V/HDSgxLAO1Y9wVC3Qm+1nIZoRBkBg3ZSnlZe/YdP4OjLn9rOfv
	 STISVNuSZXmzIe0hmKWnm1J9LSL6iq8WYfRtR+otFYZZvG3KdXvSRSqy2Ani6SPAuj
	 kcp6qsSIfstrr3zB2QwGiWkn5wuOaw//Miqy6bsKoHPYVD48FD3B5uWcCH5BboGssh
	 ue0JM/E18KUIg==
Date: Fri, 23 Feb 2024 14:25:32 +0000
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Michael Yartys <mail@yartys.no>
Subject: Unable to connect to eduroam
Message-ID: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no>
Feedback-ID: 77365699:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I'm running iwd 2.14 on Fedora 39 Silverblue with kernel version 6.7.5-200.=
fc39.x86_64, and I've been having issues for the last two weeks or so conne=
cting to my university eduroam network. What happens is that I get an inter=
nal error that causes the connection attempt to fail with eapFail. Here's t=
he log output with TLS debugging enabled:

Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_tx_handshake:1244 Sending a =
TLS_CLIENT_HELLO of 140 bytes
Feb 23 14:35:55 localhost iwd[1233]: TTLS: l_tls_start:3610 New state TLS_H=
ANDSHAKE_WAIT_HELLO
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_handshake:3074 Handli=
ng a TLS_SERVER_HELLO of 45 bytes
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_server_hello:2419 Neg=
otiated TLS 1.2
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_server_hello:2455 Neg=
otiated TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_server_hello:2466 Neg=
otiated CompressionMethod.null
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_server_hello:2492 New=
 state TLS_HANDSHAKE_WAIT_CERTIFICATE
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_handshake:3074 Handli=
ng a TLS_CERTIFICATE of 2126 bytes
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_certificate:2562 Peer=
 certchain written to /tmp/iwd-tls-debug-server-cert.pem
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_handle_certificate:2673 Disc=
onnect desc=3Dinternal_error local-desc=3Dclose_notify reason=3DCan't l_key=
_get_info for peer public key
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_send_alert:1175 Sending a Fa=
tal Alert: internal_error
Feb 23 14:35:55 localhost iwd[1233]: TTLS: tls_reset_handshake:195 New stat=
e TLS_HANDSHAKE_WAIT_START
Feb 23 14:35:55 localhost iwd[1233]: TTLS: Tunnel has disconnected with ale=
rt: internal_error
Feb 23 14:35:56 localhost iwd[1233]: EAP completed with eapFail
Feb 23 14:35:56 localhost iwd[1233]: TTLS: tls_reset_handshake:195 New stat=
e TLS_HANDSHAKE_WAIT_START
Feb 23 14:35:56 localhost iwd[1233]: TTLS: tls_reset_handshake:195 New stat=
e TLS_HANDSHAKE_WAIT_START
Feb 23 14:35:56 localhost iwd[1233]: 4-Way handshake failed for ifindex: 4,=
 reason: 23


Here is the associated dumped peer certchain:

-----BEGIN CERTIFICATE-----
MIIExDCCBGugAwIBAgIRAM+MIw8HuugW44b38b8768QwCgYIKoZIzj0EAwIwRDEL
MAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxGjAYBgNVBAMT
EUdFQU5UIE9WIEVDQyBDQSA0MB4XDTI0MDIwNjAwMDAwMFoXDTI1MDIwNTIzNTk1
OVowWTELMAkGA1UEBhMCTk8xDTALBgNVBAgTBE9zbG8xHTAbBgNVBAoTFFVuaXZl
cnNpdGV0ZXQgaSBPc2xvMRwwGgYDVQQDExNyYWRpdXMtZWR1MDEudWlvLm5vMFkw
EwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAExF7Q2VsO6h0fciizxw+/4ptSYFo6gnUy
8hHvw766pf2B/fWKgG8BBXR2refZHibmSh3kF3tibYH4t4HULJp4xqOCAycwggMj
MB8GA1UdIwQYMBaAFO20oDNqGwiRtr36QZK9mqurY/RTMB0GA1UdDgQWBBTSHfh9
sY1lBcBLdLbTT+9zurmgLTAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/BAIwADAd
BgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwSQYDVR0gBEIwQDA0BgsrBgEE
AbIxAQICTzAlMCMGCCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28uY29tL0NQUzAI
BgZngQwBAgIwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL0dFQU5ULmNybC5zZWN0
aWdvLmNvbS9HRUFOVE9WRUNDQ0E0LmNybDB1BggrBgEFBQcBAQRpMGcwOgYIKwYB
BQUHMAKGLmh0dHA6Ly9HRUFOVC5jcnQuc2VjdGlnby5jb20vR0VBTlRPVkVDQ0NB
NC5jcnQwKQYIKwYBBQUHMAGGHWh0dHA6Ly9HRUFOVC5vY3NwLnNlY3RpZ28uY29t
MIIBfwYKKwYBBAHWeQIEAgSCAW8EggFrAWkAdwDPEVbu1S58r/OHW9lpLpvpGnFn
SrAX7KwB0lt3zsw7CAAAAY191L4wAAAEAwBIMEYCIQC6zqKLAVShWFlASZuktoGx
eddmBUZ5CR5gQxpjo01AIwIhANDuD6ZGlQeMi1wPMMrT+6nLL+JSb41/C2e+0CEj
ZUU/AHUAouMK5EXvva2bfjjtR2d3U9eCW4SU1yteGyzEuVCkR+cAAAGNfdS+8gAA
BAMARjBEAiAbl1nI5yax0AtxqxGrUud42ZdtNihV1mJZsoFESkGMJwIgSldsoiAw
qh5bZOCwGU74cOGA4MUmHtOzYsmH1GsK8g4AdwBOdaMnXJoQwzhbbNTfP1LrHfDg
jhuNacCx+mSxYpo53wAAAY191L5aAAAEAwBIMEYCIQDe23Hd8H0j3rpBcAMuOrj1
HO3DV8/irDdOtwsNWCFawAIhAK8Xrlq12GIfmyGfAATLb2qKfiAYpjxjU32zkrlS
zAWPMB4GA1UdEQQXMBWCE3JhZGl1cy1lZHUwMS51aW8ubm8wCgYIKoZIzj0EAwID
RwAwRAIgGbiOSzrozjf9HDKDQKcGPPVSlMz8CPE72GDkNn2adygCIGozGfF38Yqb
f01HpBCMJ2D/3F54kLeWevwEiecMULn1
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDeTCCAv+gAwIBAgIRAOuOgRlxKfSvZO+BSi9QzukwCgYIKoZIzj0EAwMwgYgx
CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJz
ZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQD
EyVVU0VSVHJ1c3QgRUNDIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTIwMDIx
ODAwMDAwMFoXDTMzMDUwMTIzNTk1OVowRDELMAkGA1UEBhMCTkwxGTAXBgNVBAoT
EEdFQU5UIFZlcmVuaWdpbmcxGjAYBgNVBAMTEUdFQU5UIE9WIEVDQyBDQSA0MFkw
EwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEXYkvGrfrMs2IwdI5+IwpEwPh+igW/BOW
etmOwP/ZIXC8fNeC3/ZYPAAMyRpFS0v3/c55FDTE2xbOUZ5zeVZYQqOCAYswggGH
MB8GA1UdIwQYMBaAFDrhCYbUzxnClnZ0SXbc4DXGY2OaMB0GA1UdDgQWBBTttKAz
ahsIkba9+kGSvZqrq2P0UzAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwOAYDVR0gBDEwLzAt
BgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFAG
A1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1
c3RFQ0NDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgw
PwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RF
Q0NBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRy
dXN0LmNvbTAKBggqhkjOPQQDAwNoADBlAjAfs9nsM0qaJGVu6DpWVy4qojiOpwV1
h/MWZ5GJxy6CKv3+RMB3STkaFh0+Hifbk24CMQDRf/ujXAQ1b4nFpZGaSIKldygc
dCDAxbAd9tlxcN/+J534CJDblzd/40REzGWwS5k=3D
-----END CERTIFICATE-----


I'm sure these certificates are correct because I was able to roll back to =
a working build on Fedora Silverblue to keep connecting to the network. Unf=
ortunately, I was dumb enough to forget to pin/freeze that working build to=
 prevent it from being replaced by new versions as I continually updated th=
e system.

I searched a bit around and found that some other folks had experienced the=
 same issue on Arch: https://bbs.archlinux.org/viewtopic.php?id=3D291921

That thread links to another thread about the deprecation of SHA-1 in the k=
ernel: https://bbs.archlinux.org/viewtopic.php?id=3D292208

rochus from the first thread was able to connect to their eduroam network w=
hen they tried a kernel with the offending commit reverted. Now, I know ver=
y little about certificates, but no certificates in my cert chain are SHA-1=
 signed, are they? Could this still be related to the issue I'm experiencin=
g?


Michael
