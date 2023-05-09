Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968E391
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 07:12:49 +0000 (UTC)
Received: from smtpclient.apple (p4fefc45b.dip0.t-ipconnect.de [79.239.196.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id C5411CED37
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 09:12:41 +0200 (CEST)
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Warnings with gcc 13.1.1
Message-Id: <DC050DEC-1BBC-4803-B347-CF7A384EA736@holtmann.org>
Date: Tue, 9 May 2023 09:12:41 +0200
To: iwd@lists.linux.dev
X-Mailer: Apple Mail (2.3696.120.41.1.3)

 CC       src/band.o
src/band.c: In function =E2=80=98band_freq_to_ht_chandef=E2=80=99:
src/band.c:1263:9: error: =E2=80=98width=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
1263 |         switch (width) {
     |         ^~~~~~
src/band.c:1202:33: note: =E2=80=98width=E2=80=99 was declared here
1202 |         enum band_chandef_width width;
     |                                 ^~~~~


 CC       src/eap.o
In function =E2=80=98eap_handle_response=E2=80=99,
   inlined from =E2=80=98eap_rx_packet=E2=80=99 at src/eap.c:570:3:
src/eap.c:421:49: error: =E2=80=98vendor_id=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
 421 |         (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) =
&& vendor_type =3D=3D (t))
     |                                       ~~~~~~~~~~^~~~~~~
src/eap.c:533:20: note: in expansion of macro =E2=80=98IS_EXPANDED_RESPONS=
E=E2=80=99
 533 |         } else if (IS_EXPANDED_RESPONSE(our_vendor_id, =
our_vendor_type))
     |                    ^~~~~~~~~~~~~~~~~~~~
src/eap.c: In function =E2=80=98eap_rx_packet=E2=80=99:
src/eap.c:431:18: note: =E2=80=98vendor_id=E2=80=99 was declared here
 431 |         uint32_t vendor_id;
     |                  ^~~~~~~~~
In function =E2=80=98eap_handle_response=E2=80=99,
   inlined from =E2=80=98eap_rx_packet=E2=80=99 at src/eap.c:570:3:
src/eap.c:421:57: error: =E2=80=98vendor_type=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
 421 |         (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) =
&& vendor_type =3D=3D (t))
     |         =
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
src/eap.c:533:20: note: in expansion of macro =E2=80=98IS_EXPANDED_RESPONS=
E=E2=80=99
 533 |         } else if (IS_EXPANDED_RESPONSE(our_vendor_id, =
our_vendor_type))
     |                    ^~~~~~~~~~~~~~~~~~~~
src/eap.c: In function =E2=80=98eap_rx_packet=E2=80=99:
src/eap.c:432:18: note: =E2=80=98vendor_type=E2=80=99 was declared here
 432 |         uint32_t vendor_type;
     |                  ^~~~~~~~~~~


 CC       src/eap.o
In function =E2=80=98eap_handle_response=E2=80=99,
   inlined from =E2=80=98eap_rx_packet=E2=80=99 at src/eap.c:570:3:
src/eap.c:421:57: error: =E2=80=98vendor_type=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
 421 |         (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) =
&& vendor_type =3D=3D (t))
     |         =
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
src/eap.c:533:20: note: in expansion of macro =E2=80=98IS_EXPANDED_RESPONS=
E=E2=80=99
 533 |         } else if (IS_EXPANDED_RESPONSE(our_vendor_id, =
our_vendor_type))
     |                    ^~~~~~~~~~~~~~~~~~~~
src/eap.c: In function =E2=80=98eap_rx_packet=E2=80=99:
src/eap.c:432:18: note: =E2=80=98vendor_type=E2=80=99 was declared here
 432 |         uint32_t vendor_type;
     |                  ^~~~~~~~~~~

