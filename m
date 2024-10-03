Received: from zdiv.net (xvm-107-148.dc0.ghst.net [46.226.107.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2441552F5
	for <iwd@lists.linux.dev>; Thu,  3 Oct 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.107.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956911; cv=none; b=g0Xju3M/ydrwLg8JxI4BT7am3ed+eGyCpvIHfuDAMRx4comV/PW8gjbu/4uL4ytSY2JKbiHCNZUgftSfgM5AdVluDXw6y/GbQlnhQNb3OIyfzzjQ91gMDBBZBgkmKQoJJi5qIkrQ+A8t9oq1qbEvwX04g69p/cgMRHY6mngyDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956911; c=relaxed/simple;
	bh=Su3Xn6mxXTISOqu3zgwu4lENoSGr/SFxqewuRdaw5iI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=Zxxet8TJRpjTTRCITZS0qBWRQetKXHj7/n/L5GdHRWm31X+ZLXuIHTGKXMwuEDK4Aun4UIr+TpAr7m+zsGF08g/xoP080U1ZuRRnqsyFx/HvcX57oFh1hDt1j4kjeBwdqDJQ4v1drjOzLqL/cbJj2VT8njgpS2G4hh9HYB36spY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=b3ZnUBvC; arc=none smtp.client-ip=46.226.107.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="b3ZnUBvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=23;
	t=1727956907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RUlDUpGXoZOpwOP/ck0vQYOd7q0k2r6nOcKNj2KFLG0=;
	b=b3ZnUBvCqhFFHz3/3iQ/YyvGnv3/1Ht3k90rT/GBncv9E+C4EV9EHH3wkaKB4BjvtzTLBw
	gjQ+4Ff69YWZryUU0YcIBKErQN0xo9rTAhWWH6/tN7f6Cesuq6oGGmjHGvjYEfSrZOSiw6
	8CdVaFrkUVcodKQLqbQvOXB9BpUG2JAd4RvN5KqBEp3SgOg+sVMbXKzh3JYw0etjmEazwq
	B7jnWCR3sk/InSyllUNmiIhItYYsshCKJATWcLyJ3Yp+oOr+hcBfJcOaQneCJbnTzA8V2S
	wRn3Er4R4OujTd4m+LjArX5/MmVmFYDooPCazzE2hx9gxNj3q+aktOOf/DgfCg==
Received: from localhost (91-160-75-97.subs.proxad.net [91.160.75.97])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 759ab955 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <iwd@lists.linux.dev>;
	Thu, 3 Oct 2024 12:01:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Oct 2024 14:01:47 +0200
Message-Id: <D4M5LOG8MPW1.SYF1VD48Y3YH@zdiv.net>
Subject: iwd 2.22 segfault
From: "Jules Maselbas" <jmaselbas@zdiv.net>
To: <iwd@lists.linux.dev>
X-Mailer: aerc 0.18.2

Hi,

I am having a segfault in iwd 2.22, running on Alpine Linux (on edge).

I can reproduce the segfault by doing `rc-service networking restart`,
dmesg gives this information:

iwd[4229]: segfault at a ip 00007f027ca94c6b sp 00007fffd6c75858 error 4 in=
 ld-musl-x86_64.so.1[7f027ca44000+57000] likely on CPU 4 (core 2, socket 0)
Code: f8 48 83 fa 08 72 14 f7 c7 07 00 00 00 74 0c a4 48 ff ca f7 c7 07 00 =
00 00 75 f4 48 89 d1 48 c1 e9 03 f3 48 a5 83 e2 07 74 05 <a4> ff ca 75 fb c=
3 48 89 f8 48 29 f0 48 39 d0 0f 83 bf ff ff ff 48
...
iwd[24403]: segfault at a ip 00007fa91633ac6b sp 00007ffd1faaa028 error 4 i=
n ld-musl-x86_64.so.1[7fa9162ea000+57000] likely on CPU 6 (core 3, socket 0=
)
Code: f8 48 83 fa 08 72 14 f7 c7 07 00 00 00 74 0c a4 48 ff ca f7 c7 07 00 =
00 00 75 f4 48 89 d1 48 c1 e9 03 f3 48 a5 83 e2 07 74 05 <a4> ff ca 75 fb c=
3 48 89 f8 48 29 f0 48 39 d0 0f 83 bf ff ff ff 48

This is not an issue in musl-libc, but a call to memcpy with a bad address,
we can see that the source address is 0xa (10) which is also the offset of =
`aa` field in the `netdev->handshake` struct
which makes me think that handshake is null when netdev_rssi_poll is called=
.

Here is a backtrace when iwd segfault:
(gdb) bt
#0  memcpy () at src/string/x86_64/memcpy.s:22
#1  0x00005555555fc0dc in memcpy (__od=3D<optimized out>, __os=3D0xa, __n=
=3D6) at /usr/include/fortify/string.h:55
#2  l_netlink_message_append (message=3D0x7ffff7f34050, type=3Dtype@entry=
=3D6, data=3D0xa, len=3Dlen@entry=3D6) at ell/netlink.c:841
#3  0x00005555555fd78f in l_genl_msg_append_attr (msg=3Dmsg@entry=3D0x7ffff=
7f34020, type=3Dtype@entry=3D6, len=3Dlen@entry=3D6, data=3D<optimized out>=
) at ell/genl.c:1518
#4  0x0000555555559080 in netdev_rssi_poll (timeout=3D<optimized out>, user=
_data=3D0x7ffff7f38dc0) at src/netdev.c:760
#5  0x00005555555f959e in timeout_callback (fd=3D<optimized out>, events=3D=
<optimized out>, user_data=3D0x7ffff7f363b0) at ell/timeout.c:69
#6  timeout_callback (fd=3D<optimized out>, events=3D<optimized out>, user_=
data=3D0x7ffff7f363b0) at ell/timeout.c:58
#7  0x00005555555f8a75 in l_main_iterate (timeout=3D<optimized out>) at ell=
/main.c:461
#8  0x00005555555f8b4e in l_main_run () at ell/main.c:508
#9  l_main_run () at ell/main.c:490
#10 0x00005555555f8d7f in l_main_run_with_signal (callback=3Dcallback@entry=
=3D0x5555555587f0 <signal_handler>, user_data=3Duser_data@entry=3D0x0) at e=
ll/main.c:630
#11 0x0000555555557bd0 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at src/main.c:614


I've also ran a git bisect which points to
154a29be0552f5a39e34301ebaf24623d64073da netdev: fall back to RSSI polling =
if SET_CQM fails
as the first bad commit. I noticed the "rssi" word is also present in the s=
tacktrace.

I am using the following wifi card:
03:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wire=
less Network Adapter
driver: mt7921e
version: 6.6.53-0-lts
firmware-version: ____000000-20240716163327
expansion-rom-version:
bus-info: 0000:03:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no


Cheers,
Jules

