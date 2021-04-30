Content-Type: multipart/mixed; boundary="===============8220183867420633413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: Show WEP networks as unsupported
Date: Fri, 30 Apr 2021 13:12:22 -0500
Message-ID: <e0b7a53b-04f8-20f0-c2db-b745f3d1f8f1@gmail.com>
In-Reply-To: <20210430174238.1027448-1-sean.anderson@seco.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8220183867420633413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On 4/30/21 12:42 PM, Sean Anderson wrote:
> WEP networks are not supported by iwd. However, the only indication is the
> message "Operation not supported" while trying to connect. It is not clear
> enough that this is due to intentional lack of support (as opposed to some
> kind of misconfiguration). This patch explicitly lists WEP networks shown
> with get-networks as unsupported. Hopefully this will make it clearer for
> those of us not as familiar with iwd.
> =

> CC: James Prestwood <prestwoj@gmail.com>
> CC: Marcel Holtmann <marcel@holtmann.org>
> CC: Denis Kenzior <denkenz@gmail.com>
> ---
>   client/station.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


This is a nice improvement.  Applied, thanks.

Regards,
-Denis
--===============8220183867420633413==--

