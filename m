Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1313FE9
	for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 037B073105;
	Sun, 26 Nov 2023 17:21:37 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5990:5683:21b8:9188] (unknown [IPv6:2601:647:5a00:15c1:5990:5683:21b8:9188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8534C7311A;
	Sun, 26 Nov 2023 17:21:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: IWD 2.9 Does Not Compile against Linux-4.9.212 and/or GLibC-2.28
Message-Id: <29B7EAE3-2BBD-43CA-B2E7-28CE588EE7A2@nuovations.com>
Date: Sun, 26 Nov 2023 14:21:35 -0800
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

IWD Community:

Over on the connman and ell mailing lists, Marcel and Denis have been =
advocating, rightly so, for iwd over wpa_supplicant for Wi-Fi.

Is there a kernel version expectation of IWD?

For the current project I am engaged on, the kernel is locked at =
linux-4.9.212, glibc-2.28, and GCC 8.2. With that combination, I have =
found any reasonably modern version of IWD fails to build.

Denis and Marcel expediently put in place a few patches to make ell-0.61 =
compile. I suspect a similar set of patches for ell are also applicable =
to iwd:

    make[1]: Entering directory =
'${BuildRoot}/third_party/iwd/.build/Makefile/${PRODUCT}/arm/gnu-toolchain=
/12.3.1/release'
      GEN      ell/shared
      GEN      src/builtin.h
    make --no-print-directory all-am
      CC       client/main.o
      CC       client/adapter.o
      CC       client/agent.o
      CC       client/agent-manager.o
      CC       client/ad-hoc.o
      CC       client/ap.o
      CC       client/command.o
      CC       client/dbus-proxy.o
      CC       client/device.o
      CC       client/display.o
      CC       client/known-networks.o
    ${BuildRoot}/third_party/iwd/iwd-2.9/client/known-networks.c:27: =
warning: "_XOPEN_SOURCE" redefined
       27 | #define _XOPEN_SOURCE
          |=20
    <command-line>: note: this is the location of the previous =
definition
    ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c: In function =
=E2=80=98display_init=E2=80=99:
    ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c:949:44: =
warning: assignment to =E2=80=98void (*)(void)=E2=80=99 from =
incompatible pointer type =E2=80=98void (*)(char **, int,  int)=E2=80=99 =
[-Wincompatible-pointer-types]
      949 |         rl_completion_display_matches_hook =3D =
display_completion_matches;
          |                                            ^
      CC       client/network.o
      CC       client/properties.o
      CC       client/wsc.o
      CC       client/station.o
      CC       client/diagnostic.o
      CC       client/daemon.o
      CC       client/dpp.o
      CC       client/dpp-pkex.o
      CC       client/station-debug.o
      CC       src/util.o
      CC       src/band.o
      CC       monitor/main.o
      CC       monitor/nlmon.o
      CC       monitor/pcap.o
      CC       monitor/display.o
      CC       src/ie.o
      CC       src/wscutil.o
      CC       src/mpdu.o
      CC       src/crypto.o
      CC       src/watchlist.o
      CC       src/eapolutil.o
      CC       src/nl80211cmd.o
      CC       src/p2putil.o
      CC       src/anqputil.o
      CC       src/main.o
      CC       src/netdev.o
      CC       src/wiphy.o
      CC       src/device.o
      CC       src/station.o
      CC       src/dbus.o
      CC       src/eapol.o
      CC       src/handshake.o
      CC       src/scan.o
      CC       src/common.o
      CC       src/agent.o
      CC       src/storage.o
      CC       src/network.o
      CC       src/wsc.o
      CC       src/backtrace.o
      CC       src/knownnetworks.o
      CC       src/rfkill.o
      CC       src/ft.o
      CC       src/ap.o
      CC       src/adhoc.o
      CC       src/sae.o
    In file included from =
${BuildRoot}/third_party/iwd/iwd-2.9/src/adhoc.c:28:
    =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:234:34: error: field =
=E2=80=98ifru_addr=E2=80=99 has incomplete type
      234 |                 struct  sockaddr ifru_addr;
          |                                  ^~~~~~~~~
    =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:235:34: error: field =
=E2=80=98ifru_dstaddr=E2=80=99 has incomplete type
      235 |                 struct  sockaddr ifru_dstaddr;
          |                                  ^~~~~~~~~~~~
    =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:236:34: error: field =
=E2=80=98ifru_broadaddr=E2=80=99 has incomplete type
      236 |                 struct  sockaddr ifru_broadaddr;
          |                                  ^~~~~~~~~~~~~~
    =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:237:34: error: field =
=E2=80=98ifru_netmask=E2=80=99 has incomplete type
      237 |                 struct  sockaddr ifru_netmask;
          |                                  ^~~~~~~~~~~~
    =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:238:34: error: field =
=E2=80=98ifru_hwaddr=E2=80=99 has incomplete type
      238 |                 struct  sockaddr ifru_hwaddr;
          |                                  ^~~~~~~~~~~
    make[2]: *** [Makefile:2539: src/adhoc.o] Error 1
    make[2]: *** Waiting for unfinished jobs....
    make[1]: *** [Makefile:1713: all] Error 2
    make[1]: Leaving directory =
'${BuildRoot}/third_party/iwd/.build/Makefile/${PRODUCT}/arm/gnu-toolchain=
/12.3.1/release'
    make: *** [Makefile:110: build] Error 2

I expect the =E2=80=99sockaddr=E2=80=99 issues to be easily resolved =
with a different set of include directives; however, the rest appear to =
be new symbols introduced in later kernels.

Best,

Grant=
