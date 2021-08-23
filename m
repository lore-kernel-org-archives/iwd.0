Content-Type: multipart/mixed; boundary="===============4985509297221958071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd 1.17 test suite is failing
Date: Mon, 23 Aug 2021 08:58:54 -0500
Message-ID: <c4b50311-84ab-236a-e3cd-49371a9d7eb4@gmail.com>
In-Reply-To: <CABB28CwPkyQcCrznB2MbEGN5TKMoSvCnaPH5DSY5SJ-YaJe47w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4985509297221958071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

On 8/22/21 1:55 PM, Tomasz K=C5=82oczko wrote:
> Hi,
> =

> I think that it started around 1.15.
> iwd and eel compiled with LTO.
> =

> [tkloczko(a)barrel iwd-1.17]$ make check
> make --no-print-directory check-am
> make --no-print-directory check-TESTS
> PASS: unit/test-cmac-aes
> PASS: unit/test-hmac-md5
> PASS: unit/test-hmac-sha1
> PASS: unit/test-hmac-sha256
> PASS: unit/test-prf-sha1
> PASS: unit/test-kdf-sha256
> PASS: unit/test-crypto
> ./build-aux/test-driver: line 107: 3860965 Aborted =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (core dumped) =

> "$@" > $log_file 2>&1
> FAIL: unit/test-eapol

There was indeed a failure that slipped through the cracks.  This was due t=
o the =

test not being updated and is now fixed upstream with commit ed10b00afa3f =

("unit: Fix eapol IP Allocation test failure")

> PASS: unit/test-mpdu
> PASS: unit/test-ie
> PASS: unit/test-util
> PASS: unit/test-ssid-security
> PASS: unit/test-arc4
> PASS: unit/test-wsc
> PASS: unit/test-eap-mschapv2
> PASS: unit/test-eap-sim
> /bin/sh ./libtool =C2=A0--tag=3DCC =C2=A0 --mode=3Dlink /usr/bin/gcc =C2=
=A0-fvisibility=3Dhidden =

> -DUNITDIR=3D\""./unit/"\" -DCERTDIR=3D\""./unit/"\" =C2=A0-O2 -g -grecord=
-gcc-switches =

> -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 =

> -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc=
1 =

> -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 =
-m64 =

> -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection =

> -fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto =

> -flto-partition=3Dnone -Os -Wl,-wrap,l_ecc_supported_ike_groups -Wl,-z,re=
lro =

> -Wl,--as-needed -Wl,--gc-sections -Wl,-z,now =

> -specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld -flto=3Dauto -flto-partit=
ion=3Dnone =

> -fuse-linker-plugin -o unit/test-sae unit/test-sae.o src/sae.o src/crypto=
.o =

> src/ie.o src/handshake.o src/erp.o src/util.o src/mpdu.o -lell
> libtool: link: /usr/bin/gcc -fvisibility=3Dhidden -DUNITDIR=3D\"./unit/\" =

> -DCERTDIR=3D\"./unit/\" -O2 -g -grecord-gcc-switches -pipe -Wall =

> -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERT=
IONS =

> -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong =

> -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric =

> -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection =

> -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -=
Os =

> -Wl,-wrap -Wl,l_ecc_supported_ike_groups -Wl,-z -Wl,relro -Wl,--as-needed =

> -Wl,--gc-sections -Wl,-z -Wl,now -specs=3D/usr/lib/rpm/redhat/redhat-hard=
ened-ld =

> -flto=3Dauto -flto-partition=3Dnone -fuse-linker-plugin -o unit/test-sae =

> unit/test-sae.o src/sae.o src/crypto.o src/ie.o src/handshake.o src/erp.o =

> src/util.o src/mpdu.o =C2=A0-lell
> /usr/bin/ld: /tmp/cc8uiWzL.lto.o: in function `sae_choose_next_group':
> /home/tkloczko/rpmbuild/BUILD/iwd-1.17/src/sae.c:139: undefined reference=
 to =

> `__wrap_l_ecc_supported_ike_groups'
> /usr/bin/ld: /tmp/cc8uiWzL.lto.o: in function `handshake_state_free':
> /home/tkloczko/rpmbuild/BUILD/iwd-1.17/src/handshake.c:48: undefined refe=
rence =

> to `__wrap_l_ecc_supported_ike_groups'
> /usr/bin/ld: /tmp/cc8uiWzL.lto.o: in function `sae_rx_authenticate':
> /home/tkloczko/rpmbuild/BUILD/iwd-1.17/src/sae.c:161: undefined reference=
 to =

> `__wrap_l_ecc_supported_ike_groups'

This would have shown up earliest at iwd 1.16.  However, I'm not sure what =
this =

is about?  We use
unit_test_sae_LDFLAGS =3D -Wl,-wrap,l_ecc_supported_ike_groups

Perhaps LTO somehow interferes with that?  ell has a unit test that uses th=
e =

same mechanism for quite some time...

> =

> BTW is it possible to organize iwd/eel mirrors on github/gitlab to be abl=
e =

> submit such an issue without being forced to subscribe to yet another mai=
ling =

> list or put in README files details how to submit the issue?
> =


We'll look into it.

Regards,
-Denis
--===============4985509297221958071==--

