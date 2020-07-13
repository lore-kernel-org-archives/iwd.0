Content-Type: multipart/mixed; boundary="===============2930322167884454922=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/18] p2p: Implement the p2p.ServiceManager interface
Date: Mon, 13 Jul 2020 14:47:57 -0500
Message-ID: <e3cee5bf-3d8f-862a-4d71-fc2053399143@gmail.com>
In-Reply-To: <20200711010053.224223-11-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2930322167884454922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 7/10/20 8:00 PM, Andrew Zaborowski wrote:
> The net.connman.iwd.p2p.ServiceManager interface on the /net/connman/iwd
> object lets user applications register/unregister the Wi-Fi Display
> service.  In this commit all this does is it adds local WFD information
> as given by the app, to the frames we send out during discovery.
> =

> Instead of accepting raw WFD IE contents from the app and exposing
> peers' raw WFD IEs to the app, we build the WFD IEs in our code based on
> the few meaningful DBus properties that we support and using default
> values for the rest.  If an app ever needs any of the other WFD
> capabilities more properties can be added.
> ---
>   src/dbus.h |   1 +
>   src/p2p.c  | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 293 insertions(+), 10 deletions(-)
> =


<snip>

> +static void p2p_svc_mgr_destroy_cb(void *user_data)

Can we name this p2p_service_manager_destroy instead?  The manager -> short=
ened =

form conversion is not really natural and leads to many possibilities, mgr, =

mngr, etc.  Similar with service -> 'svc', 'srvc', etc  You're only saving =
a few =

characters, so lets just type these out.

> +{
> +	if (p2p_own_wfd) {
> +		l_dbus_remove_watch(dbus_get_bus(), p2p_wfd_disconnect_watch);
> +		p2p_own_wfd_free();
> +	}
> +}
> +
>   static int p2p_init(void)
>   {
> -	if (!l_dbus_register_interface(dbus_get_bus(),
> -					IWD_P2P_INTERFACE,
> +	struct l_dbus *dbus =3D dbus_get_bus();
> +
> +	if (!l_dbus_register_interface(dbus, IWD_P2P_INTERFACE,
>   					p2p_interface_setup,
>   					NULL, false))
>   		l_error("Unable to register the %s interface",
>   			IWD_P2P_INTERFACE);
>   =

> -	if (!l_dbus_register_interface(dbus_get_bus(),
> -					IWD_P2P_PEER_INTERFACE,
> +	if (!l_dbus_register_interface(dbus, IWD_P2P_PEER_INTERFACE,
>   					p2p_peer_interface_setup,
>   					NULL, false))
>   		l_error("Unable to register the %s interface",
> @@ -3573,13 +3842,26 @@ static int p2p_init(void)
>   	p2p_dhcp_settings =3D l_settings_new();
>   	p2p_device_list =3D l_queue_new();
>   =

> +	if (!l_dbus_register_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTERFACE,
> +					p2p_svc_mgr_interface_setup,
> +					p2p_svc_mgr_destroy_cb, false))
> +		l_error("Unable to register the %s interface",
> +			IWD_P2P_SERVICE_MANAGER_INTERFACE);
> +	else if (!l_dbus_object_add_interface(dbus, IWD_AGENT_MANAGER_PATH,

Hmm, why IWD_AGENT_MANAGER_PATH?

> +					IWD_P2P_SERVICE_MANAGER_INTERFACE,
> +					NULL))
> +		l_error("Unable to register the P2P Service Manager object");
> +
>   	return 0;
>   }
>   =

>   static void p2p_exit(void)
>   {
> -	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_INTERFACE);
> -	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_PEER_INTERFACE);
> +	struct l_dbus *dbus =3D dbus_get_bus();

Also, do you need a corresponding l_dbus_object_remove_interface here?  And=
 I =

suppose that agent.c might need to be updated not to call =

l_dbus_unregister_object now that you are adding another interface to the s=
ame path.

> +
> +	l_dbus_unregister_interface(dbus, IWD_P2P_INTERFACE);
> +	l_dbus_unregister_interface(dbus, IWD_P2P_PEER_INTERFACE);
> +	l_dbus_unregister_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTERFACE);
>   	l_queue_destroy(p2p_device_list, p2p_device_free);
>   	p2p_device_list =3D NULL;
>   	l_settings_free(p2p_dhcp_settings);
> =


Regards,
-Denis
--===============2930322167884454922==--

