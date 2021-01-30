Content-Type: multipart/mixed; boundary="===============6021691519660581462=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] ap: Set the group cipher when sending START_AP
Date: Fri, 29 Jan 2021 20:06:04 -0600
Message-ID: <46b52786-6a3d-b673-ba15-2df61c3c7a00@gmail.com>
In-Reply-To: <20210129232740.27393-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6021691519660581462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/29/21 5:27 PM, Andrew Zaborowski wrote:
> Seems this overlooked because an initial version of ap.c didn't have
> group traffic support.  This doesn't fix some brcmfmac problems where it
> silently overrides the group cipher in the beacon frames though.

That last sentence might require  more explanation?

> ---
>   src/ap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> =


This patch is broken though:

src/ap.c: In function =E2=80=98ap_build_cmd_start_ap=E2=80=99:
src/ap.c:2151:6: error: =E2=80=98nl_ciphers=E2=80=99 undeclared (first use =
in this function); =

did you mean =E2=80=98l_cipher=E2=80=99?
  2151 |     &nl_ciphers);
       |      ^~~~~~~~~~
       |      l_cipher
src/ap.c:2151:6: note: each undeclared identifier is reported only once for=
 each

Regards,
-Denis
--===============6021691519660581462==--

