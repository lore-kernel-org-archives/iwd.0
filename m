Content-Type: multipart/mixed; boundary="===============2538522354376112498=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] station/wsc: remove beacon loss handling
Date: Wed, 04 Nov 2020 13:41:21 -0600
Message-ID: <e72bbb0e-89f3-b38f-fbda-84f558368cca@gmail.com>
In-Reply-To: <20201103205129.2744888-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2538522354376112498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/3/20 2:51 PM, James Prestwood wrote:
> Modern kernels ~5.4+ have changed the way lost beacons are
> reported and effectively make the lost beacon event useless
> because it is immediately followed by a disconnect event. This
> does now allow IWD enough time to do much of anything before
> the disconnect comes in and we are forced to fully re-connect
> to a different AP.
> ---
>   src/station.c | 26 --------------------------
>   src/wsc.c     |  3 ---
>   2 files changed, 29 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2538522354376112498==--

