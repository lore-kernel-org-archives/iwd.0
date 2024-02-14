Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36217EF
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869617; cv=none; b=bYt+hbj8z4iQbOQbYE7hJDl3JlzEkcOePfJe+QVyLlvqVA/A9pz2abFwXe6MXj8PrvNe2tHDUVZ/fbr5KJE1uyAEW0bFfrblmA6wdadnbzQWddb/OVr35VVKqaY5dPI9apWZGQiyUnaDl9abbE5oTtmsTZw8J3MdhiiovHC4m3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869617; c=relaxed/simple;
	bh=ehIQrYH5+PgGYISMkBcXRYC21+R/IZoJhu27g7yf1UE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFw23bz/Bb0DrVjgIViQrVpJ9DxzZc8nTtZJAhfc7VhRatNI9bBORI0pkUjRQEhf2SI8bh2LVYmy+6j1kSQsEHL5DoeyLqVw33GlrZFOgvdQUqXsCtQBI/Rw4FlDZ60NURNWvKSqgV7YKvZE8ihmlRZ65qmFC2JFmK7T43Uuw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=eOW6ok5S; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="eOW6ok5S"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TZJZK3Rm7z9svV;
	Wed, 14 Feb 2024 01:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=MBO0001; t=1707869609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehIQrYH5+PgGYISMkBcXRYC21+R/IZoJhu27g7yf1UE=;
	b=eOW6ok5SxQYfIbyQFUby3Ndmoz9EBuC0NLhhUdwB0V/mSWwW6dbdIdX2+11oLT+vTx9Vmr
	7FZKq9x5Ub7XBEri16JHPTEgN77q77Hvf5tOYGWZxAhzWRP01XgBpjOwMMXXfRBJXoDknK
	MRaGdWyxtomyd5UDNWutgI8E+U/5ub/0WzsEO9wBQfr1CscxqnI+sxOproB/pAVzht9IFZ
	U1Q5UT9KFEuDtOwJA4fhzv9vdtlpcWqd6D8ze180MsOKhj0cDOCOFpjTcsoHdnmJa9UK7P
	zYnmZgDnrDFDrIR+Qc2uSkOnNGyWyN0vI0855CfeWqW7+IxJ41rLubcZDrjVjw==
Date: Tue, 13 Feb 2024 16:13:24 -0800
Message-ID: <20240213161324.GB1034@craftyguy.net>
From: Clayton Craft <clayton@craftyguy.net>
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
In-Reply-To: <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="cZmOY1+m5e2i7WXm"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4TZJZK3Rm7z9svV


--cZmOY1+m5e2i7WXm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

SGkgRGVuaXMsCgpPbiBUdWUsIDEzIEZlYiAyMDI0IDE3OjA5OjE5IC0wNjAwIERlbmlzIEtlbnpp
b3IgPGRlbmtlbnpAZ21haWwuY29tPiB3cm90ZToKPiBIbW0sIHdoeSBkaWQgbXVzbCBkbyB0aGF0
PyAgbWFuIDMgYmFzZW5hbWUgaW5kaWNhdGVzIHRoYXQgdGhlIGxpYmdlbi5oIHZlcnNpb24gCj4g
aW1wbGVtZW50YXRpb24gaXMgZnJlZSB0byBzY3JhdGNoIGluIHRoZSBpbnB1dCBhcmd1bWVudCwg
d2hpbGUgdGhlIHN0cmluZy5oIG9uZSAKPiBkb2Vzbid0LgoKRnJvbSB3aGF0IEkgY2FuIHRlbGws
IHRoZXkgYWRkZWQgaXQgaGVyZVsxXSB0byBhcHBlYXNlIGFwcHMgZXhwZWN0aW5nIHRoZSBHTlUK
bGliYyBzdHJpbmcuaDpiYXNlbmFtZSwgYW5kIHJlbW92ZWQgaXQgaGVyZVsyXSBiZWNhdXNlIEMy
MyBkcm9wcyBub24tcHJvdG8KZGVjbGFyYXRpb25zPwpBbHNvIEkgdGhpbmsgaXQncyBub3QgUE9T
SVggQyBjb21wbGlhbnQsIHNvIG1heWJlIHNvbWUgb2YgdGhlIG1vdGl2YXRpb24gZm9yCm11c2wg
dG8gZHJvcCBpdD8gSSdtIGp1c3Qgc3BlY3VsYXRpbmcgdGhvdWdoLi4uCgoxLiBodHRwczovL2dp
dC5tdXNsLWxpYmMub3JnL2NnaXQvbXVzbC9jb21taXQvP2lkPTA2YWVjOGQ3MTUyZGZiODM2MGNi
N2VkOWIzZDcyMTVjYTBiMGI1MDAKMi4gaHR0cHM6Ly9naXQubXVzbC1saWJjLm9yZy9jZ2l0L211
c2wvY29tbWl0Lz9pZD03MjVlMTdlZDZkZmY0ZDBjZDIyNDg3YmI2NDQ3MDg4MWU4NmE5MmU3Cgo+
IEluIHRoaXMgcGFydGljdWxhciBjYXNlIGl0IGRvZXNuJ3QgbWF0dGVyIHNpbmNlIGRyaXZlcl9w
YXRoIGlzIG5ldmVyIHVzZWQgYWdhaW4uIAo+ICAgU3RpbGwsIHRoZSBzdHJpbmcuaCB2ZXJzaW9u
IGlzIG11Y2ggbW9yZSBpbnR1aXRpdmUuCgpBaGggb2sgSSB1bmRlcnN0YW5kLCB0aGFua3MgZm9y
IGV4cGxhaW5pbmcgdGhlIGRpZmZlcmVuY2VzLgoKPiBNYXliZSB0aGlzIHNob3VsZCBiZSByZS1p
bXBsZW1lbnRlZCBpbiBtaXNzaW5nLmggb3IgZWxsIChzYXkgbF9maWxlX2Jhc2VuYW1lIG9yIAo+
IGxfZGlyX2Jhc2VuYW1lKSBpbnN0ZWFkPwoKSSdkIGRlZmVyIHRvIHknYWxsIG9uIHdoYXQgdGhl
IHJpZ2h0IHBhdGggZm9yd2FyZCBpcyBoZXJlLCBzaW5jZSBJJ20gcmVhbGx5IG5vdApmYW1pbGlh
ciB3aXRoIHRoZSBjb2RlIGJhc2UgaGVyZS4gSSdkIGxpa2UgdG8gc2VlIHRoaXMgZml4ZWQgc29t
ZWhvdywgc28gSSdtCmhhcHB5IHRvIHRyeSBpbXBsZW1lbnRpbmcgc29tZXRoaW5nIHlvdSByZWNv
bW1lbmQuCgotQ2xheXRvbgo=

--cZmOY1+m5e2i7WXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmXMBaQACgkQSkztbX7f
lQr71g//ZD7yyPiLzUBFjCvNfmyoVEAj9AhD1SuplC7RSn+0UEY4aUjuP2O8b+zl
LBGPRwaYoSBtSAZR/AlPEgGns+rZ5tNY9PKBKj4HsrewI2XLkIqz5kzn7U5vcZqX
D5TSSaLNVihaikk8afdNhPyBWvKCV0hs2o6XB4HUy4J1gnQRn3WFSmwCEq5wHrIu
Po37LueontjXAG0arZ5HC/z47E7hsXxVg8DtngUS4didscnl+9IJlbi2Zyv69WJc
m85GmPYN+L7f3hmmhUR6nhic1uv9co0gPN+c2EhysN3bn6sxKywiVY/TWHgjBZTE
0ju72G298ZgUMUjc/nsah+F38vLmhSYDHpVzAwFynwoEXZ1vKiu1EmMVbV+9r25a
Okq1UmCRZUA6ykFSuwcSJia5LRJ+KfVAOH3qD/yBtfp6CW/dDk/+EtmHKIFN0SvV
6IyWOLUCSu6jrHLf84xjr6Kh+A1peNLa5FTkd7g/4bwXP7OR7zc2XmySfwM5+eiv
03oIFSvO+CArQe0CwfWFi7bC7zqJfmrX9B3c0xPMhjeDmVXdr3GfUpkAyJUKXUQo
c/DGlpAurRcOB4LNrBDb8Qtt+8y+wyIT2RhEcv8u2PkAsmP9yRbXPYClb1fRXeNO
9RFPW3HjwMOCpmO8NA+lJbMC/F6+rMTHeV+IRwkPQzUsO4cJXtA=
=3O4C
-----END PGP SIGNATURE-----

--cZmOY1+m5e2i7WXm--
