Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29946433
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A6E5473182;
	Mon, 27 Nov 2023 15:35:11 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2065:f788:2290:b46] (unknown [IPv6:2601:647:5a00:15c1:2065:f788:2290:b46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3480D7319E;
	Mon, 27 Nov 2023 15:35:11 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: IWD 2.9 Does Not Compile against Linux-4.9.212 and/or GLibC-2.28
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <268d40b9-63a8-4aad-9f02-e9765325ec72@gmail.com>
Date: Mon, 27 Nov 2023 12:35:10 -0800
Cc: iwd@lists.linux.dev,
 Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41A0795F-C7E7-4077-AB15-C6E6711FA6B2@nuovations.com>
References: <29B7EAE3-2BBD-43CA-B2E7-28CE588EE7A2@nuovations.com>
 <268d40b9-63a8-4aad-9f02-e9765325ec72@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 26, 2023, at 7:25 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>>       CC       client/known-networks.o
>>     ${BuildRoot}/third_party/iwd/iwd-2.9/client/known-networks.c:27: =
warning: "_XOPEN_SOURCE" redefined
>>        27 | #define _XOPEN_SOURCE
>=20
> libreadline adds -D_XOPEN_SOURCE to the gcc command line.  Somehow =
newer GCC versions deal with this transparently and don't raise an =
error.  Maybe try
>=20
> #ifndef _XOPEN_SOURCE
> #define _XOPEN_SOURCE
> #endif
>=20
> in client/known-networks.c and report back?  I can't duplicate this on =
my end.

I can confirm this is due to my build system. It is asserted in the =
current build =E2=80=9CFrankenbuild=E2=80=9D such that I can use the Arm =
12.3.1 tool chain that has libasan support against the creaky old =
glibc-2.28 and linux-4.9.212 which would otherwise introduce =
clock_{getres,gettime,settime}64. See "-D_POSIX_C_SOURCE=3D201112L =
-D_DEFAULT_SOURCE -D_XOPEN_SOURCE=E2=80=9D below.

Creating ".build/Makefile/${PRODUCT}/arm/gnu-toolchain/12.3.1/release"
mkdir -p ".build/Makefile/${PRODUCT}/arm/gnu-toolchain/12.3.1/release"
Creating =
".build/Makefile/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/Makefile"
cd .build/Makefile/${PRODUCT}/arm/gnu-toolchain/12.3.1/release && \
    =
PKG_CONFIG_LIBDIR=3D"${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.=
3.1/release/third_party/glib/usr/lib/pkgconfig:${BuildRoot}/results/${PROD=
UCT}/arm/gnu-toolchain/12.3.1/release/third_party/ell/usr/lib/pkgconfig:${=
BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_party=
/dbus/usr/lib/pkgconfig:${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/=
12.3.1/release/third_party/iwd/usr/lib/pkgconfig:${BuildRoot}/results/${PR=
ODUCT}/arm/gnu-toolchain/12.3.1/release/third_party/nftables/usr/lib/pkgco=
nfig" \
    ${BuildRoot}/third_party/iwd/iwd-2.10/configure -C \
    AR=3D"${SYSROOT}/bin/arm-none-linux-gnueabihf-ar" =
CPP=3D"${SYSROOT}/bin/arm-none-linux-gnueabihf-cpp" =
CC=3D"${SYSROOT}/bin/arm-none-linux-gnueabihf-gcc" =
CXX=3D"${SYSROOT}/bin/arm-none-linux-gnueabihf-g++" =
RANLIB=3D"${SYSROOT}/bin/arm-none-linux-gnueabihf-ranlib" =
STRIP=3D"${SYSROOT}/bin/arm-none-linux-gnueabihf-strip" \
    CPPFLAGS=3D"--sysroot=3D${SYSROOT}/arm-none-linux-gnueabihf/libc =
-mcpu=3Dcortex-a8 -mfloat-abi=3Dhard -mfpu=3Dneon =
-D_POSIX_C_SOURCE=3D201112L -D_DEFAULT_SOURCE -D_XOPEN_SOURCE -isystem =
${SYSROOT}/arm-none-linux-gnueabihf/libc/usr/include =
-I${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_p=
arty/linux/linux-dey/include =
-I${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_p=
arty/libnftnl/usr/include =
-I${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_p=
arty/libedit/usr/include" \
    CFLAGS=3D"--sysroot=3D${SYSROOT}/arm-none-linux-gnueabihf/libc =
-mcpu=3Dcortex-a8 -mfloat-abi=3Dhard -mfpu=3Dneon  =
-fno-omit-frame-pointer -fno-strict-aliasing     " \
    LDFLAGS=3D"--sysroot=3D${SYSROOT}/arm-none-linux-gnueabihf/libc     =
" \
    =
ELL_CFLAGS=3D"-I${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/r=
elease/third_party/ell/usr/include" \
    =
ELL_LIBS=3D"-L${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/rel=
ease/third_party/ell/usr/lib/ -lell =
-L${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_p=
arty/ell/usr/lib/ -ldl" \
    =
LIBEDIT_CFLAGS=3D"-I${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3=
.1/release/third_party/libedit/usr/include" \
    =
LIBEDIT_LIBS=3D"-L${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1=
/release/third_party/libedit/usr/lib/ -ledit" \
    --with-sysroot=3D${SYSROOT}/arm-none-linux-gnueabihf/libc \
    --build=3Dx86_64-pc-linux-gnu \
    --host=3Darm-dey-linux-gnueabi \
    --target=3Darm-dey-linux-gnueabi \
    --disable-manual-pages \
    --disable-systemd-service \
    --disable-tools \
    --enable-client \
    --enable-external-ell \
    --enable-libedit \
    --enable-ofono \
    --prefix=3D/usr \
    --sysconfdir=3D/etc \
    --localstatedir=3D/var

>>     <command-line>: note: this is the location of the previous =
definition
>>     ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c: In =
function =E2=80=98display_init=E2=80=99:
>>     ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c:949:44: =
warning: assignment to =E2=80=98void (*)(void)=E2=80=99 from =
incompatible pointer type =E2=80=98void (*)(char **, int,  int)=E2=80=99 =
[-Wincompatible-pointer-types]
>>       949 |         rl_completion_display_matches_hook =3D =
display_completion_matches;
>>           |                                            ^
>=20
> This one is trickier since the signature of the function we provide is =
correct according to libreadline documentation.  What version of =
readline are you using?

I am using libedit 20221030-3.1 in =E2=80=9Creadline=E2=80=9D =
compatibility mode. As Marcel has cited elsewhere, it sort of works but =
has some weirdness on prompt refreshing (as demonstrated on =
=E2=80=98connmanctl=E2=80=99).

>>     In file included from =
${BuildRoot}/third_party/iwd/iwd-2.9/src/adhoc.c:28:
>>     =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:234:34: error: field =
=E2=80=98ifru_addr=E2=80=99 has incomplete type
>>       234 |                 struct  sockaddr ifru_addr;
>>           |                                  ^~~~~~~~~
>>     =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:235:34: error: field =
=E2=80=98ifru_dstaddr=E2=80=99 has incomplete type
>>       235 |                 struct  sockaddr ifru_dstaddr;
>>           |                                  ^~~~~~~~~~~~
>>     =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:236:34: error: field =
=E2=80=98ifru_broadaddr=E2=80=99 has incomplete type
>>       236 |                 struct  sockaddr ifru_broadaddr;
>>           |                                  ^~~~~~~~~~~~~~
>>     =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:237:34: error: field =
=E2=80=98ifru_netmask=E2=80=99 has incomplete type
>>       237 |                 struct  sockaddr ifru_netmask;
>>           |                                  ^~~~~~~~~~~~
>>     =
${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_par=
ty/linux/linux-dey/include/linux/if.h:238:34: error: field =
=E2=80=98ifru_hwaddr=E2=80=99 has incomplete type
>>       238 |                 struct  sockaddr ifru_hwaddr;
>>           |                                  ^~~~~~~~~~~
>>     make[2]: *** [Makefile:2539: src/adhoc.o] Error 1
>>     make[2]: *** Waiting for unfinished jobs....
>>     make[1]: *** [Makefile:1713: all] Error 2
>>     make[1]: Leaving directory =
'${BuildRoot}/third_party/iwd/.build/Makefile/${PRODUCT}/arm/gnu-toolchain=
/12.3.1/release'
>>     make: *** [Makefile:110: build] Error 2
>=20
> This should be fixed by the patch I just sent out.

Confirmed; I can now build iwd-2.10 against linux-4.9.212 and glibc-2.28 =
with Arm GNU Toolchain 8.2-2018.11, 10.3-2021.07, 11.3.1, 12.3.1.

Thank you!

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

