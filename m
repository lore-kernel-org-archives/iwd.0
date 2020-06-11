Content-Type: multipart/mixed; boundary="===============4987091823093665889=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] network: delay connect if ANQP has not completed
Date: Thu, 11 Jun 2020 16:29:33 -0500
Message-ID: <16249c41-2520-4927-abba-37484220c8dd@gmail.com>
In-Reply-To: <20200611172628.31815-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4987091823093665889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/11/20 12:26 PM, James Prestwood wrote:
> Using the new station ANQP watch network can delay the connection
> request until after ANQP has finished. Since station may be
> autoconnecting we must also add a check in network_autoconnect
> which prevents it from autoconnecting if we have a pending Connect
> request.
> ---
>   src/network.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> =


<snip>

> @@ -1102,6 +1110,11 @@ static struct l_dbus_message *network_connect_8021=
x(struct network *network,
>   			goto error;
>   		}
>   =

> +		if (network->connect_after_anqp) {
> +			l_dbus_message_unref(network->connect_after_anqp);
> +			network->connect_after_anqp =3D NULL;
> +		}
> +

Hmm, what does this do?

>   		station_connect_network(station, network, bss, message);
>   =

>   		return NULL;
> @@ -1156,6 +1169,19 @@ static struct l_dbus_message *network_connect(stru=
ct l_dbus *dbus,
>   		station_connect_network(station, network, bss, message);
>   		return NULL;
>   	case SECURITY_8021X:
> +		/*
> +		 * If there is an ongoing ANQP request we must wait for that to
> +		 * finish. Save the message and wait for the ANQP watch to
> +		 * fire
> +		 */
> +		if (network->anqp_pending) {
> +			network->connect_after_anqp =3D
> +						l_dbus_message_ref(message);
> +			l_debug("Pending ANQP request, delaying connect to %s",
> +						network->ssid);
> +			return NULL;
> +		}
> +

What if another request comes in during this time?  Shouldn't you block the=
 new =

request with an -EBUSY or something?  Otherwise you leak connect_after_anqp.

>   		if (!network_settings_load(network))
>   			return dbus_error_not_configured(message);
>   =

> @@ -1484,6 +1510,33 @@ static void known_networks_changed(enum known_netw=
orks_event event,
>   	}
>   }
>   =

> +static void anqp_watch_changed(enum station_anqp_state state,
> +				struct network *network, void *user_data)
> +{
> +	network->anqp_pending =3D state =3D=3D STATION_ANQP_STARTED;
> +
> +	if (state =3D=3D STATION_ANQP_FINISHED && network->connect_after_anqp) {
> +		struct l_dbus_message *reply;
> +
> +		l_debug("ANQP complete, resuming connect to %s", network->ssid);
> +
> +		if (!network_settings_load(network))
> +			reply =3D dbus_error_not_configured(
> +						network->connect_after_anqp);
> +		else
> +			reply =3D network_connect_8021x(network,
> +					network_bss_select(network, true),
> +					network->connect_after_anqp);
> +

Hmm, perhaps isolate network->connect_after_anqp in here instead of bleedin=
g the =

details into network_connect_8021x?

Maybe something like:

if (!network_load_settings()) {
	dbus_pending_reply(&network->connect_after_anqp,
			dbus_error_not_configured());
	return;
}

reply =3D network_connect_8021x();
if (reply) {
	struct l_dbus *dbus =3D dbus_get_bus();
	l_dbus_send(dbus, reply);
}

l_dbus_message_unref(network->connect_after_anqp);
network->connect_after_anqp =3D NULL;

> +		if (!reply)
> +			return;
> +
> +		dbus_pending_reply(&network->connect_after_anqp, reply);
> +
> +		return;
> +	}
> +}
> +
>   static void setup_network_interface(struct l_dbus_interface *interface)
>   {
>   	l_dbus_interface_method(interface, "Connect", 0,
> @@ -1517,6 +1570,8 @@ static int network_init(void)
>   	known_networks_watch =3D
>   		known_networks_watch_add(known_networks_changed, NULL, NULL);
>   =

> +	anqp_watch =3D station_add_anqp_watch(anqp_watch_changed, NULL, NULL);
> +
>   	return 0;
>   }
>   =

> @@ -1525,6 +1580,9 @@ static void network_exit(void)
>   	known_networks_watch_remove(known_networks_watch);
>   	known_networks_watch =3D 0;
>   =

> +	station_remove_anqp_watch(anqp_watch);
> +	anqp_watch =3D 0;
> +
>   	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
>   }
>   =

> =


Regards,
-Denis
--===============4987091823093665889==--

