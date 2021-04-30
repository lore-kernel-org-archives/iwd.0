Content-Type: multipart/mixed; boundary="===============4450847995505806987=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v6 1/3] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 13:10:19 -0500
Message-ID: <b23d84d6-7354-4571-05c2-dd85eac3d74f@gmail.com>
In-Reply-To: <20210430174704.272253-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4450847995505806987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/30/21 12:47 PM, James Prestwood wrote:
> FT-over-DS followed the same pattern as FT-over-Air which worked,
> but really limited how the protocol could be used. FT-over-DS is
> unique in that we can authenticate to many APs by sending out
> FT action frames and parsing the results. Once parsed IWD can
> immediately Reassociate, or do so at a later time.
> =

> To take advantage of this IWD need to separate FT-over-DS into
> two stages: action frame and reassociation.
> =

> The initial action frame stage is started by netdev. The target
> BSS is sent an FT action frame and a new cache entry is created
> in ft.c. Once the response is received the entry is updated
> with all the needed data to Reassociate. To limit the record
> keeping on netdev each FT-over-DS entry holds a userdata pointer
> so netdev doesn't need to maintain its own list of data for
> callbacks.
> =

> Once the action response is parsed netdev will call back signalling
> the action frame sequence was completed (either successfully or not).
> At this point the 'normal' FT procedure can start using the
> FT-over-DS auth-proto.
> ---
>   src/ft.c     |  74 ++----------------
>   src/ft.h     |   1 -
>   src/netdev.c | 211 ++++++++++++++++++++++++++++++++++++++++-----------
>   src/netdev.h |   8 ++
>   4 files changed, 184 insertions(+), 110 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============4450847995505806987==--

