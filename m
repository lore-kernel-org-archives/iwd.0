Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4131139AF6
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917199; cv=none; b=UjvzZtXvi+YOBA5USdWj3JAOMz4lWp+L1SdvCl5JLzzzDOm7mHaOdOCsyBFNltAzLB82gfdQnz/CjuTVBfucCB9bVssZ5nJeZNeZmLGL3G+CPb22pnjhL9PH6imM4UzbS365/SvUeWYL864qy2xJmjNpGrDdQRqXjQTzPRX9b5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917199; c=relaxed/simple;
	bh=ANg6nKsKilQ6ioj9/6hUUmyPdLHIPXGWOjnrPQnVqBc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=P6JXrd1/ggPPOxs9XkpCsDmh3Be79Ikla7ctsqbbG+4+EguBj+I8jy6YiyO1bh450n0zY4cDiS2kpFTzZIagIqIKil92F0HdeGKUT4jvs06VGeO/mFhVIpVkKV4KslMGiBdq08wshhBvMDnvFvjDUJ6023yhS4SXh1riGm/SeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=g3B93luC; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=xsj8JRqf; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="g3B93luC";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="xsj8JRqf"
Received: from workstation64.local (port-ip-88-150-49-16.reverse.mdcc-fun.de [88.150.49.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.archlinux.org (Postfix) with ESMTPSA id E462926EADC3
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1705917194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zZqEBl4WP2tQc+OfRU40WThAafBJvYIAAb1SiDtyahk=;
	b=g3B93luCncVuMwn0TKuiyh72oroe3NkAhlJ8KCRqhLv9yVBeSe9tGc17V1rj9E73RlW4L0
	MoFazBI844tFio7kGYfAD5QXrCghM5IlU6RgxKuJ38bLtXUIyglClZuScmEk3+apM1/ZN+
	mNHKiUkbQtoc5huDf3sH26lZ0s805xr/QiAkgdpVxguxp8/VOAovt1OvD7rZlzgMUWI4fu
	ZM1G1qkmOWIBfWldp0QXSCatH2LDrt9BvSYEp1gGjZJgKwy3T8NV5UDUQDIMqG4AzXSJzM
	rReWLGMvL3UhZ9lSPXGb4qFhUpX9ZYDbr5dYm2hpFYTI3YjiPnt5DMIoolUENmyqrjBWml
	Klap8uU8avSYNkN2TRKh+r3raD57XMNNb/7kp/dA+qUMxL5UTLw5V5OiE+HCWHrF14HvD5
	7VfNT2vcy2XVbs4rj+Fv1IobDXS5HxzqaElzbhtvSrCpWvy4nk2s2JJPF8Okf6MNJRO8LC
	+ssKfw/ZS0bVWE9rpX0wl9LlqNlRCn5BovOYZe9MZa/RKGZXJ7RDAbSN/FfpHsFrXK3EMA
	xxz0ZZJGLyUAbIpc035Tnr4V/+lF4vd5Rmx8xNPSya4pdVWe7O1yYPWnNbD/BzqnPNSIir
	P+PJ/cirxvTaneIkaFxSKa8lksSijJlr92jD3W56BMqXWpJxJvh7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1705917194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zZqEBl4WP2tQc+OfRU40WThAafBJvYIAAb1SiDtyahk=;
	b=xsj8JRqfMdy4vDa1R9IGrJWKeqf1bjyi7nv+8WZKQ9F7a8QWoy1sGOlnqVBgpERR9azQLW
	XHaQX4TDaVHQ41BQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=andyrtr smtp.mailfrom=andyrtr@archlinux.org
Date: Mon, 22 Jan 2024 10:53:12 +0100
From: Andreas Radke <andyrtr@archlinux.org>
To: iwd@lists.linux.dev
Subject: test failure in unit/test-wsc
Message-ID: <20240122105312.66fb4dbf@workstation64.local>
Organization: ArchLinux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEXLVzlCOzajNBsxMDJ9Rjo7JB1CJx2jo6JhMh9CPj9gFBAcGRUvqpyyAAACVElEQVQ4jWXTvWvbQBQA8McRSMeqwtQhi/LQcHgTVwghi+sKIncrhRCSKZQY0S4pGNTgycK4D3UymUyXxhAQ5ymEJJD75/pOX1baNxjr/bj37t1JsFw47VjsVH9guKxzHWMeHGf5H5xx3phmKQwXTrH60DxofWvunNYKC7vmWXMYE/xTyjznxLE29y9g0TE5hhxzY3YasDvcfUxhi+Hjt7oLDMstnXgADJFeV7Xgqlj6sAIOrkba1GB7dB77sH3J5EdZA/ZIOjFAYgF8f/2pBbspwDYUIX7dVVAcUwp1iKgNx224b8Gp1wCGX1pw0oBA/6LVvA2ygu8Mr/NNKVGDvVrEFkSfSzjgH3zFUKGg4xL4Yrqe8ACz3GPa2opOS7C9PfQEH+wKMdOzSE+bYxcrEHyrGvXZCZG+aeYQwjbNUrg15jHOpg3YHiBzANLxBa02k/dFtd00o5l8AViBPwApN/AGK0A7uXQb6BKW2Z7HA+5twOny2PiHbQVIe0qp+vXpIs/GL8ogR5lNlaNcF5YVSJ1qOtVEcycIGnDQ6+XY07nOsxvXDRxXMbhcMQWpPUlZnmfnDmcUQ9EqFQJ1KrOvOZ3bFQwBQ6BSnkT0NLcgN7AJBQfKRmRBppyf81NRqoTBAAF79tuZOkWigdCeBtpKqgUHRyIc2GvHotIGnkIRsnCeZi+BxyAaoKT453UN75Q6DD3wiWKiEc3GNewr9fuHvXKaj0aj2TRJ3tfwdtK3nxLvaBSH0ThJxiUEyWS/eDVZZmE0STg+WDhKJk+XdoiwiAKSK/UXmpn5K/owqOUAAAAASUVORK5CYII=
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K6HdN4uBj.UaWnUNfvBSDoy";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/K6HdN4uBj.UaWnUNfvBSDoy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Building the Arch Linux package with lto disabled in a=20
(fakeroot) chroot we see a test failure:=20

  CC       unit/test-wsc.o
  CCLD     unit/test-wsc
./build-aux/test-driver: line 112:  5539 Aborted                 (core dump=
ed) "$@" >> "$log_file" 2>&1
FAIL: unit/test-wsc

   iwd 2.13: ./test-suite.log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

# TOTAL: 22
# PASS:  21
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0

.. contents:: :depth: 2

FAIL: unit/test-wsc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

test-wsc: unit/test-wsc.c:1123: wsc_test_parse_m2: Assertion `prime' failed.
FAIL unit/test-wsc (exit status: 134)

gcc-Version 13.2.1

with clang 16.0.6 it reports:

FAIL: unit/test-wsc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

test-wsc: unit/test-wsc.c:1123: void wsc_test_parse_m2(const void *): Asser=
tion `prime' failed.
FAIL unit/test-wsc (exit status: 134)

Any idea how to solve this or is this one expected?

-Andy
Arch Linux

--Sig_/K6HdN4uBj.UaWnUNfvBSDoy
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmWuOwgACgkQlGV6sg8q
CSuaQQf+Ky7duYmRh6OZx0FdaXtf+aZKEtNRmF0RNbgxf/PTGLcyiwY/Crx7/eAA
1t8GPNIHe28kAHcfYmJsSQShZr2YC1oJKcoHKRYgSX+yK5ZPjSZJvTw4qi/XdrWz
Z9zReQrIYN8m6Hff4c0s7kc44U1mlZkimivLXQEMYXSvFinO6rokB2xo208I4HON
k25zfXhobxSiP5kDfNFzOKyo9Rvz4CKSAFBZXSLFP6Htn/ydsPJaisdM3QC4Lk55
xMMmOgWYWVw85su7XzPQ3NJ3H3c9fovsqWxH/mqeRCw6zlkJfYarTl3yo7wi6FWG
7X1Y5eMpN4LA3meSrGEmgN7y2MwF5Q==
=xO89
-----END PGP SIGNATURE-----

--Sig_/K6HdN4uBj.UaWnUNfvBSDoy--
