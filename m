Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0125CC5F
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620108; cv=none; b=l6VL0w4pb0vFO2VAke1d0TwrBO2cRo+u/3XvGK2m4Uwdx7Q5R20+3PtxXhw1qLVJ3uEmSJ3mqg83quZ/05KJ8bJZ5x6yiXtVI7Z/2rrwpCNQxm3pDbymLM1IBzVO+vYYc2c4I9ZVWde+uftyXdx5X8gkJ/j7tx1zTmMfRWjA3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620108; c=relaxed/simple;
	bh=uD3aQan1o1cvmHpOdm738elty+LWpq1yAARm/Vd8j1w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fmxCUp71VGk+G+3BAL3kVTRcDp8uS9uSWnkq7ZVoa/rBX9KD1yaCkB3tUSTNp/42FdT8lJMJiOk6YT9e1x++H3depUSIjZl+fX63ZcBtcbtIKKrmiJ9EY76Uw9hJRSdeuaBLofibR82xevY4X073v8WVAKtZzhX+0uhYVK65Ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d2326.dip0.t-ipconnect.de [91.61.35.38])
	by mail.holtmann.org (Postfix) with ESMTPSA id 25028CECBE;
	Wed,  7 May 2025 14:14:57 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: test failure in 3.7
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9OF2RGVWEOB.2S5VRR2P1POI2@archlinux.org>
Date: Wed, 7 May 2025 14:14:46 +0200
Cc: James Prestwood <prestwoj@gmail.com>,
 Andreas Radke <andreas.radke@mailbox.org>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <29F1E51C-F624-48E3-B847-76D4A0B8A861@holtmann.org>
References: <D9NMMJZ63E59.YC0XX4QP9HYU@mailbox.org>
 <5595AB40-CF63-4118-8DFA-3FFEAA091F5D@holtmann.org>
 <4c9c290a-9c9c-4956-a5d1-b0eef0a7dcf2@gmail.com>
 <D9OAJCNF22SX.1K21DR8JE54M7@archlinux.org>
 <85F1CEAD-0674-4BC3-BF90-BAE7018991F2@holtmann.org>
 <D9OF2RGVWEOB.2S5VRR2P1POI2@archlinux.org>
To: Andreas Radke <andyrtr@archlinux.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Andreas,

> test-storage:
>=20
>  CC       unit/test-storage.o
>  CCLD     unit/test-storage
> FAIL: unit/test-storage 1 - /storage/profile encryption
>  CC       unit/test-client.o
>  CCLD     unit/test-client
> PASS: unit/test-client 1 - /Command/Find tokens
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Testsuite summary for iwd 3.7
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> # TOTAL: 231
> # PASS:  230
> # SKIP:  0
> # XFAIL: 0
> # FAIL:  1
> # XPASS: 0
> # ERROR: 0
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> See ./test-suite.log for debugging.
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> make[3]: *** [Makefile:3015: test-suite.log] Error 1
> make[2]: *** [Makefile:3150: check-TESTS] Error 2
> make[1]: *** [Makefile:3520: check-am] Error 2
> make: *** [Makefile:3522: check] Error 2
> =3D=3D> ERROR: A failure occurred in check().
>=20
> test-storage: unit/test-storage.c:41: test_short_encrypted_bytes: =
Assertion `__storage_decrypt(settings, "mySSID", &changed) < 0' failed.
> TAP version 12
> 1..1
> not ok 1 - /storage/profile encryption
> FAIL: unit/test-storage 1 - /storage/profile encryption

can you print out the return value from __storage_decrypt(). I made the =
upstream version check for the cipher support, but maybe this is =
something else in your chroot that makes this fail.

Is there something special about the chroot you are using. I really like =
to get this fixed if you are running make check on every build. It would =
be better to have the test cases pass or knowingly fail instead of just =
not running them at all.

> test-wsc:
>=20
>  CC       unit/test-wsc.o
>  CCLD     unit/test-wsc
> PASS: unit/test-wsc 1 - /wsc/iter/sanity-check
> PASS: unit/test-wsc 2 - /wsc/parse/beacon 1
> PASS: unit/test-wsc 3 - /wsc/parse/probe response 1
> PASS: unit/test-wsc 4 - /wsc/parse/probe request 1
> PASS: unit/test-wsc 5 - /wsc/build/probe request 1
> PASS: unit/test-wsc 6 - /wsc/pin/valid pin
> PASS: unit/test-wsc 7 - /wsc/pin/valid checksum
> PASS: unit/test-wsc 8 - /wsc/pin/generate
> PASS: unit/test-wsc 9 - /wsc/gen_uuid/1
> PASS: unit/test-wsc 10 - /wsc/parse/m1 1
> PASS: unit/test-wsc 11 - /wsc/parse/m1 2
> PASS: unit/test-wsc 12 - /wsc/build/m1 1
> PASS: unit/test-wsc 13 - /wsc/build/m1 2
> FAIL: unit/test-wsc 14 - /wsc/parse/m2 1
> FAIL: unit/test-wsc 15 - /wsc/parse/m2 2
> PASS: unit/test-wsc 16 - /wsc/build/m2 1
> PASS: unit/test-wsc 17 - /wsc/parse/m3 1
> PASS: unit/test-wsc 18 - /wsc/build/m3 1
> PASS: unit/test-wsc 19 - /wsc/parse/m4 1
> PASS: unit/test-wsc 20 - /wsc/build/m4 1
> PASS: unit/test-wsc 21 - /wsc/parse/m4 encrypted settings 1
> PASS: unit/test-wsc 22 - /wsc/build/m4 encrypted settings 1
> PASS: unit/test-wsc 23 - /wsc/parse/m5 1
> PASS: unit/test-wsc 24 - /wsc/build/m5 1
> PASS: unit/test-wsc 25 - /wsc/parse/m6 1
> PASS: unit/test-wsc 26 - /wsc/build/m6 1
> PASS: unit/test-wsc 27 - /wsc/parse/m6 encrypted settings 1
> PASS: unit/test-wsc 28 - /wsc/build/m6 encrypted settings 1
> PASS: unit/test-wsc 29 - /wsc/parse/m7 1
> PASS: unit/test-wsc 30 - /wsc/build/m7 1
> PASS: unit/test-wsc 31 - /wsc/parse/m8 1
> PASS: unit/test-wsc 32 - /wsc/build/m8 1
> PASS: unit/test-wsc 33 - /wsc/parse/m8 encrypted settings 1
> PASS: unit/test-wsc 34 - /wsc/build/m8 encrypted settings 1
> PASS: unit/test-wsc 35 - /wsc/parse/wsc_done 1
> PASS: unit/test-wsc 36 - /wsc/build/wsc_done 1
> FAIL: unit/test-wsc 37 - /wsc/diffie-hellman/generate pubkey 1
> FAIL: unit/test-wsc 38 - /wsc/diffie-hellman/generate pubkey 2
> FAIL: unit/test-wsc 39 - /wsc/handshake/PBC Handshake Test
> FAIL: unit/test-wsc 40 - /wsc/retransmission/no fragmentation
> FAIL: unit/test-wsc 41 - /wsc-r/handshake/PBC Handshake WPA2 =
passphrase test
> FAIL: unit/test-wsc 42 - /wsc-r/handshake/PBC Handshake WPA2 PSK test
> FAIL: unit/test-wsc 43 - /wsc-r/handshake/PBC Handshake Open test
> ...
> See ./test-suite.log for debugging.
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> make[3]: *** [Makefile:3022: test-suite.log] Error 1
> make[2]: *** [Makefile:3157: check-TESTS] Error 2
> make[1]: *** [Makefile:3527: check-am] Error 2
> make: *** [Makefile:3529: check] Error 2
> =3D=3D> ERROR: A failure occurred in check().
>=20
> FAIL: unit/test-wsc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> test-wsc: unit/test-wsc.c:1124: wsc_test_parse_m2: Assertion `prime' =
failed.
> test-wsc: unit/test-wsc.c:1124: wsc_test_parse_m2: Assertion `prime' =
failed.
> test-wsc: unit/test-wsc.c:551: wsc_test_dh_generate_pubkey: Assertion =
`generator' failed.
> test-wsc: unit/test-wsc.c:551: wsc_test_dh_generate_pubkey: Assertion =
`generator' failed.
> Error initializing EAP for ifindex 1
> test-wsc: unit/test-wsc.c:2062: wsc_test_pbc_handshake: Assertion =
`verify.response_sent' failed.
> Error initializing EAP for ifindex 1
> test-wsc: unit/test-wsc.c:2162: =
wsc_test_retransmission_no_fragmentation: Assertion =
`verify.response_sent' failed.
> Error initializing EAP for ifindex 2
> Error initializing EAP for ifindex 1
> stale eapol state machines found
> test-wsc: unit/test-wsc.c:2546: wsc_r_test_pbc_handshake: Assertion =
`wsc_data.sta_eap_failed && wsc_data.credentials_obtained' failed.
> Error initializing EAP for ifindex 2
> Error initializing EAP for ifindex 1
> stale eapol state machines found
> test-wsc: unit/test-wsc.c:2546: wsc_r_test_pbc_handshake: Assertion =
`wsc_data.sta_eap_failed && wsc_data.credentials_obtained' failed.
> Error initializing EAP for ifindex 2
> Error initializing EAP for ifindex 1
> stale eapol state machines found
> test-wsc: unit/test-wsc.c:2546: wsc_r_test_pbc_handshake: Assertion =
`wsc_data.sta_eap_failed && wsc_data.credentials_obtained' failed.
> TAP version 12
> 1..43
> ok 1 - /wsc/iter/sanity-check
> PASS: unit/test-wsc 1 - /wsc/iter/sanity-check
> ok 2 - /wsc/parse/beacon 1
> PASS: unit/test-wsc 2 - /wsc/parse/beacon 1
> ok 3 - /wsc/parse/probe response 1
> PASS: unit/test-wsc 3 - /wsc/parse/probe response 1
> ok 4 - /wsc/parse/probe request 1
> PASS: unit/test-wsc 4 - /wsc/parse/probe request 1
> ok 5 - /wsc/build/probe request 1
> PASS: unit/test-wsc 5 - /wsc/build/probe request 1
> ok 6 - /wsc/pin/valid pin
> PASS: unit/test-wsc 6 - /wsc/pin/valid pin
> ok 7 - /wsc/pin/valid checksum
> PASS: unit/test-wsc 7 - /wsc/pin/valid checksum
> ok 8 - /wsc/pin/generate
> PASS: unit/test-wsc 8 - /wsc/pin/generate
> ok 9 - /wsc/gen_uuid/1
> PASS: unit/test-wsc 9 - /wsc/gen_uuid/1
> ok 10 - /wsc/parse/m1 1
> PASS: unit/test-wsc 10 - /wsc/parse/m1 1
> ok 11 - /wsc/parse/m1 2
> PASS: unit/test-wsc 11 - /wsc/parse/m1 2
> ok 12 - /wsc/build/m1 1
> PASS: unit/test-wsc 12 - /wsc/build/m1 1
> ok 13 - /wsc/build/m1 2
> PASS: unit/test-wsc 13 - /wsc/build/m1 2
> not ok 14 - /wsc/parse/m2 1
> FAIL: unit/test-wsc 14 - /wsc/parse/m2 1
> not ok 15 - /wsc/parse/m2 2
> FAIL: unit/test-wsc 15 - /wsc/parse/m2 2
> ok 16 - /wsc/build/m2 1
> PASS: unit/test-wsc 16 - /wsc/build/m2 1
> ok 17 - /wsc/parse/m3 1
> PASS: unit/test-wsc 17 - /wsc/parse/m3 1
> ok 18 - /wsc/build/m3 1
> PASS: unit/test-wsc 18 - /wsc/build/m3 1
> ok 19 - /wsc/parse/m4 1
> PASS: unit/test-wsc 19 - /wsc/parse/m4 1
> ok 20 - /wsc/build/m4 1
> PASS: unit/test-wsc 20 - /wsc/build/m4 1
> ok 21 - /wsc/parse/m4 encrypted settings 1
> PASS: unit/test-wsc 21 - /wsc/parse/m4 encrypted settings 1
> ok 22 - /wsc/build/m4 encrypted settings 1
> PASS: unit/test-wsc 22 - /wsc/build/m4 encrypted settings 1
> ok 23 - /wsc/parse/m5 1
> PASS: unit/test-wsc 23 - /wsc/parse/m5 1
> ok 24 - /wsc/build/m5 1
> PASS: unit/test-wsc 24 - /wsc/build/m5 1
> ok 25 - /wsc/parse/m6 1
> PASS: unit/test-wsc 25 - /wsc/parse/m6 1
> ok 26 - /wsc/build/m6 1
> PASS: unit/test-wsc 26 - /wsc/build/m6 1
> ok 27 - /wsc/parse/m6 encrypted settings 1
> PASS: unit/test-wsc 27 - /wsc/parse/m6 encrypted settings 1
> ok 28 - /wsc/build/m6 encrypted settings 1
> PASS: unit/test-wsc 28 - /wsc/build/m6 encrypted settings 1
> ok 29 - /wsc/parse/m7 1
> PASS: unit/test-wsc 29 - /wsc/parse/m7 1
> ok 30 - /wsc/build/m7 1
> PASS: unit/test-wsc 30 - /wsc/build/m7 1
> ok 31 - /wsc/parse/m8 1
> PASS: unit/test-wsc 31 - /wsc/parse/m8 1
> ok 32 - /wsc/build/m8 1
> PASS: unit/test-wsc 32 - /wsc/build/m8 1
> ok 33 - /wsc/parse/m8 encrypted settings 1
> PASS: unit/test-wsc 33 - /wsc/parse/m8 encrypted settings 1
> ok 34 - /wsc/build/m8 encrypted settings 1
> PASS: unit/test-wsc 34 - /wsc/build/m8 encrypted settings 1
> ok 35 - /wsc/parse/wsc_done 1
> PASS: unit/test-wsc 35 - /wsc/parse/wsc_done 1
> ok 36 - /wsc/build/wsc_done 1
> PASS: unit/test-wsc 36 - /wsc/build/wsc_done 1
> not ok 37 - /wsc/diffie-hellman/generate pubkey 1
> FAIL: unit/test-wsc 37 - /wsc/diffie-hellman/generate pubkey 1
> not ok 38 - /wsc/diffie-hellman/generate pubkey 2
> FAIL: unit/test-wsc 38 - /wsc/diffie-hellman/generate pubkey 2
> not ok 39 - /wsc/handshake/PBC Handshake Test
> FAIL: unit/test-wsc 39 - /wsc/handshake/PBC Handshake Test
> not ok 40 - /wsc/retransmission/no fragmentation
> FAIL: unit/test-wsc 40 - /wsc/retransmission/no fragmentation
> not ok 41 - /wsc-r/handshake/PBC Handshake WPA2 passphrase test
> FAIL: unit/test-wsc 41 - /wsc-r/handshake/PBC Handshake WPA2 =
passphrase test
> not ok 42 - /wsc-r/handshake/PBC Handshake WPA2 PSK test
> FAIL: unit/test-wsc 42 - /wsc-r/handshake/PBC Handshake WPA2 PSK test
> not ok 43 - /wsc-r/handshake/PBC Handshake Open test
> FAIL: unit/test-wsc 43 - /wsc-r/handshake/PBC Handshake Open test
>=20
>=20
>=20
> Do you need anything else? What do you want me to show you from such =
chroot
> builds?

I wonder why they fail in your chroot. I released iwd-3.8 now with a few =
additions on how we run the test cases. I doubt it will fix all of =
these, but maybe we are a step closer to make sure to have the =
pre-conditions for a test right and if they are not met indicate this =
with not-supported.

On my Raspberry Pi 5 running Debian I have full coverage:

=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Testsuite summary for iwd 3.8
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# TOTAL: 280
# PASS:  280
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

On my PowerPC box I have not supported test cases due to an older =
kernel:

SKIP: unit/test-eapol 45 - EAPoL/8021x EAP-TLS & 4-Way Handshake # SKIP =
not-supported
SKIP: unit/test-eapol 46 - EAPoL/8021x EAP-TTLS+EAP-MD5 & 4-Way =
Handshake # SKIP not-supported
SKIP: unit/test-eapol 47 - EAPoL/8021x EAP NAK # SKIP not-supported
SKIP: unit/test-eapol 48 - EAPoL/8021x EAP-TLS subject name match # SKIP =
not-supported
SKIP: unit/test-eapol 49 - EAPoL/8021x EAP-TLS subject name mismatch # =
SKIP not-supported
SKIP: unit/test-eapol 50 - EAPoL/8021x EAP-TLS embedded certs # SKIP =
not-supported

=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Testsuite summary for iwd 3.8
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# TOTAL: 280
# PASS:  274
# SKIP:  6
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

As you see, they are now marked as not-supported instead of =
failure-allowed.

And on Fedora 42 on x86_64, I have actual failure that still need a bit =
of debugging:

FAIL: unit/test-eapol 45 - EAPoL/8021x EAP-TLS & 4-Way Handshake
FAIL: unit/test-eapol 46 - EAPoL/8021x EAP-TTLS+EAP-MD5 & 4-Way =
Handshake
PASS: unit/test-eapol 47 - EAPoL/8021x EAP NAK
FAIL: unit/test-eapol 48 - EAPoL/8021x EAP-TLS subject name match
PASS: unit/test-eapol 49 - EAPoL/8021x EAP-TLS subject name mismatch
FAIL: unit/test-eapol 50 - EAPoL/8021x EAP-TLS embedded certs

=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Testsuite summary for iwd 3.8
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# TOTAL: 280
# PASS:  276
# SKIP:  0
# XFAIL: 0
# FAIL:  4
# XPASS: 0
# ERROR: 0
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
See ./test-suite.log for debugging.
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

On a Fedora inside WSL2, I have more errors, but that is for another day =
since it is Microsoft specific kernel anyway.

Regards

Marcel

