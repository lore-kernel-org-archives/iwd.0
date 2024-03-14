Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30323625
	for <iwd@lists.linux.dev>; Thu, 14 Mar 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455469; cv=none; b=Pvb0AhRYlTNhBgjgsLFVonHjNQGFzGQZtuhK3ziX8ZZ3ArKtcfccb5P+32iHoPMBv6J4la5iRCZ8UqGSgOhcmMu/ZdkNRdpZ0B83xolSAccWePcpNDW+W5BYEXGaHp9uaAXlQZW0N/NwtDW2dtuHbBgSL4pnwJLbsreVtexxlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455469; c=relaxed/simple;
	bh=UxDuiat/U3ej6CWiSkptS04phThba/zG4ZCXBo0cmSg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z26t6L0t5/VcCDilq+vcJT5VROf/WstD7SZK7siEZaJbRwsbaFlJf0WMChIUqkm6MNQwD4RFvyRvO57KPOY/C9bQQAQlvBnjP0TAeUCnGOjtz7zjOnU0rRoZB3AheXIQTnJxJ03YO0Eng8bnrHnt/pDXCeu8I5ebxiJrnRhsZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=Glf8Yry5; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="Glf8Yry5"
Date: Thu, 14 Mar 2024 15:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1710455461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxDuiat/U3ej6CWiSkptS04phThba/zG4ZCXBo0cmSg=;
	b=Glf8Yry5gBmsR6nWxfG6HhyYcntRkf9nhFM21rS+FavBHmoV49ciOxOEtC4hVkT0+eqc4t
	2Jip/2MSiTXNuBhIr+1pI3G3FdJ75A3Bjw26UT+Dun+NmDZnimE+pvjaEWMQTjMZnc84yU
	6G2Ak3Av/uQ5vY1gJrEL81q4tOIgCS7D/jJYzGxUJi9p5TJWF93wl7gZ81T58Yz8o1xfu/
	07FGFsLOBz+LQ09q866DMVNM9jztFNDYxJ6miro1cT8iOrojslCsNLoPmKlbr1guzF1PXL
	TsA6jukq5E/QRL6UCgb/yvFpWmgr8nNikX0UjcKylTDEyIIA9Q6Wmyajy6d2RQ==
Message-ID: <20240314153055.GB8925@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
In-Reply-To: <440488C8-0481-4A8F-BF68-A7F97FAADC8C@holtmann.org>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
 <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
 <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
 <a64273d2-e585-4e48-a35a-38384b79202c@gmail.com>
 <440488C8-0481-4A8F-BF68-A7F97FAADC8C@holtmann.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="lQPg6FrFMOggoGv4"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--lQPg6FrFMOggoGv4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

T24gV2VkLCAxNCBGZWIgMjAyNCAxNzo1Mjo0MyArMDEwMCBNYXJjZWwgSG9sdG1hbm4gPG1hcmNl
bEBob2x0bWFubi5vcmc+IHdyb3RlOgo+IEhpIERlbmlzLAo+IAo+ID4+Pj4gQWRkIGEgX2dldF9k
cml2ZXIgaXMgYSBnb29kIGlkZWEgYXMgd2VsbCwgYnV0IHdoYXQgaXMgdGhlIHJlYXNvbiBmb3Ig
bF9zeXNjdGwgc2luY2Ugc3lzY3RsIGlzIHNvbWUgc3BlY2lmaWMgc3lzdGVtIGNhbGwuCj4gPj4+
IAo+ID4+PiBsX3N5c2N0bCBpcyB1c2VkIHRvIHdyaXRlIHN0dWZmIGludG8gcHJvY2ZzIG9yIHN5
c2ZzLiAgTmFtaW5nIGNvbWVzIGZyb20gdGhlIHN5c2N0bCg4KSB1dGlsaXR5Lgo+ID4+IGFjdHVh
bGx5IG5vLiBzeXNjdGwganVzdCBoYW5kbGVzIC9wcm9jL3N5cy8uIEl0IGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggc3lzZnMuCj4gPiAKPiA+IFlvdSdyZSByaWdodCBhYm91dCBzeXNjdGwuICBlbGwg
dXNlZCB0aGUgc2FtZSBuYW1pbmcgc2luY2UgaXQgd2FzIG1lYW50IHRvIGNvbnRyb2wgbmV0L2lw
dioga2VybmVsIHBhcmFtZXRlcnMuICBIb3dldmVyLCB0aGUgc2FtZSBBUEkgY2FuIGJlIHVzZWQg
aW5zaWRlIHN5c2ZzIHNpbmNlIHRoZSBzZW1hbnRpY3MgYXJlIGlkZW50aWNhbC4KPiA+IAo+ID4g
SWYgeW91IGRvbid0IGxpa2UgbF9zeXNjdGxfZ2V0X2RyaXZlciwgdGhlbiBsZXRzIGNhbGwgaXQg
bF9zeXNmc19nZXRfZHJpdmVyKCkuCj4gCj4geWVzLCBJIHdvdWxkIHByZWZlciBsX3N5c2ZzX2dl
dF9kcml2ZXIuCgpUaGFua3MgTWFyY2VsICYgRGVuaXMgZm9yIHRoZSByZXBsaWVzLiBJdCdzIG5v
dCBjbGVhciB0byBtZSB3aGF0IG5lZWRzIHRvIGJlCmRvbmUgdG8gcmVzb2x2ZSB0aGUgb3JpZ2lu
YWwgaXNzdWUgSSBzZXQgb3V0IHRvIGZpeCB3aXRoIHRoaXMgcGF0Y2guIENvdWxkIHlvdQpwbGVh
c2Ugc3VtbWFyaXplIHRoaXMgc28gSSAob3Igc29tZW9uZSBlbHNlKSBjb3VsZCB0cnkgdG8gaW1w
bGVtZW50IGl0PwoKLUNsYXl0b24K

--lQPg6FrFMOggoGv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmXzep8ACgkQSkztbX7f
lQoTdQ//fbmid9XEB8XfSHP+NK4qMzFE2slMQGiRl5db0lP42eGnWw6CKn0SRFJk
vBGHR3CWiaaKrW5BXRBOLO/5/uwwkqHTR4LNCG7m1flySBj552VBWkihFd5e2sJ7
Zjs7/UBzjiCdP9cESmG6S1zBg76JZ413oAvgZQQPxSqqtA1dZdR5zzPkqfkn7VjD
FzzvMNkTqrZu2y17KWxlVLbJb8nX3N2f33qquTdvAPYGg3MyeoU416q+lQgNLC/S
iyHHb0hk3S5psIR8nXf0Zx3VBVMKIO2Wbqj5J+fcTcXnteBCteWVFFXBtkemq6BP
9S5ulVN8wPjK9TDJFzwdERTbeq6TfzUObU3HUS65tfpNYf4+3sXSXFM1rlOxWWSO
zeFrRpbR6o7s9ZCkrCddHYnAVSkRMiGgcxV4VXkpPQlo3RidpwPv8564s9CAYVN2
QlFlrtg+noxmsvVAjTFa3Cb+Z9HvvceoS7kb5iZodlICeJe2eUQRd9+G+365Y3pe
K5hz1FoIH0+YenhRZqoLjL5vvxjz/QcD33cRhfFX8HSTq8jxUwzXuFHhIFrKxvvL
LN0b+O86vziQjcVbvjkHXmu09vP+PJJl5h62ZElYTcJCboHQyaZMR1+962P1tMrU
PJfRRH6Oa/7FpO3Luh3HYmJueOqCFYSe2kWhF3Tv066TsBq3Gp4=
=PHjf
-----END PGP SIGNATURE-----

--lQPg6FrFMOggoGv4--
