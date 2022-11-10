Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F4362
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 03:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668050309; bh=Q/CBIk/TKoeRMaxdgUdr/oUQf6UILS9a3b/g4LwX1V8=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=tG1sAVe6uoqKwHAJQiXUs+Cxo/mS/5bQu0GfVl97qLhLgAVyI659Hy5hXr0sPC/nQ
	 6DBqTFSP+skGK8rzFMxQIoR0S9k1wLrdIsMKMZBNAiWuv30p1z2XLfxF4aMA/b+kCu
	 BCjJiDseHHFoS+1aVpDBIJbNR3o6eqn5GELxRAvM0oWysKEwkK8OPdAh6pMVeL3FWF
	 S3JXyRofS/9oYn5JDs5r9sZkYuCeofvkQzmNHUl8w9joCCbohJ9sa6o8X5HJeyZjba
	 /mjKP2Iy6SA1vCvHJlQXdlwVtoQhU4zDwSxti3d6qVfwyIDTqkBnNDXGabDUHHKw1p
	 2N++V4GfnRaTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mmm.localnet ([2.205.106.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqXM-1oPhrm3bva-00UVnE; Thu, 10
 Nov 2022 04:18:28 +0100
From: Patrick =?ISO-8859-1?Q?H=E4cker?= <pat_h@web.de>
To: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Sometimes RxBitrate of 1000 Kbit/s
Date: Thu, 10 Nov 2022 04:18:14 +0100
Message-ID: <2259038.ElGaqSPkdT@mmm>
In-Reply-To: <4d50da71-40e3-f888-be79-b52fa8208e88@gmail.com>
References: <5893463.lOV4Wx5bFT@mmm> <4d50da71-40e3-f888-be79-b52fa8208e88@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4754146.GXAFRqVoOG"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:r1rCgiEZ/0QNM9f+p+KTNCppXfmKskdurdhfY8JH0nyZ3+nJEBs
 hvq4e1iGgExSVZ6To7+8ihOBpDSDZpAWVtcafqSe2DuL59NCPeoNnXyyNoeyddKByVIm3X4
 BuVI9FBWJRK4Okz7qh0RTRwp+DJLdjlBHqcAlwePCPCVFHVivQFuLb1UK8zqlCpgluSyh98
 m5Mhpb/RSMcKci6gipBoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UzSb9CVllI0=;mNFJeyWNYvueYFaUs6WbFp4SzC6
 s/SZFTEBnV8M538U/bnvrFqGRvxjUIAAhayBFN97ce3DN6YJ4A3X4rcyOvbVw3tLBA2DoRX6e
 gcA1X2f1HP+XjKAn3b1yjh7l9kgVoAPtgElh7S4EYMlQBZpMBqaEPv+OaaYYuAEzXAh4HL22s
 KXYz6Xth+5JTJr5o6iDgmaGwcasvgd8VE04vIhzg/Z/sGs6PeZ50pMBv0odPUtbXVxLkot3fM
 X/ErfeJ2c7VvUsOU+kIh9d0AMqUuO3drojJrrNi/PxzTbuG7vZ6i2qJ/rS5/LlNJ2d2wBbV9X
 +9hH4w0kCuf0/Rlq6D9Tp0FOLmAjPNE1TfYwdiHn1EfBuUfiPI8qP8m8fP6OnSdNEoFP2kgP6
 OHJlc9YOvkcOysPZW+AOfPHf0dRzd5y/A8op9w6Z2uBggW/+YxZjbBsXbZqk1JsV5Kt/d4G3F
 WjgQhGC2EKyM13K+mgcdidhi418OJ3Q4Vw16OJKj72XGex7FwzZqcf0lp8ePjfaF1RtdXsr37
 PrWIkV4ZKsEVR9TdOvNU13/Ng5vTzyD1HO2Z9WMIrQpooZNovbibTtZMH1Tw/ydJNDIILt6TI
 XIx7QZzqAOME6EZ+PKrWDTjIBbQeiOgR7RmLpwmZozZfsf0i1SPGz41wsmu4QUSzqZBR6Zm+8
 5JQVes1LA3qqz82d/V3OIo5vj2DrGRnpXstJoTY8lAXDm0zES7s4U/pOMKUDKK15OcABDwh2H
 k/0Xurd3QANfslw8XBQfPD0AEMC9Go8oh6N4u6RoPiPg8w6OkrgZcJqkBAxzW4Z5D3BB3Wp89
 CD3yNVRzGONcHu9ANtCiSnLGuI12cBcK53pYZk8nofbfxjJY4IzD76sE0KeSPxptmR+Wab46m
 w5aooIpTkpkSA+14qzlJWEqTz8essSa5nBWeqSrSMgrTYHY/9zhP9BnJTbUgU2/Y47z4CF57e
 BjNQT/yQl1S5fT7iFgszFvgqH2A=

--nextPart4754146.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Patrick =?ISO-8859-1?Q?H=E4cker?= <pat_h@web.de>
To: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Sometimes RxBitrate of 1000 Kbit/s
Date: Thu, 10 Nov 2022 04:18:14 +0100
Message-ID: <2259038.ElGaqSPkdT@mmm>
In-Reply-To: <4d50da71-40e3-f888-be79-b52fa8208e88@gmail.com>
MIME-Version: 1.0

Hi Denis,

> iwd doesn't do anything on sleep (it isn't even aware of sleep).  So it =
is
> up to the kernel driver to do the right thing.  Maybe it isn't?  You'll
> have to ask the kernel / driver / firmware people for your hardware.
thanks a lot for the answer. I'll contact the kernel / driver / firmware p=
eople
for my hardware.

> Some network managers (like NM) will explicitly IFDOWN wireless interfac=
es
> on suspend and bring them up on resume.  This isn't cost free and we'd
> rather not do this.
Would it make sense to do this optionally if a new config option were
explicitly set? Or do you think this is the wrong layer or wrong approach =
to
do so?

> You can also try to run run iwmon in order to capture what is happening =
on
> the nl80211 API level when entering / leaving suspend.  The driver peopl=
e
> might be interested in this information.
I was monitoring with iwmon for the last days whenever the computer was in
use, but so far the problem did not occur again (it occurs during normal
operation, I just have the feeling that the probability is highest some
minutes after waking up from suspend).

The only thing I got was a segfault from iwmon once, so it's now running w=
ith
valgrind. This is, however, probably an unrelated issue, if it should repe=
at
at all.

Thanks again
Patrick


--nextPart4754146.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE8JojVI+cFX1k1E7YHGgu1+TJBeAFAmNsbXYACgkQHGgu1+TJ
BeCK2Q/8C05/dI9+8stzD4q8QofjM67U0dW0Ny2BBpAVf/eGCreqjFGOXpVn8cfj
937PPo/l5pd6VBVHFecmh9IJByrCwFP55xptVCZuV/DirUFsHXqTehYIiTQ5EQNl
XdQ6kNo2zinYu4Xb+BaqOCGfQS9q2o3xmVK/5feYUkNkEfBNPuq0TdOTwf68AdDi
FhvgwfaDZTIbNpj1mS9/oNiJ+F/fHewbSUf5J/WQJDi21yvY147SykYAmfvRneX0
bqasiIMt5xgS5VaB2Rt/J2aQaWFSZcT7hdZMRXPNXLNXS7aPahTT1LNV4qlRPKbn
+T12EwBREFT3/TgS3uihCsZjgD/LEvv4pyS+pQ4KLAp6vX3w4kV/J5G+GCz9Z5hS
jWqVTJxBnCwr/9lS2ZHA5y9mN52b17IMHZL0tUuBweVZ9D5ucg38zSF5YvujTrGK
Vsux9xUOT+YNQ+NsNSZ8J7X9nxmD84uziI6JL0j4LVc3U1bM4jF5uUdCBq4QzOWQ
eET3bG6eJHTGM+dhfcgAzrL7IBHTylu/gzBzSfMZmT4cxYtknmUvCripdcRHFOlv
7yZgzDaM2KuvzmAYyb4FpJmmAYdTOPcaKh13BvaUcFBKQ6scCwIl5scRLUuRSSXS
3EyZO+fI0LRc+HhHaagW1wyZTyhJZiHyeSE9DGaQFDHdUUfsAIs=
=k4UM
-----END PGP SIGNATURE-----

--nextPart4754146.GXAFRqVoOG--



