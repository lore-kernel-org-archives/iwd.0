Content-Type: multipart/mixed; boundary="===============0817477362640060688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] netdev: update the netdev's frequency on channel
 switch events
Date: Thu, 05 Aug 2021 10:37:06 -0500
Message-ID: <e48891c4-b5df-69f3-a8df-8c58f8c57449@gmail.com>
In-Reply-To: <20210805154024.3019732-1-alvin@pqrs.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0817477362640060688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 8/5/21 10:40 AM, Alvin =C5=A0ipraga wrote:
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> =

> While we correctly emit a NETDEV_EVENT_CHANNEL_SWITCHED event from
> netdev for other modules to respond to, we fail to actually update the
> frequency of the netdev object in question. Since the netdev frequency
> is used elsewhere (e.g. to send action frames), it needs updating too.
> =

> Fixes: 5eb0b7ca8e04 ("netdev: add a channel switch event")
> ---
>   src/netdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============0817477362640060688==--

