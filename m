Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC962F22
	for <iwd@lists.linux.dev>; Wed,  2 Oct 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906152; cv=none; b=KIRkJeHldv3LVwla57dvxE1SZvh7Y6ETC4qv5FKRZdbJYZWnrBZgWyA10tgikGkpqZUipFOI8FyE2f0DJLMllmnGcwyeaBJkAqav2JyYUmuHgGAiGgGld6wI9vozXfswCgVy8CcjYkXrKPgbNl3uzclplwuaql3GfBGWGV7ictE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906152; c=relaxed/simple;
	bh=o9z0452DV5PsH0eh4RGASkLibLK4rdqVBZ1ntITGJms=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=LK+ADRzaCCnVrTfQw7Vmd76BEvwkS/eNHk3Cu+E24SsKtTNvvwonav0APGC8rmHiNZIAN/ns9mtVIdAlynH9Y2JnqaP9u6LPoziTaR+m3ZmuSjaBzTqwWM+2EcpAOId1FSocbgLDU07qgvUPFi0tEtfk4/9ZoszQqPQmP51+FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YO8bKoBA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YO8bKoBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727906148;
	bh=o9z0452DV5PsH0eh4RGASkLibLK4rdqVBZ1ntITGJms=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=YO8bKoBAZGaTjtvqEo6nelckMXm9HGyrwEvwv0VQOFdH2JKHVnopsKgiczaxj73dl
	 tipw+4yLBkAlT0xJw7we/ENeImVOhd2Chv00mdP+Cj1cGHj5uJ/6goYgbUymPTG5B7
	 da2IS4uH3lSZYKfbHP6wPSI7Um2r9oRwnz0DD9NXSqduz+5x4vM74u0K1SIlhqMJFy
	 v7hA01gh7lX7UqDmg5m8gYixu77f5ysQtZXhphfqXq0AfQc+gxPASA4xgQT0zL76/D
	 /mf95aSEl5JM2X8EpOPS2z4gn8RU7IfE32fyL4PUHGvK9nD5Pc9MHNZVfkx429EvSQ
	 WvRkB4MAaQSGg==
Received: from [IPV6:2001:4d48:ad5d:8e00::197] (unknown [IPv6:2001:4d48:ad5d:8e00::197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vivek)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 79C5617E36C5;
	Wed,  2 Oct 2024 23:55:48 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------bfPDZSm2HZkfIX0LCyCMg68d"
Message-ID: <c400002b-ce76-4cfa-b5f0-c51be00eb9cb@collabora.com>
Date: Wed, 2 Oct 2024 22:55:48 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
From: Vivek Das Mohapatra <vivek@collabora.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
 <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
 <f8703c80-14fd-42b8-bf8a-d06919b0db6e@collabora.com>
Content-Language: en-GB
Autocrypt: addr=vivek@collabora.com; keydata=
 xsFNBEz9NbYBEACgMV7FuH09ggPGKhUGmoVUysEC45d9siHq1k/Y5KwTRrL/gsxnXPjUszJQ
 uc0kD+hxPc40DWGKWPCVDP26KX8rmSKpL8E+xKOPNj2GfFRJWg2KR7oNstEvQVFk5RF0cDWz
 XS9urLiI4fLf/IWjL4lYKgObzzwFinpdzX6VDySl9XcQpmP4F+MzjkZcWMZHoKe4jOoJj6x6
 8CmqBv4/7RjR+P99mSDHAVS834RRUMRb9aUiQCw5hqUA48cC+Em8nypf+UsrUylcfdFRjUFu
 e4sYJDa2n7PQ4QZ/dcV72pHEM/474GfPHaEQf97EXkYy1tQVEq/7NnjLTLexH2THhlRYlxK6
 ZIxoGbnxQxTfDL7rckjidvZ2YNvPuBgA6n9mgGHHVd9gdhPUvf35usDyX4v5/OFjZwp44Feu
 iboBnRRMnG8obpJlYoLoUa0uPVMnFD6HVXsGQnh531Yzn8qnkR2mHT3ZJ0Mz97airMUbYmCB
 U2vpwyL4a3mjKSFlfFMRq19vXXvHWlaPf5Zqovwj/WiNQu9vLftN1z8EDMtBQ0wpfIFk5/AI
 nmUUkleQFz8PvvXAP2PSm/xAhOMPwLIBFulQXtdk3n0iH7wET7/9BtGnXc7VEvGnuONo3JKz
 a501FGI13/ndO+hkKx99FDQaas2cmLd1fS+OV+f+a/yNACRwqwARAQABzSpWaXZlayBEYXPC
 oE1vaGFwYXRyYSA8dml2ZWtAY29sbGFib3JhLmNvbT7CwXcEEwEIACECGwMCHgECF4AFAlf1
 SNYFCwkIBwMFFQoJCAsFFgIDAQAACgkQ4BbYfHdtpR+Jpw/+LU8vT5jusi90Dmq6sSSh+xPD
 30NAZY/9MWEyxI3PemznaBGX0+HDrD7LcutVVhpMq8UdYS5XHlFyy7swaMaIIMJT4QXUd8Ys
 t6DL1VfQq8dqnsgITmWHMPA3UzdY98arNeUUKbaPrBiRNv4iszQsW8EAdA1LuuRSSR3uSeJk
 DAtqLWMeVncuvo6iFa77p1da91IwJ4PLBUdlTY7JjamdWhrXlxZtdNTgjSq4hPb5DRxAZ4Un
 th2hM2hdTbJu8rr518ky+1iOxoW328SviOEc1RJrPFqYDoXUBZyaafHzSQZVqyKwJjmHZ3vs
 SmfD9oT5bhFjd3WqlzcWcWPFAo+W1gGGC1TLW/q8Rl1nhkYrWGonO9OAeI6ylaVAXXs+YkW+
 ggx/0ic2vAL3QXjgGdWxZ6Xn7QamMW95wZlUSzL2ovJtaLnWJAaneQJyIDAfEuI5fHjbU58K
 LUlr41Z0yUjlACSn/V5Zz0/9zqRy4z1rUpInSNEQp/nmYA8lkqTSoC2i6y69tkKvgJLe+TTI
 wVZU+RB2sIKs8QP1Al5J5XmGUKy5PlFfLJdM4zJn6UpHrab4sldEac96lJWlcY6v8veg0FWW
 0+GaorCEE/CMyJ45Uf5t6RrxUR1ogC+KjPK+0Dv/iGktwwszykLvPDU211lhCI4rY8dAQAvt
 ltCLfsaTbubOwU0ETP01tgEQAN1I+huQnawNdneUjUDW4FFWl56Y4qkubcjAdCVfvywleUHx
 HhtRV7Zg8XlCeKUuamYXLtWTXeB9VzXTvlEHd2NM434acqlJCzOmrmmGgvUS6o281Isb6Qt0
 a8JWo8reT8u88B+2wC898QGYhdZvKsGYhk9/f0AJiQNLjGXq+zqG9bINr2DLljLkVXESs8B8
 tITTFtiDbNZ03ZOhpDPutyHLszjGicWy2tHrv3QFfWft+ToVureHj7vA5wtynh8rkJhiKAAQ
 TQ0lFsAWNqB81/K+27iBqkKg+5f/B7M05zPrxslV/5yI3BNBrmMV59vo03g9Yog9yPwNdE1+
 +dPVJMHuMmj/udf5zfxnC9BaD5ejVEOgUgqWKU0oYVx3cyA4C3YSBqrDVA6wXOD9ERalum0R
 eXtTEWC++Ri6UplG2SGPgAXzSMTfiXtdYDUSJBb9sy3TAnnish3ntgZ9aj/Ez/TY9pe1BzA2
 GvL7IBod4qTzz5EsJcxL460pZdF6KQ4xfZPwdaLmuimjbhqYdi4IYfAZn/b/KVxkVFVS7p/r
 UHZzlFQEQtUo1hPpq3sEmpzsqo4UM21hg6QTKlrpjm1avRHdf5OOCz7jBo9lve9jnLDNO9Cq
 JksjpltSNw3dkE1rw0DW2OX2T2vLJP+GUigf+oCFYus5i8JreoE1DJrVIl8vABEBAAHCwV8E
 GAECAAkFAkz9NbYCGwwACgkQ4BbYfHdtpR9ljg/+KnS/ZaJDEp0vgCZxirN/sTW6va3ycJbT
 mL92a0upvsabGJ8LXQwighsasu7UyMmij0HGDExJ1S1BsyzUXYB1LIvwMU3CNbBkLLm9j2Kv
 ZQKLU7nhlzWty1nB3u9ElNlJg3L0HYnxKod7l1ShL9XEkNnXMJeTALSROV2FmkIHjtDChIyl
 peWEW6jYsJIDtOo7swgDEGTSAfpP4zIjz6P1T9f592yLVvRzNFpE1HhzOJQcLKnzNowLvYd9
 FjnII4+dlrcR46Lhugyn0oqPTtNrhP5lxaWN304wyJY4efBsd3sCrdbxCy1NPK/CsRjOfRJl
 4tFSZrMAyUyStmwDSOBWTDAyYCeCj4YUZvTH3JpEeX14D/qUzbSoAoRXTmkzf/2X8urWPhgr
 EKw84i5E+37OolE4TPTwu09y1yEX/dFkT2YGQ8seHX9MwgySRo4RAVwtf4lxelTWLOSc/0hJ
 VJ+6KPR1Vr7UPl7PeHhLBY/haQA7jkPOaU2jI38rvr5ctMnJouHPGLTEL3K/u1hvn/fBWcwX
 d0qLbz2JVwHW4pD3PiHvZKzhaYRV1eFHf6m4nFQFOTgdtIP5z47KxJ2P8n+A1Gzw2i2PBpFk
 3tBefOmBSdQXAhgJRBw+xWOV3hmUst5CJe/G+s1W+kUspPdvT5R6h1OlRiTt8TOnEn6cFmyN Rdk=
Organization: Collabora
In-Reply-To: <f8703c80-14fd-42b8-bf8a-d06919b0db6e@collabora.com>

This is a multi-part message in MIME format.
--------------bfPDZSm2HZkfIX0LCyCMg68d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2024 22:41, Vivek Das Mohapatra wrote:
> On 02/10/2024 19:14, Denis Kenzior wrote:
>>
>> Why are the elements duplicated?  Are they the same or different?  If 
>> different, which one would iwd use?

OTA capture:

I've linked 1 file to this email:

   * 0926_qfiber.tar.xz
     Size: 5.2 MB
     Link:
 
https://www.dropbox.com/scl/fi/i573yehaenpvkgy29smwb/0926_qfiber.tar.xz?rlkey=sxhhiwhmqppyic5wsc446h88r&dl=0




--------------bfPDZSm2HZkfIX0LCyCMg68d
Content-Type: text/html; charset=utf-8
Content-Disposition: attachment; filename="0926_qfiber.tar.xz.html"
X-Mozilla-Cloud-Part: cloudFile;
 url=https://www.dropbox.com/scl/fi/i573yehaenpvkgy29smwb/0926_qfiber.tar.xz?rlkey=sxhhiwhmqppyic5wsc446h88r&dl=0
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
 <head>
  <title>0926_qfiber.tar.xz - Filelink Attachment</title>
  <meta charset=3D"utf-8" />
 </head>
 <body>
  <div style=3D"padding: 15px; font-family: Calibri, sans-serif;">
   <div style=3D"margin-bottom: 15px;" id=3D"cloudAttachmentListHeader">T=
he file 0926_qfiber.tar.xz was attached as a Filelink. It can be download=
ed from the link below.</div>
   <ul><li xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"border: 1px so=
lid rgb(205, 205, 205); border-radius: 5px; margin-top: 10px; margin-bott=
om: 10px; padding: 15px; display: grid; grid-template-columns: 0fr 1fr 0f=
r 0fr; align-items: center;" class=3D"cloudAttachmentItem" data-content-l=
ocation=3D"https://www.dropbox.com/scl/fi/i573yehaenpvkgy29smwb/0926_qfib=
er.tar.xz?rlkey=3Dsxhhiwhmqppyic5wsc446h88r&amp;dl=3D0" data-service-name=
=3D"Dropbox" data-service-url=3D""><a href=3D"https://www.dropbox.com/scl=
/fi/i573yehaenpvkgy29smwb/0926_qfiber.tar.xz?rlkey=3Dsxhhiwhmqppyic5wsc44=
6h88r&amp;dl=3D0" style=3D"color: rgb(15, 126, 219) !important; grid-area=
: 1 / 2;" moz-do-not-send=3D"true" class=3D"cloudfile-name">0926_qfiber.t=
ar.xz</a><img class=3D"paperClipIcon" style=3D"grid-area: 1 / 1; margin-r=
ight: 5px;" alt=3D"" src=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgA=
AACAAAAAgCAYAAABzenr0AAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAGXRFWHRTb2Z0d2FyZQB3=
d3cuaW5rc2NhcGUub3Jnm+48GgAAAVFJREFUWIXtl8FKw0AQhj8EbQ/p0Ut8AVEPgYLUB+i5L=
6J9E0Wtr1HPgl48WU8K1Tfw4LktxUAhHvZfiMXUbdhVhB0Yms78M/NldwkJuFsD6AMjYCYfAS=
fKBbUd4BkoKvxJmiDWKA1/AXrAtrynmIUIshJ9DXgEmt/km8oVwHEIANu8u0LTleYhBMBUzZM=
VmkSaSQgAe9DW1d3L/wzAqW6jJpQ3+5cA3vbW1Vz3Np6BCBABIkAE+DWAmX7TUixdynm15Wf6=
jf5fa3Cq60K5qrraNuHrK1kbmJcGWJ8rB9DC4yvaq5odlmK7wBB4lw8Vs9ZRzdgHwLmaXa5RM=
1DNmQ+AA2ABfACZgz4DctXs+QAAuMLc0dsPEJk0BXDhazjAFnCnxjlmiTuYg5kAR4rl0twCmz=
4BLMQAs7RVH6kLzJ17H162fczhGmO+mqa6PqXGnn8CxMN0PcC9DrQAAAAASUVORK5CYII=3D"=
 width=3D"32" height=3D"32" /><img class=3D"cloudfile-service-icon" style=
=3D"grid-area: 1 / 3; margin: 0px 5px;" alt=3D"" src=3D"data:image/svg+xm=
l;filename=3Ddropbox.svg;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvM=
jAwMC9zdmciIHdpZHRoPSI0OCIgaGVpZ2h0PSI0OCIgdmlld0JveD0iMCAtMTcuNzI1IDIzNS=
40NSAyMzUuNDUiIGZpbGw9IiMwMDYxZmYiPjxwb2x5Z29uIHBvaW50cz0iNTguODYgMCAwIDM=
3LjUgNTguODYgNzUgMTE3LjczIDM3LjUgNTguODYgMCIvPjxwb2x5Z29uIHBvaW50cz0iMTc2=
LjU5IDAgMTE3LjczIDM3LjUgMTc2LjU5IDc1IDIzNS40NSAzNy41IDE3Ni41OSAwIi8+PHBvb=
Hlnb24gcG9pbnRzPSIwIDExMi41IDU4Ljg2IDE1MCAxMTcuNzMgMTEyLjUgNTguODYgNzUgMC=
AxMTIuNSIvPjxwb2x5Z29uIHBvaW50cz0iMTc2LjU5IDc1IDExNy43MyAxMTIuNSAxNzYuNTk=
gMTUwIDIzNS40NSAxMTIuNSAxNzYuNTkgNzUiLz48cG9seWdvbiBwb2ludHM9IjU4Ljg2IDE2=
Mi41IDExNy43MyAyMDAgMTc2LjU5IDE2Mi41IDExNy43MyAxMjUgNTguODYgMTYyLjUiLz48L=
3N2Zz4K" width=3D"32" height=3D"32" /><br /><span style=3D"grid-column: 2=
 / span 3; font-size: small;"><span>Size: </span><span style=3D"color: rg=
b(89, 89, 89);" class=3D"cloudfile-size">5.2 MB</span><br /></span><span =
style=3D"display: none;">Filelink Service: </span><span style=3D"grid-are=
a: 1 / 4; color: rgb(89, 89, 89); font-size: small;" class=3D"cloudfile-s=
ervice-name">Dropbox</span><br /><span style=3D"grid-column: 2 / span 3; =
font-size: small;"><span>Link: </span><a href=3D"https://www.dropbox.com/=
scl/fi/i573yehaenpvkgy29smwb/0926_qfiber.tar.xz?rlkey=3Dsxhhiwhmqppyic5ws=
c446h88r&amp;dl=3D0" style=3D"color: rgb(89, 89, 89) !important;" class=3D=
"cloudfile-link">https://www.dropbox.com/scl/fi/i573yehaenpvkgy29smwb/092=
6_qfiber.tar.xz?rlkey=3Dsxhhiwhmqppyic5wsc446h88r&amp;dl=3D0</a><br /></s=
pan><br /></li></ul>
  </div>
 </body>
</html>

--------------bfPDZSm2HZkfIX0LCyCMg68d--
