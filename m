Content-Type: multipart/mixed; boundary="===============6599280702183071993=="
MIME-Version: 1.0
From: Daniel Lin <ephemient@gmail.com>
Subject: Re: [PATCH] src: configure systemd-resolved's MulticastDNS= setting
Date: Thu, 11 Feb 2021 13:04:37 -0500
Message-ID: <1f997b5df5730f363e52fde58d08c50bade87899.camel@gmail.com>
In-Reply-To: <75d6348d-1acd-4460-6aa2-658ffab7ac69@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6599280702183071993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-02-11 at 09:59 -0600, Denis Kenzior wrote:
> Hi Daniel,
> =

> On 2/10/21 5:43 PM, Daniel Lin wrote:
> > When using iwd.conf:[General].EnableNetworkConfiguration=3Dtrue, it
> > is not
> > possible to configure systemd.network:[Network].MulticastDNS=3D as
> > systemd-networkd considers the link to be unmanaged. This patch
> > allows
> > iwd to configure that setting on systemd-resolved directly.
> > ---
> >   src/iwd.config.rst |  7 ++++
> >   src/netconfig.c    |  6 ++++
> >   src/resolve.c      | 83 ++++++++++++++++++++++++++++++++---------
> > -----
> >   src/resolve.h      |  1 +
> >   4 files changed, 73 insertions(+), 24 deletions(-)
> > =

> > diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> > index 0064dfd2..73d41cc0 100644
> > --- a/src/iwd.config.rst
> > +++ b/src/iwd.config.rst
> > @@ -212,6 +212,13 @@ The group ``[Network]`` contains network
> > configuration related settings.
> >   =

> >          If not specified, ``300`` is used as default.
> >   =

> > +   * - MulticastDNS
> > +     - Values: true, false, resolve
> =

> Is there a default?  If so, it should be in bold.  What happens if
> this setting =

> is omitted?

If the setting is omitted, we don't touch the default value. Which
appears to be false, but somebody could patch systemd-resolved to
change that, so I wasn't sure if that should be documented here. I'll
add that though.

> =

> > +
> > +       Configures multicast DNS. See ``man 5 systemd.network`` for
> > details.
> > +
> > +       Only applies when ``NameResolvingService=3Dsystemd``.
> > +
> >   Blacklist
> >   ---------
> >   =

> > diff --git a/src/netconfig.c b/src/netconfig.c
> > index cf092b78..749ba0ad 100644
> > --- a/src/netconfig.c
> > +++ b/src/netconfig.c
> > @@ -963,6 +963,8 @@ bool netconfig_configure(struct netconfig
> > *netconfig,
> >   				const uint8_t *mac_address,
> >   				netconfig_notify_func_t notify, void
> > *user_data)
> >   {
> > +	char *mdns;
> > +
> >   	netconfig->dns4_overrides =3D
> > l_settings_get_string_list(active_settings,
> >   							"IPv4", "DNS",
> > ' ');
> >   =

> > @@ -1006,6 +1008,10 @@ bool netconfig_configure(struct netconfig
> > *netconfig,
> >   =

> >   	netconfig_ipv6_select_and_install(netconfig);
> >   =

> > +	mdns =3D l_settings_get_string(active_settings, "Network",
> > "MulticastDNS");
> =

> This can return NULL if no MulticastDNS setting is found.  What
> happens then?

Nothing happens, there's a null check in resolve_set_mdns().

> =

> > +	resolve_set_mdns(netconfig->resolve, mdns);
> > +	l_free(mdns);
> > +
> >   	return true;
> >   }
> >   =

> > diff --git a/src/resolve.c b/src/resolve.c
> > index d3b483a8..993bbf34 100644
> > --- a/src/resolve.c
> > +++ b/src/resolve.c
> > @@ -40,6 +40,7 @@
> >   struct resolve_ops {
> >   	void (*set_dns)(struct resolve *resolve, char **dns_list);
> >   	void (*set_domains)(struct resolve *resolve, char
> > **domain_list);
> > +	void (*set_mdns)(struct resolve *resolve, char *mdns);
> =

> should probably be const char *mdns

OK. Shouldn't the nearby `char **` parameters be `const char *const *`
too, then?

> =

> >   	void (*revert)(struct resolve *resolve);
> >   	void (*destroy)(struct resolve *resolve);
> >   };
> > @@ -78,6 +79,17 @@ void resolve_set_domains(struct resolve
> > *resolve, char **domain_list)
> >   	resolve->ops->set_domains(resolve, domain_list);
> >   }
> >   =

> > +void resolve_set_mdns(struct resolve *resolve, char *mdns)
> > +{
> > +	if (!mdns)
> > +		return;
> > +
> > +	if (!resolve->ops->set_mdns)
> > +		return;
> > +
> > +	resolve->ops->set_mdns(resolve, mdns);
> > +}
> > +
> >   void resolve_revert(struct resolve *resolve)
> >   {
> >   	if (!resolve->ops->revert)
> > @@ -112,9 +124,10 @@ struct systemd {
> >   	struct resolve super;
> >   };
> >   =

> > -static void systemd_link_dns_reply(struct l_dbus_message *message,
> > +static void systemd_link_generic_reply(struct l_dbus_message
> > *message,
> >   								void
> > *user_data)
> >   {
> > +	const char *type =3D user_data;
> >   	const char *name;
> >   	const char *text;
> >   =

> > @@ -123,8 +136,8 @@ static void systemd_link_dns_reply(struct
> > l_dbus_message *message,
> >   =

> >   	l_dbus_message_get_error(message, &name, &text);
> >   =

> > -	l_error("resolve-systemd: Failed to modify the DNS entries. %s:
> > %s",
> > -								name,
> > text);
> > +	l_error("resolve-systemd: Failed to modify the %s entries. %s:
> > %s",
> > +								type,
> > name, text);
> >   }
> >   =

> >   static bool systemd_builder_add_dns(struct l_dbus_message_builder
> > *builder,
> > @@ -205,23 +218,8 @@ static void resolve_systemd_set_dns(struct
> > resolve *resolve, char **dns_list)
> >   	l_dbus_message_builder_finalize(builder);
> >   	l_dbus_message_builder_destroy(builder);
> >   =

> > -	l_dbus_send_with_reply(dbus_get_bus(), message,
> > systemd_link_dns_reply,
> > -								NULL,
> > NULL);
> > -}
> > -
> > -static void systemd_set_link_domains_reply(struct l_dbus_message
> > *message,
> > -								void
> > *user_data)
> > -{
> > -	const char *name;
> > -	const char *text;
> > -
> > -	if (!l_dbus_message_is_error(message))
> > -		return;
> > -
> > -	l_dbus_message_get_error(message, &name, &text);
> > -
> > -	l_error("resolve-systemd: Failed to modify the domain entries.
> > %s: %s",
> > -								name,
> > text);
> > +	l_dbus_send_with_reply(dbus_get_bus(), message,
> > systemd_link_generic_reply,
> > +								"DNS",
> > NULL);
> >   }
> >   =

> >   static void resolve_systemd_set_domains(struct resolve *resolve,
> > @@ -266,8 +264,43 @@ static void resolve_systemd_set_domains(struct
> > resolve *resolve,
> >   	l_dbus_message_builder_finalize(builder);
> >   	l_dbus_message_builder_destroy(builder);
> >   =

> > -	l_dbus_send_with_reply(dbus_get_bus(), message,
> > -				systemd_set_link_domains_reply, NULL,
> > NULL);
> > +	l_dbus_send_with_reply(dbus_get_bus(), message,
> > systemd_link_generic_reply,
> > +				"domains", NULL);
> > +}
> > +
> > +static void resolve_systemd_set_mdns(struct resolve *resolve, char
> > *mdns)
> > +{
> > +	struct l_dbus_message_builder *builder;
> > +	struct l_dbus_message *message;
> > +
> > +	l_debug("ifindex: %u", resolve->ifindex);
> > +
> > +	if (L_WARN_ON(!systemd_state.is_ready))
> > +		return;
> > +
> > +	message =3D l_dbus_message_new_method_call(dbus_get_bus(),
> > +					SYSTEMD_RESOLVED_SERVICE,
> > +					SYSTEMD_RESOLVED_MANAGER_PATH,
> > +					SYSTEMD_RESOLVED_MANAGER_INTERF
> > ACE,
> > +					"SetLinkMulticastDNS");
> > +
> > +	if (!message)
> > +		return;
> > +
> > +	builder =3D l_dbus_message_builder_new(message);
> > +	if (!builder) {
> > +		l_dbus_message_unref(message);
> > +		return;
> > +	}
> > +
> > +	l_dbus_message_builder_append_basic(builder, 'i', &resolve-
> > >ifindex);
> > +	l_dbus_message_builder_append_basic(builder, 's', mdns);
> > +
> > +	l_dbus_message_builder_finalize(builder);
> > +	l_dbus_message_builder_destroy(builder);
> =

> Using a builder for something this simple is probably overkill.  You
> can replace =

> the last ~12 lines by something like:
> =

> l_dbus_message_set_arguments(message, "is", resolve->ifindex, mdns);

OK.

> =

> > +
> > +	l_dbus_send_with_reply(dbus_get_bus(), message,
> > systemd_link_generic_reply,
> > +								"Multic
> > astDNS", NULL);
> >   }
> >   =

> >   static void resolve_systemd_revert(struct resolve *resolve)
> > @@ -288,8 +321,8 @@ static void resolve_systemd_revert(struct
> > resolve *resolve)
> >   		return;
> >   =

> >   	l_dbus_message_set_arguments(message, "i", resolve->ifindex);
> > -	l_dbus_send_with_reply(dbus_get_bus(), message,
> > systemd_link_dns_reply,
> > -								NULL,
> > NULL);
> > +	l_dbus_send_with_reply(dbus_get_bus(), message,
> > systemd_link_generic_reply,
> > +								"DNS",
> > NULL);
> >   }
> >   =

> >   static void resolve_systemd_destroy(struct resolve *resolve)
> > @@ -302,6 +335,7 @@ static void resolve_systemd_destroy(struct
> > resolve *resolve)
> >   static const struct resolve_ops systemd_ops =3D {
> >   	.set_dns =3D resolve_systemd_set_dns,
> >   	.set_domains =3D resolve_systemd_set_domains,
> > +	.set_mdns =3D resolve_systemd_set_mdns,
> >   	.revert =3D resolve_systemd_revert,
> >   	.destroy =3D resolve_systemd_destroy,
> >   };
> > @@ -482,6 +516,7 @@ static void resolve_resolvconf_destroy(struct
> > resolve *resolve)
> >   static struct resolve_ops resolvconf_ops =3D {
> >   	.set_dns =3D resolve_resolvconf_set_dns,
> >   	.set_domains =3D resolve_resolvconf_set_domains,
> > +	.set_mdns =3D NULL,
> =

> This should already be NULL, so not needed and can be dropped

OK.

> =

> >   	.revert =3D resolve_resolvconf_revert,
> >   	.destroy =3D resolve_resolvconf_destroy,
> >   };
> > diff --git a/src/resolve.h b/src/resolve.h
> > index 64ed15f3..09cd9ac2 100644
> > --- a/src/resolve.h
> > +++ b/src/resolve.h
> > @@ -23,5 +23,6 @@
> >   struct resolve *resolve_new(uint32_t ifindex);
> >   void resolve_set_dns(struct resolve *resolve, char **dns_list);
> >   void resolve_set_domains(struct resolve *resolve, char
> > **domain_list);
> > +void resolve_set_mdns(struct resolve *resolve, char *mdns);
> >   void resolve_revert(struct resolve *resolve);
> >   void resolve_free(struct resolve *resolve);
> > =


Thanks for the review, I will send an updated patch.

> =

> Regards,
> -Denis

--===============6599280702183071993==--

