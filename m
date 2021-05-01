Content-Type: multipart/mixed; boundary="===============4680298407465574391=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] client: Show WEP networks as unsupported
Date: Sat, 01 May 2021 04:32:29 +0200
Message-ID: <7294ACCB-50D7-4D0B-81D1-A1C7DBE48C0A@holtmann.org>
In-Reply-To: <20210430174238.1027448-1-sean.anderson@seco.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4680298407465574391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

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
> client/station.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> =

> diff --git a/client/station.c b/client/station.c
> index de25d12b..425b10a1 100644
> --- a/client/station.c
> +++ b/client/station.c
> @@ -352,7 +352,7 @@ static void ordered_networks_display(struct l_queue *=
ordered_networks)
> =

> 	display_table_header("Available networks", "%s%-*s%-*s%-*s%*s",
> 					MARGIN, 2, "", 32, "Network name",
> -					10, "Security", 6, "Signal");
> +					18, "Security", 6, "Signal");
> =

> 	if (!l_queue_length(ordered_networks)) {
> 		display("No networks available\n");
> @@ -369,13 +369,16 @@ static void ordered_networks_display(struct l_queue=
 *ordered_networks)
> 		const char *network_name =3D network_get_name(network_i);
> 		const char *network_type =3D network_get_type(network_i);
> =

> +		if (!strcmp(network_type, "wep"))
> +			network_type =3D "wep (unsupported)";
> +

this is kinda neat, but I wonder if iwd itself should just stop reporting W=
EP networks. It is actually a bad idea to report something that we can neve=
r (and never will) connect to.

Unless of course we show them as =E2=80=9Copen=E2=80=9D and break the WEP k=
ey on the fly ;)

Regards

Marcel

--===============4680298407465574391==--

