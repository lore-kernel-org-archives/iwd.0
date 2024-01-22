Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371553A8CA
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917225; cv=none; b=ImBs7Q+hvHWC7dR7y6NjZbxZwQxW4ExvYJhux7EL9xfWMlPT4srtRJ+3j4X28912BLqcsTUBMKca/ZWR+etgQV59ExaghW2HmrAZnI9jRFD471NUsyBEJdzfuT8blfyZVsfoTRDFF+r8q3JWdEyqqvP+E3VCUSb7DbAAZuB7qcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917225; c=relaxed/simple;
	bh=mWPzbHzaPeBi7jT+dP6hGBOvx++IGskQgH+2QiiKsu0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=swsDTStiLwl+/tUkMhPsu+uKtNeN+NLkjAccGjKPG+bbynbgS8JLQgwQXh24aMPdU8c49FtGQ+mIRXLdcYLICBLCjn8HsH108L7T3SYMfB52rkgoJA6VqmQQd3gCS43Ft0jx2yAd2sAx8/smGnyDScFW4Zdo4Pscd7ru8tf3lZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=k3YnFMfH; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=Dn3scd06; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="k3YnFMfH";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="Dn3scd06"
Received: from workstation64.local (port-ip-88-150-49-16.reverse.mdcc-fun.de [88.150.49.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.archlinux.org (Postfix) with ESMTPSA id 9E29626EACF6
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1705916753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=q7U3dxnRbmBcfaq4o1W+12kP0z2u0t7+mleX9JJfrOE=;
	b=k3YnFMfHFDWfviwpyxLcfFWtWee9K7EUQGMXqK9m7tslJ0b2cqetH39QlnagpCc8n4kS5Z
	t6asrKxw55ifsD9+4E6Um1veTAFChMt9HUx6tM0XqbNhk7ZoSLre7hmcLfywnOlATFWBhB
	mzNTEP8PADHw4pyqgcfS1HOp69Y4wgSajNxSbm2EEhDOUVguBKs79wu4YdGsTSC0ZAXEKB
	sMAxtcjL44hZFDbv9qw8l/ydfZ4bDuscXJ11FCM7AJyYSJrzwq4NBOVQzP4X3s7kIwTPMn
	1osYsIWMhn4y538oHtvtsNGIP2YSZGWWfEd2RiF73m8PBmgaBoIa+IhA09fiQ95/BgAwfc
	0IJvh1SCBGKOn17PWFkVXbyYRZYJu0gzEU3oa5NFnaFl4Tqf/3giHoTHuihxwej+1MGaBU
	mzmtn5n283rZ7huHYpFUdhoofuo6Zd4CKXaZVYkEE6mvhMFaCPmGvvbIzmFRHmAWEqJNvL
	TBf3Vnpno5fQ3YUzAH8gKhFDdBgTSXtpJzw2NbocqxvftS/pk8COphZh09qP2daAf54GAI
	+J8Pknd/WGGUCKjBlO0ldqCYdiOkdvvxcFDWwAFNn+lazz9WqRlKOj3U7N9d50o/U1sY9e
	Cug1J3EoUrSlpzYebRfB3lzRr45/+0VTgS6adw2oZPZiVTmfKRH/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1705916753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=q7U3dxnRbmBcfaq4o1W+12kP0z2u0t7+mleX9JJfrOE=;
	b=Dn3scd06YoXpSjm/Q9Zm/7Neot6xbkepKe3ijC1A8Cqo3SQLwjL4NpdXS9hc9BfsQjjcSx
	AUv2xqrc98ER4IAA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=andyrtr smtp.mailfrom=andyrtr@archlinux.org
Date: Mon, 22 Jan 2024 10:45:41 +0100
From: Andreas Radke <andyrtr@archlinux.org>
To: iwd@lists.linux.dev
Subject: test failure with LTO still present
Message-ID: <20240122104541.74f1a697@workstation64.local>
Organization: ArchLinux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEXLVzlCOzajNBsxMDJ9Rjo7JB1CJx2jo6JhMh9CPj9gFBAcGRUvqpyyAAACVElEQVQ4jWXTvWvbQBQA8McRSMeqwtQhi/LQcHgTVwghi+sKIncrhRCSKZQY0S4pGNTgycK4D3UymUyXxhAQ5ymEJJD75/pOX1baNxjr/bj37t1JsFw47VjsVH9guKxzHWMeHGf5H5xx3phmKQwXTrH60DxofWvunNYKC7vmWXMYE/xTyjznxLE29y9g0TE5hhxzY3YasDvcfUxhi+Hjt7oLDMstnXgADJFeV7Xgqlj6sAIOrkba1GB7dB77sH3J5EdZA/ZIOjFAYgF8f/2pBbspwDYUIX7dVVAcUwp1iKgNx224b8Gp1wCGX1pw0oBA/6LVvA2ygu8Mr/NNKVGDvVrEFkSfSzjgH3zFUKGg4xL4Yrqe8ACz3GPa2opOS7C9PfQEH+wKMdOzSE+bYxcrEHyrGvXZCZG+aeYQwjbNUrg15jHOpg3YHiBzANLxBa02k/dFtd00o5l8AViBPwApN/AGK0A7uXQb6BKW2Z7HA+5twOny2PiHbQVIe0qp+vXpIs/GL8ogR5lNlaNcF5YVSJ1qOtVEcycIGnDQ6+XY07nOsxvXDRxXMbhcMQWpPUlZnmfnDmcUQ9EqFQJ1KrOvOZ3bFQwBQ6BSnkT0NLcgN7AJBQfKRmRBppyf81NRqoTBAAF79tuZOkWigdCeBtpKqgUHRyIc2GvHotIGnkIRsnCeZi+BxyAaoKT453UN75Q6DD3wiWKiEc3GNewr9fuHvXKaj0aj2TRJ3tfwdtK3nxLvaBSH0ThJxiUEyWS/eDVZZmE0STg+WDhKJk+XdoiwiAKSK/UXmpn5K/owqOUAAAAASUVORK5CYII=
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sQVVMMW.ttd_Ww9Gn4sp1vz";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/sQVVMMW.ttd_Ww9Gn4sp1vz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

When building the Arch Linux package with lto enabled we are still
getting this old failure here:

PASS: unit/test-eap-sim
  CC       unit/test-sae.o
  CCLD     unit/test-sae
/usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o: in function `sae_choose_next_g=
roup':
/usr/src/debug/iwd/iwd-2.13/src/sae.c:153:(.text+0xb9b): undefined referenc=
e to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o: in function `sae_rx_authentica=
te':
/usr/src/debug/iwd/iwd-2.13/src/sae.c:197:(.text+0x2e21): undefined referen=
ce to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o: in function `handshake_state_f=
ree':
/usr/src/debug/iwd/iwd-2.13/src/handshake.c:49:(.text+0x3455): undefined re=
ference to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o:/usr/src/debug/iwd/iwd-2.13/src=
/handshake.c:49:(.text+0x3491): undefined reference to `__wrap_l_ecc_suppor=
ted_ike_groups'
collect2: error: ld returned 1 exit status
make[3]: *** [Makefile:2279: unit/test-sae] Error 1
make[2]: *** [Makefile:3016: check-TESTS] Error 2
make[1]: *** [Makefile:3366: check-am] Error 2
make: *** [Makefile:3368: check] Error 2


This seems to be the same error reported to the iwd list here:
https://lore.kernel.org/iwd/c4b50311-84ab-236a-e3cd-49371a9d7eb4@gmail.com/=
T/#mbe4525effbbcde51a291ece026da1a25ecbfcbc4

and also Debian and Gentoo seems to be affected as well:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1015432
https://bugs.gentoo.org/877755

Is there any way to solve this other than to disable lto?

-Andy
Arch Linux

--Sig_/sQVVMMW.ttd_Ww9Gn4sp1vz
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmWuOUUACgkQlGV6sg8q
CSvqggf/f9lNYzaKhVMfQBnHpCjYiy82QzLbdo4quoH4NQosBS0dyWTAHbJWqAMn
pZ2trDb3z6Ej1oynjy1T78Q9l8bltmEnFbqAtP+Nht6ORTOV1S5TYFt8W1gaZH9i
BPUWgKkEXQm3v7f/4Io8FLpUcM2CcEGvEI9GoAWWZ3H8nUl4/JnojTQD3lYBnWVR
AaYrHivLD22kUonGXxztF/OIy0/JAz1Rv/Gar3vBR6rx8xoCIlKhhuS2jIvtJD0t
jx/io1Yc7x5JhYZOf/v54o5RViYTZUdYqfBWznfG85L8oIgCKOD+DP15O3RGX9hs
iEhFNRVTNSLBZIzza51O74R1Ysw2/A==
=noy9
-----END PGP SIGNATURE-----

--Sig_/sQVVMMW.ttd_Ww9Gn4sp1vz--
