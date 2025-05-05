Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714E1DEFFE
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467560; cv=none; b=GlmCnUixrfxqIZe0XiPx6LmsjnC/o7aE2y/Uxcp3AVu0NVqrD9IZ6X43ysdniMRF6gFtvHoS05O+rg1M7Wjz+Df5mCKgQ+4Svpl87ksN/V9bONZko88yy0a3Gy/2KLwBQXAKgjhXeryKYx7dgBkdnlwtUQnRLVQEZT15VswKTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467560; c=relaxed/simple;
	bh=47au5pK+OXhpMblER3cc5syjAhjkfc0JgVcXnHO/gQo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fln3ONljmE5SYUd7De4q0Z5mYqdk8sCuLis8G78DcSfZqZ7FRTWWLafwjEuUtc41lFgkvu3BkglPIAf5j7+zYD4cUyJtqkwNi++s4+tMZAxcxFuA1AHVYOU6eyfnbbzCbzeqjguC8RIxuZ6JTqlicRL8RzVMTae5vua7Ifkfifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=YXPMMhBL; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=G+vSbx7g; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="YXPMMhBL";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="G+vSbx7g"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1746467554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULbAx67KVPoI8cj82qsruyYmmQrfBg2Q/rSawypLjlo=;
	b=YXPMMhBLvwgCAUyJbL29+6j68i4nwqZ54tDhfURHH8HoWIrD2e4RKw4k0ob5MmCDkG5VbP
	F5cwF+7uXcuS9ZBdOv5uLBI1Bq/CnBC+PK9SMrtllgDRdWm8+mMtsbWGrwpQvD8SGCwgBp
	w4xR/XYroisMf43S9mm+SidDLhoc9I90BfzKC7d8LMDN3rFchAeZuhrupEO13SlB/KTQlT
	KX9QGJpef7Vf2nClcvamqTpMAxfuy5a371raoGdCLPX/qWbT+BxsFZ14/GpcQ3oMlBgfn8
	wogwb6b6oMk75zD13pl7wkPvTb52BBBxY1F4sN9yvaIRN1qxh7Jvv+FBQPxi+xkk3FQQ2c
	XdUthGRHyttoPnBwwvgPyYTVuxj1LwyeEU+c31Z+ZJLuQEBRZkBnOfoAfsgvAd7Aua260k
	qWYoSmyJ+oLX7rXq45YDPuPOCQL5A9Bd3FrsC/J6dYWmsLf2TBGDekk/64Sm4OVXdJzWt9
	gSmOqh72oQE2QJAwQd8CNErmDtxEoBMyg/9fGlwB5omSJ5yxRKFANMWEZJZkuObULGgdIR
	93wnqgAhmm07UE/C7TrGxBHQJ8/fj/ggCBHwijyOT25V5TITAddrHq+ZEDQJbFl1ich1YJ
	PU7UfYMyHCsoYyJuAdaOCNHbEJJSF+WISSkGzQo9/IpJ99cbxILxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1746467554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULbAx67KVPoI8cj82qsruyYmmQrfBg2Q/rSawypLjlo=;
	b=G+vSbx7gh8JM+eiViZJDXMlpz2MdJQXnpP8BNchRnJPJNY6SxWthUnpNcr6JNAdqF8X286
	3nMU0U8s3EbP3ABw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=andyrtr smtp.mailfrom=andyrtr@archlinux.org
Content-Type: multipart/signed;
 boundary=79a4056d2bc649075bbb79129101ce1787b09657f4404800f5741e5c7f30;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 05 May 2025 19:52:28 +0200
Message-Id: <D9OF2RGVWEOB.2S5VRR2P1POI2@archlinux.org>
To: "Marcel Holtmann" <marcel@holtmann.org>, "Andreas Radke"
 <andyrtr@archlinux.org>
Cc: "James Prestwood" <prestwoj@gmail.com>, "Andreas Radke"
 <andreas.radke@mailbox.org>, <iwd@lists.linux.dev>
Subject: Re: test failure in 3.7
From: "Andreas Radke" <andyrtr@archlinux.org>
X-Mailer: aerc 0.20.1.r64.g7cb8e0e7
References: <D9NMMJZ63E59.YC0XX4QP9HYU@mailbox.org>
 <5595AB40-CF63-4118-8DFA-3FFEAA091F5D@holtmann.org>
 <4c9c290a-9c9c-4956-a5d1-b0eef0a7dcf2@gmail.com>
 <D9OAJCNF22SX.1K21DR8JE54M7@archlinux.org>
 <85F1CEAD-0674-4BC3-BF90-BAE7018991F2@holtmann.org>
In-Reply-To: <85F1CEAD-0674-4BC3-BF90-BAE7018991F2@holtmann.org>

--79a4056d2bc649075bbb79129101ce1787b09657f4404800f5741e5c7f30
Content-Type: multipart/mixed;
 boundary=4d8ea24de760dfdae56331b0b7a757f1db74ce9348b54f1a8d01791e8c79

--4d8ea24de760dfdae56331b0b7a757f1db74ce9348b54f1a8d01791e8c79
Content-Type: multipart/alternative;
 boundary=2b6cd71ec2e8b8af90c15175c276c9370278f0f8841e9cb9e39549a0a405

--2b6cd71ec2e8b8af90c15175c276c9370278f0f8841e9cb9e39549a0a405
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

test-storage:

  CC       unit/test-storage.o
  CCLD     unit/test-storage
FAIL: unit/test-storage 1 - /storage/profile encryption
  CC       unit/test-client.o
  CCLD     unit/test-client
PASS: unit/test-client 1 - /Command/Find tokens
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Testsuite summary for iwd 3.7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# TOTAL: 231
# PASS:  230
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
See ./test-suite.log for debugging.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
make[3]: *** [Makefile:3015: test-suite.log] Error 1
make[2]: *** [Makefile:3150: check-TESTS] Error 2
make[1]: *** [Makefile:3520: check-am] Error 2
make: *** [Makefile:3522: check] Error 2
=3D=3D> ERROR: A failure occurred in check().

test-storage: unit/test-storage.c:41: test_short_encrypted_bytes: Assertion=
 `__storage_decrypt(settings, "mySSID", &changed) < 0' failed.
TAP version 12
1..1
not ok 1 - /storage/profile encryption
FAIL: unit/test-storage 1 - /storage/profile encryption




test-wsc:

  CC       unit/test-wsc.o
  CCLD     unit/test-wsc
PASS: unit/test-wsc 1 - /wsc/iter/sanity-check
PASS: unit/test-wsc 2 - /wsc/parse/beacon 1
PASS: unit/test-wsc 3 - /wsc/parse/probe response 1
PASS: unit/test-wsc 4 - /wsc/parse/probe request 1
PASS: unit/test-wsc 5 - /wsc/build/probe request 1
PASS: unit/test-wsc 6 - /wsc/pin/valid pin
PASS: unit/test-wsc 7 - /wsc/pin/valid checksum
PASS: unit/test-wsc 8 - /wsc/pin/generate
PASS: unit/test-wsc 9 - /wsc/gen_uuid/1
PASS: unit/test-wsc 10 - /wsc/parse/m1 1
PASS: unit/test-wsc 11 - /wsc/parse/m1 2
PASS: unit/test-wsc 12 - /wsc/build/m1 1
PASS: unit/test-wsc 13 - /wsc/build/m1 2
FAIL: unit/test-wsc 14 - /wsc/parse/m2 1
FAIL: unit/test-wsc 15 - /wsc/parse/m2 2
PASS: unit/test-wsc 16 - /wsc/build/m2 1
PASS: unit/test-wsc 17 - /wsc/parse/m3 1
PASS: unit/test-wsc 18 - /wsc/build/m3 1
PASS: unit/test-wsc 19 - /wsc/parse/m4 1
PASS: unit/test-wsc 20 - /wsc/build/m4 1
PASS: unit/test-wsc 21 - /wsc/parse/m4 encrypted settings 1
PASS: unit/test-wsc 22 - /wsc/build/m4 encrypted settings 1
PASS: unit/test-wsc 23 - /wsc/parse/m5 1
PASS: unit/test-wsc 24 - /wsc/build/m5 1
PASS: unit/test-wsc 25 - /wsc/parse/m6 1
PASS: unit/test-wsc 26 - /wsc/build/m6 1
PASS: unit/test-wsc 27 - /wsc/parse/m6 encrypted settings 1
PASS: unit/test-wsc 28 - /wsc/build/m6 encrypted settings 1
PASS: unit/test-wsc 29 - /wsc/parse/m7 1
PASS: unit/test-wsc 30 - /wsc/build/m7 1
PASS: unit/test-wsc 31 - /wsc/parse/m8 1
PASS: unit/test-wsc 32 - /wsc/build/m8 1
PASS: unit/test-wsc 33 - /wsc/parse/m8 encrypted settings 1
PASS: unit/test-wsc 34 - /wsc/build/m8 encrypted settings 1
PASS: unit/test-wsc 35 - /wsc/parse/wsc_done 1
PASS: unit/test-wsc 36 - /wsc/build/wsc_done 1
FAIL: unit/test-wsc 37 - /wsc/diffie-hellman/generate pubkey 1
FAIL: unit/test-wsc 38 - /wsc/diffie-hellman/generate pubkey 2
FAIL: unit/test-wsc 39 - /wsc/handshake/PBC Handshake Test
FAIL: unit/test-wsc 40 - /wsc/retransmission/no fragmentation
FAIL: unit/test-wsc 41 - /wsc-r/handshake/PBC Handshake WPA2 passphrase tes=
t
FAIL: unit/test-wsc 42 - /wsc-r/handshake/PBC Handshake WPA2 PSK test
FAIL: unit/test-wsc 43 - /wsc-r/handshake/PBC Handshake Open test
...
See ./test-suite.log for debugging.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
make[3]: *** [Makefile:3022: test-suite.log] Error 1
make[2]: *** [Makefile:3157: check-TESTS] Error 2
make[1]: *** [Makefile:3527: check-am] Error 2
make: *** [Makefile:3529: check] Error 2
=3D=3D> ERROR: A failure occurred in check().

FAIL: unit/test-wsc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

test-wsc: unit/test-wsc.c:1124: wsc_test_parse_m2: Assertion `prime' failed=
.
test-wsc: unit/test-wsc.c:1124: wsc_test_parse_m2: Assertion `prime' failed=
.
test-wsc: unit/test-wsc.c:551: wsc_test_dh_generate_pubkey: Assertion `gene=
rator' failed.
test-wsc: unit/test-wsc.c:551: wsc_test_dh_generate_pubkey: Assertion `gene=
rator' failed.
Error initializing EAP for ifindex 1
test-wsc: unit/test-wsc.c:2062: wsc_test_pbc_handshake: Assertion `verify.r=
esponse_sent' failed.
Error initializing EAP for ifindex 1
test-wsc: unit/test-wsc.c:2162: wsc_test_retransmission_no_fragmentation: A=
ssertion `verify.response_sent' failed.
Error initializing EAP for ifindex 2
Error initializing EAP for ifindex 1
stale eapol state machines found
test-wsc: unit/test-wsc.c:2546: wsc_r_test_pbc_handshake: Assertion `wsc_da=
ta.sta_eap_failed && wsc_data.credentials_obtained' failed.
Error initializing EAP for ifindex 2
Error initializing EAP for ifindex 1
stale eapol state machines found
test-wsc: unit/test-wsc.c:2546: wsc_r_test_pbc_handshake: Assertion `wsc_da=
ta.sta_eap_failed && wsc_data.credentials_obtained' failed.
Error initializing EAP for ifindex 2
Error initializing EAP for ifindex 1
stale eapol state machines found
test-wsc: unit/test-wsc.c:2546: wsc_r_test_pbc_handshake: Assertion `wsc_da=
ta.sta_eap_failed && wsc_data.credentials_obtained' failed.
TAP version 12
1..43
ok 1 - /wsc/iter/sanity-check
PASS: unit/test-wsc 1 - /wsc/iter/sanity-check
ok 2 - /wsc/parse/beacon 1
PASS: unit/test-wsc 2 - /wsc/parse/beacon 1
ok 3 - /wsc/parse/probe response 1
PASS: unit/test-wsc 3 - /wsc/parse/probe response 1
ok 4 - /wsc/parse/probe request 1
PASS: unit/test-wsc 4 - /wsc/parse/probe request 1
ok 5 - /wsc/build/probe request 1
PASS: unit/test-wsc 5 - /wsc/build/probe request 1
ok 6 - /wsc/pin/valid pin
PASS: unit/test-wsc 6 - /wsc/pin/valid pin
ok 7 - /wsc/pin/valid checksum
PASS: unit/test-wsc 7 - /wsc/pin/valid checksum
ok 8 - /wsc/pin/generate
PASS: unit/test-wsc 8 - /wsc/pin/generate
ok 9 - /wsc/gen_uuid/1
PASS: unit/test-wsc 9 - /wsc/gen_uuid/1
ok 10 - /wsc/parse/m1 1
PASS: unit/test-wsc 10 - /wsc/parse/m1 1
ok 11 - /wsc/parse/m1 2
PASS: unit/test-wsc 11 - /wsc/parse/m1 2
ok 12 - /wsc/build/m1 1
PASS: unit/test-wsc 12 - /wsc/build/m1 1
ok 13 - /wsc/build/m1 2
PASS: unit/test-wsc 13 - /wsc/build/m1 2
not ok 14 - /wsc/parse/m2 1
FAIL: unit/test-wsc 14 - /wsc/parse/m2 1
not ok 15 - /wsc/parse/m2 2
FAIL: unit/test-wsc 15 - /wsc/parse/m2 2
ok 16 - /wsc/build/m2 1
PASS: unit/test-wsc 16 - /wsc/build/m2 1
ok 17 - /wsc/parse/m3 1
PASS: unit/test-wsc 17 - /wsc/parse/m3 1
ok 18 - /wsc/build/m3 1
PASS: unit/test-wsc 18 - /wsc/build/m3 1
ok 19 - /wsc/parse/m4 1
PASS: unit/test-wsc 19 - /wsc/parse/m4 1
ok 20 - /wsc/build/m4 1
PASS: unit/test-wsc 20 - /wsc/build/m4 1
ok 21 - /wsc/parse/m4 encrypted settings 1
PASS: unit/test-wsc 21 - /wsc/parse/m4 encrypted settings 1
ok 22 - /wsc/build/m4 encrypted settings 1
PASS: unit/test-wsc 22 - /wsc/build/m4 encrypted settings 1
ok 23 - /wsc/parse/m5 1
PASS: unit/test-wsc 23 - /wsc/parse/m5 1
ok 24 - /wsc/build/m5 1
PASS: unit/test-wsc 24 - /wsc/build/m5 1
ok 25 - /wsc/parse/m6 1
PASS: unit/test-wsc 25 - /wsc/parse/m6 1
ok 26 - /wsc/build/m6 1
PASS: unit/test-wsc 26 - /wsc/build/m6 1
ok 27 - /wsc/parse/m6 encrypted settings 1
PASS: unit/test-wsc 27 - /wsc/parse/m6 encrypted settings 1
ok 28 - /wsc/build/m6 encrypted settings 1
PASS: unit/test-wsc 28 - /wsc/build/m6 encrypted settings 1
ok 29 - /wsc/parse/m7 1
PASS: unit/test-wsc 29 - /wsc/parse/m7 1
ok 30 - /wsc/build/m7 1
PASS: unit/test-wsc 30 - /wsc/build/m7 1
ok 31 - /wsc/parse/m8 1
PASS: unit/test-wsc 31 - /wsc/parse/m8 1
ok 32 - /wsc/build/m8 1
PASS: unit/test-wsc 32 - /wsc/build/m8 1
ok 33 - /wsc/parse/m8 encrypted settings 1
PASS: unit/test-wsc 33 - /wsc/parse/m8 encrypted settings 1
ok 34 - /wsc/build/m8 encrypted settings 1
PASS: unit/test-wsc 34 - /wsc/build/m8 encrypted settings 1
ok 35 - /wsc/parse/wsc_done 1
PASS: unit/test-wsc 35 - /wsc/parse/wsc_done 1
ok 36 - /wsc/build/wsc_done 1
PASS: unit/test-wsc 36 - /wsc/build/wsc_done 1
not ok 37 - /wsc/diffie-hellman/generate pubkey 1
FAIL: unit/test-wsc 37 - /wsc/diffie-hellman/generate pubkey 1
not ok 38 - /wsc/diffie-hellman/generate pubkey 2
FAIL: unit/test-wsc 38 - /wsc/diffie-hellman/generate pubkey 2
not ok 39 - /wsc/handshake/PBC Handshake Test
FAIL: unit/test-wsc 39 - /wsc/handshake/PBC Handshake Test
not ok 40 - /wsc/retransmission/no fragmentation
FAIL: unit/test-wsc 40 - /wsc/retransmission/no fragmentation
not ok 41 - /wsc-r/handshake/PBC Handshake WPA2 passphrase test
FAIL: unit/test-wsc 41 - /wsc-r/handshake/PBC Handshake WPA2 passphrase tes=
t
not ok 42 - /wsc-r/handshake/PBC Handshake WPA2 PSK test
FAIL: unit/test-wsc 42 - /wsc-r/handshake/PBC Handshake WPA2 PSK test
not ok 43 - /wsc-r/handshake/PBC Handshake Open test
FAIL: unit/test-wsc 43 - /wsc-r/handshake/PBC Handshake Open test



Do you need anything else? What do you want me to show you from such chroot
builds?

-Andy

--2b6cd71ec2e8b8af90c15175c276c9370278f0f8841e9cb9e39549a0a405--

--4d8ea24de760dfdae56331b0b7a757f1db74ce9348b54f1a8d01791e8c79
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=94657AB20F2A092B.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUVOQkUzT2Z5RUJDQUM3Wksz
S2FFWFhzN0d0aUZMQXA0UmdjaXJYRGRBS3p0Y1ZBcWt2QngvbnhBTGYxTWVICnZ0bFBIUmYvZDB5
WU1xSTZyMWI1U2V2Kzl3ckcvNEZWUmE3MkFkR2t0ZUZyQUxvazM5eHYxNTRYQ0locm90WnEKMDdF
byt4UWFRaE1TNlJvdFg3YVJVNDVjakp3c1YxUFhyRCs4dXhUQXN1ZkczcWRwUG5VUHBEQW5WMStm
VlZDYgowaUFXKzZNREtHZ2JhdFhIQzRLOE43bmVpeGlSeDJjcEplSkVROGRsZW85Rm03ZkRiNmc4
T3o0QjhqQ1RuUGJUCnB5VGFMR0E3TTR6YVR6TkhUelhNVU1hakxNRWpIT2RUdUU3elpoV3FOTXVX
d0lFOUJjY0RwOFNpeWJldjRuMUYKdDd2Q1NMOFVaWFNZNWljRGgzY0ZMVEJXbUdWV0paTlFuOXZW
QUJFQkFBRzBKVUZ1WkhKbFlYTWdVbUZrYTJVZwpQR0Z1WkhseWRISkFZWEpqYUd4cGJuVjRMbTl5
Wno2SkFaVUVFd0VJQUlrRmdtTEsvWXNFQ3drSUJ3a1FsR1Y2CnNnOHFDU3RIRkFBQUFBQUFIZ0Fn
YzJGc2RFQnViM1JoZEdsdmJuTXVjMlZ4ZFc5cFlTMXdaM0F1YjNKbmtRZWoKaHZLYm9PZ1ZDcWgv
OHV1cmxmVGVkeERtWGc2TDBvbmU5UUxqZFpzREZRZ0tCQllDQXdFQ0Y0QUNHUUVDR3dNQwpIZ0VX
SVFTdHlLSDh3VjRCMUZNUVFaNlVaWHF5RHlvSkt3QUF6MWtIL1IrdllMV2xhRlZZY3FaVHlGSWUw
aVFMClBXNkFlaDk5Q0h4K2tMYVlHMlZTelFpS2prQ0lnOVlDT0loWkd4ZllPR3VTbjFLanNzWEp5
d0tMTlNHZ0pDVVMKVVA1dlNoZFE2djJjbHRNd2RZSkVoakx5bzR3VDB5L09nYU1zMTR3ZUcwWThh
T2tvTUlVZWtlYjVSdWtyTnpyYgpBTmlvYmZadDY2NnRjb2NxZWwzK09qUlQ4dnl4WWJxREhyN2JM
dzZERkRKRThveEFCam5XZFZqaWdDYjRPUks2CnBrRzBMeThRZlUydi9OOHJEdFc1WndnUnJhRjY0
Z1NKcCtOM2JBRTNXOVhEcDdodWplMGhyMEpCNE1EcW80VGQKVWNiSCtzZ05jeXZPcnpUMDNmajhE
MTBPcWs3eXJnV2QxVUlxZlBZZUpUcWkwUW56TWFvemZnckI0K3QvbjJ5MApJRUZ1WkhKbFlYTWdV
bUZrYTJVZ1BHRXVjbUZrYTJWQVlYSmpiM0l1WkdVK2lRRTJCREFCQ0FBZ0ZpRUVyY2loCi9NRmVB
ZFJURUVHZWxHVjZzZzhxQ1NzRkFsd1kraFFDSFNBQUNna1FsR1Y2c2c4cUNTdTdLd2dBa240VFdy
Rm4KVit1NEVWWnV5ZXltd3YrOEZOQVg5TERhVHN3U2ZZSjMrSmNsVmxaUzBwWVIrN05IYTJJd3Js
YmdxaE9zQ1pxRwpHQVZWejBjVFlTbFdpRk56SjJkN2d3OUxBMXRMZTZhVTdwRHZ6UDgvOUFLVElq
NWN6MzZNMGt6ci9CR2hLNHZICllUNXpzOWZWTi9BQjYzNDE0Yy9EVW9UQlhCT3NyOXhoZnpHN0FO
T2NxdHFkc2JydkpJa2FzcW1ISk1uNU1MWlEKbVVwY2pRQzJGa2FLYkFab1FDRmFuRmpXZWNORkVI
c0Jwb1NQcmZyNzA3K3M3eCt5VWV0dzdrWnVaaW43MmN0dQpyc2JnQWpjSERCOVEzemJiUlpKU3JF
TXJ3N1QvZTlVVklhVmFNa3Y1TnF5ZHM0Yjc2ZlozNU9lVmoxaWViU2pEClUrVDNHRTEvdzRHWUdy
UWdRVzVrY21WaGN5QlNZV1JyWlNBOFlXNWtlWEpoWkd0bFFIZGxZaTVrWlQ2SkFUWUUKTUFFSUFD
QVdJUVN0eUtIOHdWNEIxRk1RUVo2VVpYcXlEeW9KS3dVQ1hCajZGQUlkSUFBS0NSQ1VaWHF5RHlv
SgpLMlc0Qi85bjlic2E3U0FnTmFKalllZ2w3MFZEQTBoRUIvb1BHQmUwTVZ1T2lhRXNUeC9rdjFG
VnJWQW44WUFMCldnYld5bi9RdXU1MUFKcURWUnVSejRTMnFrcmdoQUR0NXU1dTlqcTJ5Q1hNbDhV
aFpWYVVZUll2MTVFMG1rcUEKT3RLTWRkbHI4QjdnK0l5RzZRYmxiUUE1L1NhWWowSGd2a1JrS2dt
Y0hldUVaa3JQNTJCMkpJbDF2Zm5mdUJOTAplQ0VKOUVxU1JDS0FUYXJ4RmdyWDI4OFFLRWx0N1lE
ZWQ4WFJpZlhGbW4wdGMzNXhLN1R2SzNYTE9lRlF1ODZNCkVTOW9EbGlEd0RxdWc2cm5CQU5wNjB5
R05MMTN5SDh0QlhnTFpqRFFLMkY5NkMwWmtzQUduVVIrOU9KdlQ4MWgKeVR1UXJEdUQrM0xBWGc2
cmJBYUVqS0dHWkUwNHRDVkJibVJ5WldGeklGSmhaR3RsSUR4aGJtUnlaV0Z6TG5KaApaR3RsUUcx
aGFXd3VaR1UraVFFMkJEQUJDQUFnRmlFRXJjaWgvTUZlQWRSVEVFR2VsR1Y2c2c4cUNTc0ZBbHdZ
CitoUUNIU0FBQ2drUWxHVjZzZzhxQ1NzUnhRZjhDL21hNjV5U2ZvNkZKa1hIc3BDL1JNNmxLcFl6
dCs2WUpRMk8KRWFmZWxIeE93RHFrRE9CeTVZek9zNkxiMmRwT0czZmJteDl3ZnNsTjZDc1hyOThI
cGIrSXhLano0YTZWUWVkUQo5Si9lcDlzZEtUREtPMHRMeWhtbndzeEZDV0xmQSsvL3ozRUIwOEEw
R1ZIZ0RERG55NlVPeGhDRmxUWFRicDJGCmhjMTBSOTlQdUZTU3ZEVHBmNkh0VDV5UDNpOHV2MGhV
a1ptc0ZRMEp3dnMvUmJZTXEvUVppTkNFNm9oeGRrNkoKSmNaMFA0T3E5RWxxK0FrWks3aUZ2R3U4
UmFRWTVhYS9XSDJiMnhFcXNnUFJNYzYvR0NUZUNVamZNS3AzbTU1bgo1QU5wM3JmeDljbFJPRFVk
dVVYdWhaOE84WHFTaDBxWGc5bkJ5VEFnall0TzRhUThhclFvUVc1a2NtVmhjeUJTCllXUnJaU0E4
WVc1a2NtVmhjeTV5WVdSclpVQm1jbVZsYm1WMExtUmxQb2tCTmdRd0FRZ0FJQlloQkszSW9mekIK
WGdIVVV4QkJucFJsZXJJUEtna3JCUUpjR1BvVUFoMGdBQW9KRUpSbGVySVBLZ2tyYjFBSC9pZHdt
dlFMbmhsSgpJQUNVeW1uQnVmOEMyUm9HWDV6ZEdBSCtaVjV4VG5FL3NOK3RIQk1DYmJrQkxNKyth
VGVqWEpSMXZxamZjZkpVCncxT044M0N4alZyS29VYk04TS95UVBJU0Yxd3FONHdYOXduRlpqWU9o
THNhM2FkRGpMWDkxdTE1bGhFSjVyWVgKcWJ2NmlOYlB0WVlNb2F2blkyVlV4YVBNSnhFM1A3VmdT
eG01cW1rcjlWc2NTWGlSYVF3YVhuMC9vSUZuV0NwZgp1MnVkRDczVkhZRmZINlNsc09xOHRrWlAw
RkFqVXNraExPVlg1Yk9HV2RUV2VsVUFCcVAwdGE0eWhkWExrcmZUCk4yS1kvNVJZVlhrSUQzSkZL
dXZRbUtuSFE5TUV3OGc4V1dUZHNHM0JKOVhtMkNSMHNaL3RmbzhrYUZUekdlNjQKZU9pY3ZKK2F0
b3pSemZITjd3RVFBQUVCQUFBQUFBQUFBQUFBQUFBQS85ai80QUFRU2taSlJnQUJBUUFBQVFBQgpB
QUQvMndCREFBZ0dCZ2NHQlFnSEJ3Y0pDUWdLREJRTkRBc0xEQmtTRXc4VUhSb2ZIaDBhSEJ3Z0pD
NG5JQ0lzCkl4d2NLRGNwTERBeE5EUTBIeWM1UFRneVBDNHpOREwvMndCREFRa0pDUXdMREJnTkRS
Z3lJUndoTWpJeU1qSXkKTWpJeU1qSXlNakl5TWpJeU1qSXlNakl5TWpJeU1qSXlNakl5TWpJeU1q
SXlNakl5TWpJeU1qSXlNakwvd0FBUgpDQUNVQUhrREFTSUFBaEVCQXhFQi84UUFId0FBQVFVQkFR
RUJBUUVBQUFBQUFBQUFBQUVDQXdRRkJnY0lDUW9MCi84UUF0UkFBQWdFREF3SUVBd1VGQkFRQUFB
RjlBUUlEQUFRUkJSSWhNVUVHRTFGaEJ5SnhGREtCa2FFSUkwS3gKd1JWUzBmQWtNMkp5Z2drS0Zo
Y1lHUm9sSmljb0tTbzBOVFkzT0RrNlEwUkZSa2RJU1VwVFZGVldWMWhaV21OawpaV1puYUdscWMz
UjFkbmQ0ZVhxRGhJV0doNGlKaXBLVGxKV1dsNWlabXFLanBLV21wNmlwcXJLenRMVzJ0N2k1CnVz
TER4TVhHeDhqSnl0TFQxTlhXMTlqWjJ1SGk0K1RsNXVmbzZlcng4dlAwOWZiMytQbjYvOFFBSHdF
QUF3RUIKQVFFQkFRRUJBUUFBQUFBQUFBRUNBd1FGQmdjSUNRb0wvOFFBdFJFQUFnRUNCQVFEQkFj
RkJBUUFBUUozQUFFQwpBeEVFQlNFeEJoSkJVUWRoY1JNaU1vRUlGRUtSb2JIQkNTTXpVdkFWWW5M
UkNoWWtOT0VsOFJjWUdSb21KeWdwCktqVTJOemc1T2tORVJVWkhTRWxLVTFSVlZsZFlXVnBqWkdW
bVoyaHBhbk4wZFhaM2VIbDZnb09FaFlhSGlJbUsKa3BPVWxaYVhtSm1hb3FPa3BhYW5xS21xc3JP
MHRiYTN1TG02d3NQRXhjYkh5TW5LMHRQVTFkYlgyTm5hNHVQawo1ZWJuNk9ucTh2UDA5ZmIzK1Bu
Ni85b0FEQU1CQUFJUkF4RUFQd0R2ODBvNjAyZ0drVVNxYXVLZmxIMHFpcHE2CnArUWZTZ1F0Rk1t
bWpnaWFXWjFqalFaWm1PQUJYbC9pYjRxN0pIdE5BalZ5T0RjdU1qL2dJL3FhR3dQVGJpNnQKN1NN
eVhFMGNTRHF6c0FQMXJNSGlyUVMrd2F0YVovNjZpdkFidTYxVFZwalBmWE0wN24rK3hJSDRkcXJQ
WnlBWgpBL0tvNWlsQm4wekJkUVhLQjRKbzVVUGRHQkZTMTh5V2wxcU9uVENXeXVwb0hCNDJNUlhj
NkY4VnI2emtXRFhJCmZQaTZlY2d3NCtvNkdxVWhPTFI3RlJWTFROVnN0WXNrdTdDNFNhRnU2bmtl
eEhZMWRxaEMwVWxGQUJSUlNVQVUKRFJta0pwcE5JQ1ZUVnN5cEZibVNSZ3FLQ1dZOUFLb0tlYXdQ
RjkrOGtGdnBNRGZOTjg4dUQvQU8zNG4rVkp1eQpHbGQyT084WWVJTDN4TGNOYlc3TkZwcUg1VkhC
bFBxZjhLNTIxMGNBakM1OVRpdTh0OUpUWU9NOWhtclZyb2lxClNjRE9lNHJubFVPNm5RME9VaDBz
SWNCVDljVklOR0VqWSs2Q2MxMmk2WkVEOHlqUHRVcDB5QTg3Y2UxUnptL3MKZER6eVhRbFZnVlVr
NHJKMURTV01SWlZCOWhYcWoyQ0tQbEhTc3U3c0l5dVBMRkNtN2t5b3F4NWxvV3Y2aDRWMQpVVDJy
TjVaSUVzSlB5dVBRMTlBNkxyRnJybWx3MzlvK1k1QnlPNm51RDcxNGo0aDBRcHVtalhqdld0OEs5
ZE9uCjZ4SnBNekVRM1hLQW5wSVA4Ui9TdW1Fa3p6NmtIQm50RkZGRmFHWVVVVWxBR2NUU0U4VlIw
dlVsMVd6RnlpN1YKWWtBZHhnMUxkWGtGbkY1azhnUmM0R2U1cWJxMXd1VDdzZlN1TFc0T282eGMz
WndWM2VYSC91aml0aVhVNTVoTQpxUkNKQWhLbGpsengvZEhUOGF3OURUWmJSWjZrWk5aVGxvYjBG
ZVIwVnZIOG9IclY5SStnSGVxVUxBY0NyaVM0CjV3YTVqMDRrMGNJQnkzU3BURWhJeDBxRVhDWTVC
L0FValhwSXdxMGFGYWhOQUFPT2F5N3FBZ0hpcjdUTy9WUUIKN1ZETklwVEJ3RFNaTDBPYnZyVlpZ
SFIxR0NLNEZyWjdMVm9ybUw1WGpjTUNQVUd2U3JvREorbGNocWtLK2VTcQovTld0Tm5MWGpkSHNk
cGNDNnM0Ymhla2lCeCtJelU5YzU0SnVqYytGN1lOOTZJdEdmd1BINllyb3E2MGVlTFNVClVtYVlI
QWVETGp5Yks0aWtiQ3A4K1QySGVtNmRwODJxNmpOcVZ3N2lNdVRHQ2VpOXNWazZQZEM3bmF5Z08z
emcKb2Z0Z1p5UlhmUnhKQkNzYURDcU1DdVdnbTRLL1FtR3hYbGlpaHRwQWlnRGFRVGl1WjB3NGpR
RDB4WFRYakJiYQpRc1FGQ2trbnRYRDJsL0huRVhtU0tySExJTzJhMHFLNTAwSGFSMkVjME1ZRytS
UjdaclJ0L0psQTJ1dlB2WElUCjZyWlcwRFN6VzB2QXlTWEg5RFRiRFdudUZhVzB0WmZMUWdISnhq
SXlPdnFLdzVUdlZWTFJzN1NXMkF4aGdkeHEKVHk3VzNpSm1rR2ZRYzF5bG40bXVibVdTR0xUTHFW
b3lReHlvR2Z4Tk1pMUsrMUdKNVZSWU1GZ1VQek1NSEhOSApMYlV2blQwUjBEYWpDeDJ4UU0zdlZX
N0xGZHpKdEhhc0s1bXY3ZlREZVJ6Q1Z4SXF0Q295d1h1Y0FqTlIyOXpjCjNka2sxNXB5QjJKQlRC
M0tPeDV6VDVkTG1YdFBlNVM1SzZ1dWR3UEdDYzF5MnJYdHVqY09ISTQrWG5tclBpZlIKWjduVDdl
U3hoa0V2bkJTa1F4a0VkL2FxVWZod2FiRUE4aGtkajh5ay9LS2NWRmEzSW01dDJzZGg0SjFhQ3gw
WQp4WFFhTXZNV1VoZU1IRmQwckJsREtRUWVRUlhuTDI2UjIxdTZuOTJ2eThEb0s2enc5Y1NTVzBr
TEVzc1JBVnZ6CjQvU3RZVHZvVGlNSW9VMVVpemJ6U1pwT0tLMU9BOHMwR0dJZUlJWm8yTzVaV2hr
QjRQQ25HUlhjeVREZGhSa0EKNEpKd0s4dDFTWk5OOFhSWFZyY3JKRElBd2xSc2pQVG4xeC9oWGRX
L2lIUTQ0VWpYVTRTeWdBbkRmNFZuRFRRRQptV2RZUXo2UmVSQVpMd3NvQTl4WE0rR3JOVHBhQjEy
UDVZVWc5aU9QNlYwbHhlUlBZdE5CS2tpRWNNcHlEV05aCjNDTmNCbDREcnUvSHZVMUdkV0hzNzl5
eEhvYkdPYU9WUXlURERaN2luMitsMjJtV2JXMXFoU051WERPVHV4NjEKcG9IbEErWWo4YVM2aWln
dEpKSDVPUGxIcWF4NW5heDJxbXQyWStnNzQ0NVpXeUhrY3NjOWhuaW4yc1BrYXk4bwpCOHViTzdI
OEo5YXRhZFp5dGJGd0NSMU5NZEpvcGNxdWVlRFV0czFVVlpJMFlJQkRQdlB6WjV6Vm1ReFNObmFX
ClB1S2pzcjJPNXdzeWJHUEFJNlZla2lSSTg4WnFrN29UanFacytWVW5nZWxjMXFSeVd6MjVyb0x0
d3JFZGE1elUKdWplOVQxTTVhR2lHV0t6YUk1WkhVZ2J1M0ZkQjRjQ0xwdkI1TEhQOHE1d3BHbW5S
bFNUSmpMWlBYMnJmOE5vVgpzZDV6ODV6VzlKYWl4czdVVkh1Ym1hWFB0VGMwbWZyWFFlU1ZCNFMw
WlVDLzJYYWtMMDNLVGo4elR6b2xsYnIrCjVzcldQM1dKYTIrMVY1eDhwb3NLN09UdmJMenJuWTho
MmdaQzlCV0JlUUxaeW9JaHQybnA5ZjhBOVZkUGZNeVgKUTJqT1FheDlSaEVxRml2ekFaSDFxSnh1
aldsTGxaYXNiamZHdk5HcEF6SmdNQVY1SHBWWFN4a2dMMHFiVTh3SQo1SUpBN2dacmpiMXNlckdW
MFZiVzR2NGcwY1IzS1FlaHA4VVZ5UXJPejRiams4QTFTdDlZZ2lZN1ZZSHA4d1BOClhGMWFORUto
UzdIbkM4MVZpNG90d1Jxc0JRdGs1eUc5NnVSenUwWmpmN3k5YzFoeDZwTEpLQkhadGtudXdyb0wK
V015WVoxQ3NGNTVxWG9FbXpPdVFUSjByQTFSdVRYVFhRK2Mrd3JrZFhsekp0QnBMY3luc1FwcWsw
cXBBUUMzMwpkM3RYbytseCtUWVJMN1Y0TGVhcGVXR3F5ckZMalkrVkJBT0szTEg0bmEzYnVvbUZ2
UEd2QlVwdEovRVYyUWpaCkhuVnEwcDZTNkh0ZWFYbXVjOE5lTU5POFJ4N1ltTU4wQmxvSFBQMUhx
SzZEUCtjMVpnYk9PS2htWDVUVmpLQmMKbGhqNjFCTk5BcW5NcS9uVkFjWDRvdTVyQVJ5d1ozN3NI
QzU0cm5ENHBobVRGM0E0WmY0NDFKL01WMTJzeUxKSwpHVUFxTzdIRllVMHNLcVMrMEtmK0FqOWFY
UWFUSWRKdm9UTis3a0RJZVZQdFc3ZXNzc1l4L0VNR3ZQTDdYcmF6CnZBSTR3b1J1WHoxRmRQWmFy
RmRRSXdrQlZoa0d1S3BHenVqMEtGVFN6SExaR09RNFhqTldZWWlTUnRBQnFSV2EKWGhUajFxN0Rh
L0wycVUyZDBaTzI1RkhhckVPQUFhdlJ5aU5jWjV4VVlYYnUzVm5YV29JaEtxdzQ2MU5tWnprawpM
ZjNBUkdiTmNvNkdkbmtQYzRYODZ2WE03M1B5TGtMVDB0d05pZ2NEbXFXaGczekhtL2ltM2FMV3BI
d2RyQUhOClk2MTZQcW1tcGUzRWticUR1WGoyTmNkZjZIY1dpQ2FKV2toUHAxV3VxblVWck00cXRK
cHRvcDJWNVBZM2NkemIKeUdPYU5neXNPeHJ1ditGbzZsL3o2d2ZyWG55akpwL0ZhbUI3WTNpV0VI
ZDlubUI5QlA4QTRpb0x6eFpickQ5eQpSRDMzdUIrb3J6cXgxK2ZWN3FhSkVNVWFKdnl2SjZnYy9u
WFkyK2pXa0VvbGFQZWVDR2M3eWZ6NlZqRlZIdXpWCnVIUkdmZCtLYmllUVJRTEk3SG9GQi9tZWFM
YlNOWjFhWmZQZjdPakhxVHovQUkxV3VOZmcwV1M4Ullsa3VXdUcKMnIwd1Blc1M5OFg2cmRLUUpo
QXAvaGlHUDE2MWFqZmZVam1mUXY4QWpIdzlGbzhNYVIzSWxsZGh1eVJuOHF5dApDMU43U2Y3TXpu
eTIrN25zYXltbGVTUXU3Rm02a2s1cUxQT1FjSHRWT0thc0NrMDducTFqcTBxS1BsOHdBWTRJCkJ4
V24vd0FKQ1VIeTI4cFAwcmp0RGwrMjJrYmJzUGpCK3RkRkhwMDdEaGpYSzQyWjJ3cVN0b1dKdFl1
WlYyb24KbDUvaUo1L0txaXF4KzhTZjYxY1hTM1hCWWsxWmpzZ3ZYclVzZXIzSzF2YjU1WVk5QlY1
TGZBWmlLdTI5b1R5UgpnZHFubWlDSmdDcFpyRldPY2UyemVLY1VXMm5yTEJNcFVGUk00R2ZyV3dM
Yjk2RFhJK0pmRTZhWllUV05vLzhBCnBjc2ttNWdmOVd1NC9xYVNUazdJVTVLS3V6amZFb3MwMVY0
N05Wd25Ec09oYXNmSHVLQ1NUa25KTkorZGQ4VloKV1BOazd1NVowVU5iNnhkUnNHWE1UY0hqSXlE
WFZhdjR4a1hGdnA3Z1lVQnBkdlRqb0s0UzBhWkpIbjNuYzRLNQp6MXoxcWZPRTl6VEpIeVROTEsw
c2pGblk1SlBKTlI1SjVQZWtISjV6VHdwSjVCRkFDZ1lYUGMwekhOU25KcU1qClBwUUIwdmhTUXVK
b0ZPSFU3MC9yWG9tbWFtaGpFYzY3WEhmMXJ5alJicjdEcUtPZUEzeW12VTdIeTVWVnlvT1IKV0ZS
V1oxMFhkV05nRXpmZDZldUtzdzJ3RGNESjlhZGF2R3FBQlIwcTRDQ0F6SGFvNVBhc21kQ0VTSUFa
Tkk2QgpqeVBwUmRYVnZhUUdlNW1TS01EbG5iQXJ6enhKOFIwQ3ZiYUxrazhHNFlkUDkwZjFOQ2c1
YkNsVVVkelQ4VytLCnJmUW9tdHJWbGt2bUhUcUkvYysvdFhrVTB6M0V6eXlNV2R6dVludWFKcHBK
NVdsa2RuZGpsbUp5U2FpcnBoVFUKRWNWU3E1c1drNXBWR1d5VFM0OTYwTWlMR0NCMkZPYnFQcFJS
UUFCMlZzcXhVOGpJcXI5cGxWaXVjZ2V0RkZBQwppUjVUOHpuOEtuRVlBNnQrZEZGSUIvbXVwSE83
L2U1cjAzd2JjeVhPbUF5bkpSdG9QdFJSV2RYNFRhaDhSMTVrCk1FSlpWVWtldjByajcveDFxMXZM
SkhHbHFBcHdDWXlmNjBVVmlrZE1teml0WTF2VU5adVRMZTNEU0VmZFVjS3YKMEZaUm9vcnFTME9L
VHV4cE5BSEdhS0taSTdOTnlhS0tFQi8vMllrQlRnUVRBUW9BT0FJYkF3VUxDUWdIQWdZVgpDQWtL
Q3dJRUZnSURBUUllQVFJWGdCWWhCSzNJb2Z6QlhnSFVVeEJCbnBSbGVySVBLZ2tyQlFKaXl2aCtB
QW9KCkVKUmxlcklQS2drcjZZb0gvMU10OUs3OWdIZDlvVVpITzJ1alNtaHFra1ZvNjJ4RHNPclNu
L3A2YndaalJybWwKK3A0T3ZSTGp3UGlYODNmeW8xcU14LzZsODNFeXNBTHlLd1FMT3FLZE9CbVJw
Nmc0dlZGenYyaXRjZjgrU2pkSAp0endYM2pnV25nZUlYUFlWSjh1QkRKTlg0am5DMmRrcmtGUnRC
eVVsa0dBaEo0QmpHRVRjeXcyMTUyMlhpSjdCCllyeVBHcm5pREVBa3hQbkhiRVdETUZ2YnF3bDAr
VzZmU0o3OFgxVEF5Y3IrV2hDZkwxSFJjdndzemJ0MlRBR1MKa0pRSlRraFVrdWd3bTdzWldkTFFZ
UjN0eFlNVDAxL2ZHeDdHa0hYZ0RTVy82Q01WdCtlMGhBZDZVcnM3MmpCUwovT3Rodksyc1NiTjJw
ZjN3VVdVYTVsbzZJa2UxeGpEeWZrNWgvaU8wS1VGdVpISmxZWE1nVW1Ga2EyVWdQR0Z1ClpISmxZ
WE11Y21Ga2EyVkFiV0ZwYkdKdmVDNXZjbWMraVFGT0JCTUJDZ0E0QWhzREJRc0pDQWNDQmhVS0NR
Z0wKQWdRV0FnTUJBaDRCQWhlQUZpRUVyY2loL01GZUFkUlRFRUdlbEdWNnNnOHFDU3NGQW1MSytI
NEFDZ2tRbEdWNgpzZzhxQ1Nzb1NRZi9iRHFGa3pVUlo5SjJBeDVjMENHSGQ1TUFGYmdYdWdmRm9t
a0NEY29zV2RsTWZJb2QyVkdpClNYYXhvYzhpZFFyZjhoMmt4OHBNMVdRalJFcllma01kUUExK1hL
Q1JZU2tjVHVvdFl0aEtFYzc4dXY4TlkvdjgKdGI5Z0E0NXdPZWFOUUF5cUxSeTZzMERweEJHSFFn
ZE1mTUREa0IrbVVBN0xMYVZjTzNaNGszK3RFTzhBbUZxRwpVSDVkTENpYVc2aTgrNXJ1TFZQM2lL
ZktoRTcvRTE2amFPcEFxZ1o1cVo2REZIY0w2aE5GU0gwL3loeGJhblAxCjRJSkZ2YjNyZVlZUXAw
eDNrOVMyMGRhSHpsN2JaM09tRUU5SmU5UlE5aGVxdnJlSTg1U2NSam1ySFU0K0xPRnQKK0Zwa3g4
ZmhNY1NGUWNxeWRON2pCQ3FKeVJQOFJ4cXNiYlFqUVc1a2NtVmhjeUJTWVdSclpTQThZVzVrZVhK
MApja0J0WVdsc1ltOTRMbTl5Wno2SkFVNEVFd0VLQURnQ0d3TUZDd2tJQndJR0ZRZ0pDZ3NDQkJZ
Q0F3RUNIZ0VDCkY0QVdJUVN0eUtIOHdWNEIxRk1RUVo2VVpYcXlEeW9KS3dVQ1lzcjRmZ0FLQ1JD
VVpYcXlEeW9KSzgydUIvOTcKd0UxM0hRWHZkZzQ4ejd0MGN4SG5vS2VaNUZaTnZaU250RlFkVkVP
dmRoVFRrRGo3ZGNZTmtDcjZ1YklxSDQvRApoS3l0ajJlNlFydDY5TFBMWFhjU0JGazVPNGdZd3N4
amRPQTgrZU4zUGJMSFNHZmhYN0hPYTFZRm5oa1lWS1k0Cm9RUURCK3dUZ0JtN0I2WmowTFJTT3Ru
SzQzL203dlgxd1RUeVNyZVhqTTFodXJjYnQ2YjJXVzdJQ1pFVDIrZjcKQTQ1WU5jQkNodGVrSXFn
MVp4QTAxSG5BczNxU3RkS3RDL0xyWkdPRTllRHNQMVJwdnRxdXlVTXpXL01JSGZXUgpVL3NDbEVo
MXZGQkFob1lTRGZLRFpxcnRTc0lJbzVyV1JYaWdUYnJYOUZKem5aMkR4d3RZTGJzVUx6T2F2bUt3
CjBLODJiMTlqWFRqNnFQcVNhK2dpdVFFTkJFM09meUVCQ0FDakFRcmVFdUZ0OUhoYkJrT1BUU1RS
RlRuZU1uNTYKL1pFazZSZGFuTnRybmZITXlQTmNndituTHBONFkxU0NGd0RxdmZ0MjRyRjhXbGow
SXlXZURPZy9IaTY1d056RQpKUHprUVFQRUg5LzVmcmRmV0FnbkNtZThOMDhKRHlZYk1VaytjTGU3
QW9seWozREEzMVlYV1ppc2UzZDdvY3dhCm53dEV2em5xcXYxYTVoOGtBSTNxSERDMDBxd2x3L1hi
cjlnQW1QZTIvVXNnMHNudnZGVDRUMURqaTZoTTBzbEkKRDNFWkpweW85Q1BlZVV4RUJhWm85cTAw
Vk11S1dvRmkyQzZiWVNwOUdrNkxwTU5NMW5hVlN1eVhKRjFsekR6Zwp2RkxtYkhyNlExc1c0MEFu
L3d5TncrNkFNV2h6ZzFaODVIbE1ObHRFc0J1Wis3SytrY0Q0b2t3REFCRUJBQUdKCkFYNEVHQUVJ
QUhJRmdtTEsvWXdKRUpSbGVySVBLZ2tyUnhRQUFBQUFBQjRBSUhOaGJIUkFibTkwWVhScGIyNXoK
TG5ObGNYVnZhV0V0Y0dkd0xtOXlaOEZxRlJKd04xTEFHSEtpK3RsRndUSlgzQWJOOGN0UzhBMXZP
Wmp1MUxuQwpBaHNNRmlFRXJjaWgvTUZlQWRSVEVFR2VsR1Y2c2c4cUNTc0FBQm1oQi80b0hUaW5j
cnIwZzZwTy9CUUVPeldICkhFY1krQ2lvbThWTDRRemw1cVhjV1MwdzRRT1VEbXVZVFRPOC9mQnpS
SVlmZXZsNW9tRVI1YlovaHBDem8wRGQKRWc2N1luTGc5TjZNdGhxU0YzNHZYZVNZbTJsMWZBNnE5
TW03THE4SzFkV2FZUGdkd0lwR2IxK05yenFlTXQ3dwptb1E4N1JFWE5acVFWMktSc2tyZC9WRUpL
bmRjYlVGK1liN2VPcFJwSVR5VkF2K3RpbExrWGFRQ3N2STFReWlnCkpGbThFYnJIRWlnTlhyendL
MXhiSzA2MFN4TVJKZ1VWQ2p2cTVlcXRib3pkY1B5N29tNUxkUUN2VkpsSUw4V0cKazNNbE1ockNH
T3pVL2JvNDBhOGE3OUtSUHo0VU1qcmVtZFQyOEZTZThtd214L1dndlYyZEhNL0wyWmJiMzZKTwo9
VUV4MwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
--4d8ea24de760dfdae56331b0b7a757f1db74ce9348b54f1a8d01791e8c79--

--79a4056d2bc649075bbb79129101ce1787b09657f4404800f5741e5c7f30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFKBAABCgA0FiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmgY+twWHGFuZHlydHJA
YXJjaGxpbnV4Lm9yZwAKCRCUZXqyDyoJK27VCACMqw05WJ3kWf+4p+usznOdmFIs
F6TaHpspgLGby3GFl1pvO44bd5yzJ0kZoZ6RxfaoKaURvJa6S0nVyXuQ8VFsJIuT
G76MuhY2idCxJAT9Aw/ni+zWAmpuD4uixeyvQOYQXDODA59yt7uhvtkNX8E4byhz
WUMg8GOw4AjEIP6eAAtpnbGwS0bDO0523CEU2J/e9Oo0yq+GebZ4ZiIGYpg8K6z2
XQ7UW4gcArfUwK76+t9V6UA1+j7P7HTML4Eu6qkcLxN5VpV7c5t7GRDPahNTSi8V
DtrUVmSA4llvORzTqUEePInp7dapbUcW09GHJgMbh+lAwKR3TnNRcgf8YctN
=0jPn
-----END PGP SIGNATURE-----

--79a4056d2bc649075bbb79129101ce1787b09657f4404800f5741e5c7f30--
