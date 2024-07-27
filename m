Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F353373
	for <iwd@lists.linux.dev>; Sat, 27 Jul 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083127; cv=none; b=RyFTIeX46qz85juaMMLoW3OnRfOWqJXsOAnn4Vh3lIhfMa3loYdVrYjK9avbApq/lquj5kh6FSDzXj+Nm5hBvZAFbX2dQukMRWyrWS8OM6Nm8VlGRcGdf9SqdcTorx2pNS20i5M9JoXEihDT0+cI962v+i4UwOaJAUIi3DoAh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083127; c=relaxed/simple;
	bh=U/lJD4k7xQj9ZMc6F/eiW5W1mbt44YYaHzbQZ35qO/E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rNYYVrOZMNa4D+be+Vb30LVmmZWrHDxyZQY60dPOOsyD5uYawj+AwRvEISMknuOvupo6R1juBvM45wInLp49xKetVlAAIOClh9alBpd/EytpAeOS/ohjWZpBr3vkCd1ZcB/TmblpJEFspnLnM0f2vSKUzd1gRrSX3VmItW0bbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYfCUymD; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYfCUymD"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f52cc4d3beso611500e0c.3
        for <iwd@lists.linux.dev>; Sat, 27 Jul 2024 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722083124; x=1722687924; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h8COG6gHUY/Aj2v9ZfcwJowkZJCnEWg6RMupc6gCZDw=;
        b=ZYfCUymDOIKueSOQPYavst4YdFyZRxgIVLrAgaajHVYFow3XK/z4A1BUlNvML0XGdB
         wzcvvwgSYvyDDUR1b8oLT5xG/0FUmZmIGJ8qdDVFlVjzK/Ba28ejMuo9cweSf8EutrsS
         juv4d3GpTz7ek7fdvX1tsOWh+2gmNYYRxeM8IQQCWuv3KDpXKg0GLRLIwSE1LTuv9PT8
         ZqGjhvJUPzEplSFbbFXWx4OzTC8bWX/Qg1XzbUrPDoZNxaCjQj7ygpwsp2ZIXQfods7e
         tsukZLMetzerHCOXkaa4lWLB9RycDKdrFjZXcy6RSqE6hPowm5/1A0vxWz3sQv6xujdn
         dM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722083124; x=1722687924;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8COG6gHUY/Aj2v9ZfcwJowkZJCnEWg6RMupc6gCZDw=;
        b=K241JycW6DsWNCaTUHxg6l0rkesa3CrsSG9ba2oZbbY41L5buYaOXtOGDrtowMJ7Om
         54nJGKkLrrMqJ+Hy+BJHfdHYxmjEPSyKcgV2bdYQSuNS/0M7hFUJaUYAn+qUbOwo60ej
         N88E4THT7GcUjojnwF1IwSOOoueqhCp2ff8kakmg25cNuBE/Wq8/JKaNZ0+jOcOZcTHs
         5OP/dcf/z4KZCBVI9gQDIoOE0HYZ92N4b8C5593zNl4k3V4AffNPO1yE/Jp+C0oOjESX
         3z58nZG93hMNdU3mLJViQpde1YU6PmZ7Fv5kDL+ewcQunXNRYAAumIRnRltfNkDsIiW+
         ASCQ==
X-Gm-Message-State: AOJu0Yyx6WNRkUxmpBfpMlPjF7KViLkqfB56Z49ClaOZaJZApaXT9BG2
	dhXMI4b625ypa0uf4gBBtI92UbGxHSHjD5INhgM6JuhSUe09jpHDD2WWppZ/OVU4WdRq7AaPzn5
	RMGzQm81pmdv2noH45UzR9HI9c+VSYk+yz5U=
X-Google-Smtp-Source: AGHT+IECsI1868uk04X9K3wRA2MmxVNgDLchyd2faHXsl6P02Rysl5rsXUSZuw7TkqxBIfzjgYDYeDL5zgCuNN5+gt0=
X-Received: by 2002:a05:6122:4105:b0:4f5:c90:2556 with SMTP id
 71dfb90a1353d-4f6e68c93d4mr2715719e0c.4.1722083124149; Sat, 27 Jul 2024
 05:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Sat, 27 Jul 2024 14:25:13 +0200
Message-ID: <CA+iibzC0yNsPu3chJj-aRA6=7Yyur_sspoKtO_SpjqA4xPsgGQ@mail.gmail.com>
Subject: compilation error in iwd with ell commint 883bc6a90b4a9c654fdf2540f02447a7ca567e04
To: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>, 
	Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi James Hi Denis

I compile iwd with ell include in the same Pkgfile

makedepends=(dbus git python-docutils readline)

description="Internet Wireless Daemon"
url="https://git.kernel.org/cgit/network/wireless/iwd.git/"

packager="Yaolinux Team"
maintainer="Dania"

name=iwd
version=2.19
release=10

#source=(patch1.patch patch2.patch patch3.patch)

#Last commit on iwd repo
_commit1=993e48cab240b7fd1b3f508222eaa4ecde83aa8c

#Last commit on ell repo
_commit2=883bc6a90b4a9c654fdf2540f02447a7ca567e04

prepare() {
  git clone yyyyyy ell

  cd ell
  git checkout ${_commit2}

  cd ..

  git clone xxxxxx iwd

  cd iwd
  git checkout ${_commit1}

 #patch -Np1 -i $SRC/patch1.patch
 #patch -Np1 -i $SRC/patch2.patch
 #patch -Np1 -i $SRC/patch3.patch

  autoreconf -fiv
}

build() {
  cd iwd

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --localstatedir=/var \
              --libexecdir=/usr/lib/iwd \
              --enable-wired \
              --enable-ofono \
              --enable-hwsim \
              --disable-tools

  make
  make install DESTDIR=$PKG

  install -dm700 $PKG/var/lib/ead/
  install -dm700 $PKG/var/lib/iwd/
}

withe the last commit of ell 83bc6a90b4a9c654fdf2540f02447a7ca567e04
the compilation fails

  CC       ell/dhcp-lease.lo
  CC       ell/dhcp-util.lo
  CC       ell/dhcp-server.lo
  CC       ell/cert-crypto.lo
  CC       ell/cert.lo
  CC       ell/ecc-external.lo
  CC       ell/ecc.lo
  CC       ell/ecdh.lo
  CC       ell/time.lo
  CC       ell/path.lo
  CC       ell/dhcp6.lo
  CC       ell/icmp6.lo
  CC       ell/dhcp6-lease.lo
  CC       ell/dhcp6-transport.lo
  CC       ell/acd.lo
  CC       ell/netconfig.lo
  CC       ell/sysctl.lo
  CC       ell/notifylist.lo
  CC       monitor/nlmon.o
  CC       monitor/main.o
monitor/main.c: In function 'rtm_interface_send_message':
monitor/main.c:351:38: error: passing argument 2 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  351 |                 l_netlink_send(rtnl, RTM_NEWLINK,
NLM_F_CREATE|NLM_F_EXCL,
      |                                      ^~~~~~~~~~~
      |                                      |
      |                                      int
In file included from ./ell/ell.h:17,
                 from monitor/main.c:43:
./ell/netlink.h:34:59: note: expected 'struct l_netlink_message *' but
argument is of type 'int'
   34 |                                 struct l_netlink_message *message,
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:351:51: error: passing argument 3 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  351 |                 l_netlink_send(rtnl, RTM_NEWLINK,
NLM_F_CREATE|NLM_F_EXCL,
      |                                                   ^~~~~~~~~~~~
      |                                                   |
      |                                                   int
./ell/netlink.h:35:58: note: expected 'l_netlink_command_func_t' {aka
'void (*)(int,  short unsigned int,  const void *, unsigned int,  void
*)'} but argument is of type 'int'
   35 |                                 l_netlink_command_func_t function,
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
monitor/main.c:352:49: error: passing argument 5 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  352 |                                 rtmmsg, rta_buf - (void *)
rtmmsg, callback,
      |                                         ~~~~~~~~^~~~~~~~~~~~~~~~~
      |                                                 |
      |                                                 long int
./ell/netlink.h:37:58: note: expected 'l_netlink_destroy_func_t' {aka
'void (*)(void *)'} but argument is of type 'long int'
   37 |                                 l_netlink_destroy_func_t destroy);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:351:17: error: too many arguments to function 'l_netlink_send'
  351 |                 l_netlink_send(rtnl, RTM_NEWLINK,
NLM_F_CREATE|NLM_F_EXCL,
      |                 ^~~~~~~~~~~~~~
./ell/netlink.h:33:14: note: declared here
   33 | unsigned int l_netlink_send(struct l_netlink *netlink,
      |              ^~~~~~~~~~~~~~
monitor/main.c:359:38: error: passing argument 2 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  359 |                 l_netlink_send(rtnl, RTM_DELLINK, 0, rtmmsg,
      |                                      ^~~~~~~~~~~
      |                                      |
      |                                      int
./ell/netlink.h:34:59: note: expected 'struct l_netlink_message *' but
argument is of type 'int'
   34 |                                 struct l_netlink_message *message,
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:360:41: error: passing argument 5 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  360 |                                 rta_buf - (void *)rtmmsg,
callback, user_data,
      |                                 ~~~~~~~~^~~~~~~~~~~~~~~~
      |                                         |
      |                                         long int
./ell/netlink.h:37:58: note: expected 'l_netlink_destroy_func_t' {aka
'void (*)(void *)'} but argument is of type 'long int'
   37 |                                 l_netlink_destroy_func_t destroy);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:359:17: error: too many arguments to function 'l_netlink_send'
  359 |                 l_netlink_send(rtnl, RTM_DELLINK, 0, rtmmsg,
      |                 ^~~~~~~~~~~~~~
./ell/netlink.h:33:14: note: declared here
   33 | unsigned int l_netlink_send(struct l_netlink *netlink,
      |              ^~~~~~~~~~~~~~
monitor/main.c:365:38: error: passing argument 2 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  365 |                 l_netlink_send(rtnl, RTM_GETLINK, NLM_F_DUMP, rtmmsg,
      |                                      ^~~~~~~~~~~
      |                                      |
      |                                      int
./ell/netlink.h:34:59: note: expected 'struct l_netlink_message *' but
argument is of type 'int'
   34 |                                 struct l_netlink_message *message,
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:365:51: error: passing argument 3 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  365 |                 l_netlink_send(rtnl, RTM_GETLINK, NLM_F_DUMP, rtmmsg,
      |                                                   ^~~~~~~~~~
      |                                                   |
      |                                                   int
./ell/netlink.h:35:58: note: expected 'l_netlink_command_func_t' {aka
'void (*)(int,  short unsigned int,  const void *, unsigned int,  void
*)'} but argument is of type 'int'
   35 |                                 l_netlink_command_func_t function,
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
monitor/main.c:366:41: error: passing argument 5 of 'l_netlink_send'
makes pointer from integer without a cast [-Wint-conversion]
  366 |                                 rta_buf - (void *)rtmmsg,
callback, user_data,
      |                                 ~~~~~~~~^~~~~~~~~~~~~~~~
      |                                         |
      |                                         long int
./ell/netlink.h:37:58: note: expected 'l_netlink_destroy_func_t' {aka
'void (*)(void *)'} but argument is of type 'long int'
   37 |                                 l_netlink_destroy_func_t destroy);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:365:17: error: too many arguments to function 'l_netlink_send'
  365 |                 l_netlink_send(rtnl, RTM_GETLINK, NLM_F_DUMP, rtmmsg,
      |                 ^~~~~~~~~~~~~~
./ell/netlink.h:33:14: note: declared here
   33 | unsigned int l_netlink_send(struct l_netlink *netlink,
      |              ^~~~~~~~~~~~~~
make[1]: *** [Makefile:2579: monitor/main.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1742: all] Error 2
=======> ERROR: Building 'iwd.man1722081992any.cards.tar.xz' failed.

Best regards

Daniel
