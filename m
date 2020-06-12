Content-Type: multipart/mixed; boundary="===============4424027505572326798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 15:06:42 -0500
Message-ID: <46708151-4965-a49b-963d-8500156bdb06@gmail.com>
In-Reply-To: <20200612191414.13413-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4424027505572326798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/12/20 2:14 PM, James Prestwood wrote:
> Using the new station ANQP watch network can delay the connection
> request until after ANQP has finished. Since station may be
> autoconnecting we must also add a check in network_autoconnect
> which prevents it from autoconnecting if we have a pending Connect
> request.
> ---
>   src/network.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> =


<snip>

> @@ -1102,6 +1110,9 @@ static struct l_dbus_message *network_connect_8021x=
(struct network *network,
>   			goto error;
>   		}
>   =

> +		/* Unset this since we are now ready to connect */
> +		network->connect_after_anqp =3D NULL;
> +

So I moved this NULL setting to...

> +		reply =3D network_connect_8021x(network,
> +					network_bss_select(network, true),
> +					network->connect_after_anqp);
> +
> +		if (reply)
> +			l_dbus_send(dbus_get_bus(), reply);
> +
> +		/*
> +		 * Unref since network_connect_8021x will hold its own ref, but
> +		 * don't NULL this yet because agent requests may be required,
> +		 * and we still want this network to be in a 'pending' type of
> +		 * state so autoconnect doesn't try and connect again.
> +		 */
> +		l_dbus_message_unref(network->connect_after_anqp);

here, and also squashed the now unneeded comment.

And applied this + rest of the series.

Regards,
-Denis
--===============4424027505572326798==--

