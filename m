Content-Type: multipart/mixed; boundary="===============5495728850404883085=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: always register for single CQM threshold
Date: Wed, 10 Feb 2021 12:09:55 -0600
Message-ID: <21f2272e-0c8d-95cb-5877-ceb41a8743e7@gmail.com>
In-Reply-To: <20210210000447.775876-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5495728850404883085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/9/21 6:04 PM, James Prestwood wrote:
> If the extended feature for CQM levels was not supported no CQM
> registration would happen, not even for a single level. This
> caused IWD to completely lose the ability to roam since it would
> only get notified when the kernel was disconnecting, around -90
> dBm, not giving IWD enough time to roam.
> =

> Instead if the extended feature is not supported we can still
> register for the event, just without multiple signal levels.
> ---
>   src/netdev.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5495728850404883085==--

