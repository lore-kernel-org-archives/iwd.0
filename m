Content-Type: multipart/mixed; boundary="===============5914007111498639803=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/5] station: commonize the building of diagnostic dict
Date: Thu, 21 Jan 2021 14:08:17 -0600
Message-ID: <ea1a986d-a37c-f7d9-8ebd-45793a9213c1@gmail.com>
In-Reply-To: <20210121181113.572092-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5914007111498639803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/21/21 12:11 PM, James Prestwood wrote:
> AP mode will use the same structure for its diagnostic interface
> and mostly the same dictionary keys. Apart from ConnectedBss and
> Address being different, the remainder are the same so the
> netdev_station_info to DBus dictionary conversion has been made
> common so both station and AP can use it to build its diagnostic
> dictionaries.
> ---
>   src/station.c | 71 ++++++++++++++++++++++++++++++---------------------
>   src/station.h |  3 +++
>   2 files changed, 45 insertions(+), 29 deletions(-)
> =

> v2:
>   * Generalized the dictionary building so both station and AP could
>     use it.
> =


<snip>

> +
> +bool station_info_to_dict(const struct netdev_station_info *info,
> +				struct l_dbus_message_builder *builder);
> =


This doesn't feel right to have ap (and possibly p2p, adhoc, etc) depend on =

station for this.  Can we move the netdev_station_info structure definition=
 to =

src/common.h or maybe diagnostic.h (diagnostic_station_info?) or so and add=
 this =

to diagnostic.[ch] instead?

Regards,
-Denis
--===============5914007111498639803==--

