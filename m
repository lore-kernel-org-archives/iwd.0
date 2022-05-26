Content-Type: multipart/mixed; boundary="===============1006621301721366419=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] auto-t: fix eapol_reauth utility
Date: Thu, 26 May 2022 11:25:29 -0500
Message-ID: <f4438fd7-c06d-233f-d5af-2f72bb034afb@gmail.com>
In-Reply-To: 20220524203145.3218063-1-prestwoj@gmail.com

--===============1006621301721366419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/24/22 15:31, James Prestwood wrote:
> This was passing IFNAME=3D along with EAPOL_REAUTH which does not work
> in the context of a hostapd socket where the iface is already implied.
> This fixes that issue as well as resets the events array and actually
> waits for the required events afterwards.
> ---
>   autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py | 3 ---
>   autotests/util/hostapd.py                            | 5 ++++-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============1006621301721366419==--

