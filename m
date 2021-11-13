Content-Type: multipart/mixed; boundary="===============7903576107219398861=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 4/9] agent: Implement the NetworkConfigurationAgent dbus
 API
Date: Sat, 13 Nov 2021 02:31:03 +0100
Message-ID: <CAOq732+pKD78YpgyaSFC_x9pVMDk1qJrswEzfdrvSM+wmMNdsw@mail.gmail.com>
In-Reply-To: 3d580080-e7d3-0c6a-cb9d-8aac92378558@gmail.com

--===============7903576107219398861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Nov 2021 at 20:48, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 11/8/21 5:28 AM, Andrew Zaborowski wrote:
> > +enum agent_type {
> > +     AGENT_TYPE_SECRET,
> > +     AGENT_TYPE_NETCONFIG,
> > +};
> > +
>
> Have you considered using agent_ops, container_of, or simply an agent_free
> version for the netconfig agent?  Given that there can be only one netcon=
fig
> agent, this enum seems overkill.

Ok, I use a "container" struct around struct agent.  Or if we use both
a separate agent_free() and send_cancel_request() then it may be
easier to have completely separate structs too.  The agent_ops
approach seems like a bigger gun than this enum.

>
> >   enum agent_request_type {
> >       AGENT_REQUEST_TYPE_PASSPHRASE,
> >       AGENT_REQUEST_TYPE_USER_NAME_PASSWD,
> > @@ -50,6 +57,18 @@ struct agent_request {
> >       agent_request_destroy_func_t destroy;
> >   };
> >
> > +/* Netconfig requests are not queued and can run in parallel */
> > +struct netconfig_request {
> > +     unsigned int dbus_id;
> > +     unsigned int id;
> > +     char *path;
>
> Is path and ifname correspond to the same device object?  Maybe you shoul=
d use
> that instead?

The path (in station case) is to the network object same as when we
ask for the PSK.

>
> > +     char *ifname;
> > +     struct l_timeout *timeout;
>
> Remember that each timeout corresponds to an open fd.  Are you sure this =
is
> necessary?

We use this timeout in place of the one in "struct agent".  What we
could do is use one actual timeout and keep re-arming it for new
expiry times, but then I think this would be better done directly in
ell if we want to save fds.

>
> > +     void *user_data;
> > +     void *user_callback;
> > +     agent_request_destroy_func_t destroy;
> > +};
> > +
> >   struct agent {
> >       char *owner;
> >       char *path;
> > @@ -58,9 +77,11 @@ struct agent {
> >       struct l_timeout *timeout;
> >       int timeout_secs;
> >       struct l_queue *requests;
> > +     enum agent_type type;
> >   };
> >
> > -static struct l_queue *agents;
> > +static struct l_queue *secret_agents;
> > +static struct agent *netconfig_agent;
> >
> >   /*
> >    * How long we wait for user to input things.
> > @@ -74,7 +95,8 @@ static unsigned int agent_timeout_input_request(void)
> >       return 120;
> >   }
> >
> > -static void send_cancel_request(void *user_data, int reason)
> > +static void send_cancel_request(void *user_data, int reason,
> > +                             const char *path, const char *ifname)
> >   {
> >       struct agent *agent =3D user_data;
> >       struct l_dbus_message *message;
> > @@ -106,7 +128,12 @@ static void send_cancel_request(void *user_data, i=
nt reason)
> >                                                       IWD_AGENT_INTERFA=
CE,
> >                                                       "Cancel");
> >
> > -     l_dbus_message_set_arguments(message, "s", reasonstr);
> > +     if (path)
> > +             l_dbus_message_set_arguments(message, "oss", path, ifname,
> > +                                             reasonstr);
> > +     else
> > +             l_dbus_message_set_arguments(message, "s", reasonstr);
> > +
>
> Please don't do this.  Seeing send_cancel_request(foo, reason, NULL, NULL=
) is
> quite confusing.  Use a separate method for this.

Ok.

> > +static void netconfig_timeout_cb(struct l_timeout *timeout, void *user=
_data)
> > +{
> > +     struct netconfig_request *request =3D user_data;
> > +     agent_request_netconfig_func_t user_callback =3D request->user_ca=
llback;
> > +
> > +     l_debug("path %s ifname %s", request->path, request->ifname);
> > +
> > +     l_queue_remove(netconfig_agent->requests, request);
> > +
> > +     send_cancel_request(netconfig_agent, -ETIMEDOUT,
> > +                             request->path, request->ifname);
> > +
> > +     user_callback(request->id, AGENT_RESULT_FAILED, request->user_dat=
a);
> > +     netconfig_request_free(request);
>
> We only care about results/timeouts in a very specific case (to signal we=
're
> connected).  In theory, all subsequent updates might as well be sent with=
 noreply.

True, that would also save fds, but it may be better to not hardcode
this assumption in agent.c.

>
> How do you plan to handle situations where a change is requested while an
> ongoing transaction is in progress?  For example, a change to wlan0 AF_IN=
ET is
> pending, and another wlan0 AF_INET change is requested?  It shouldn't rea=
lly
> happen, but the agent backend timing is outside of our control.

Right, my idea was that this result in simultaneous ConfigureIPvX
calls running and the agent has to see if that poses a problem for
them.

> > @@ -479,11 +683,27 @@ bool agent_request_cancel(unsigned int req_id, in=
t reason)
> >                       break;
> >       }
> >
> > -     if (!request)
> > -             return false;
> > +     if (!request) {
> > +             struct netconfig_request *nc_request;
> > +
> > +             if (!netconfig_agent)
> > +                     return false;
> > +
> > +             nc_request =3D l_queue_remove_if(netconfig_agent->request=
s,
> > +                                             find_netconfig_request,
> > +                                             L_UINT_TO_PTR(req_id));
> > +             if (!nc_request)
> > +                     return false;
> > +
> > +             send_cancel_request(netconfig_agent, reason,
> > +                                     nc_request->path, nc_request->ifn=
ame);
> > +
> > +             netconfig_request_free(nc_request);
> > +             return true;
> > +     }
> >
> >       if (!request->message) {
> > -             send_cancel_request(agent, reason);
> > +             send_cancel_request(agent, reason, NULL, NULL);
> >
> >               l_dbus_cancel(dbus_get_bus(), agent->pending_id);
> >
>
> Just make this a separate function, there's almost no reuse here anyway.

Ok.

>
> > @@ -511,18 +731,19 @@ static void agent_disconnect(struct l_dbus *dbus,=
 void *user_data)
> >       if (agent->pending_id)
> >               agent_finalize_pending(agent, NULL);
> >
> > -     l_queue_remove(agents, agent);
> > +     l_queue_remove(secret_agents, agent);
> >
> >       l_idle_oneshot(agent_free, agent, NULL);
>
> What about the netconfig agent?

Good point..

>
> >   }
> >
>
> <snip>
>
> > diff --git a/src/agent.h b/src/agent.h
> > index eb08c6b6..83625618 100644
> > --- a/src/agent.h
> > +++ b/src/agent.h
> > @@ -25,8 +25,11 @@
> >   enum agent_result {
> >       AGENT_RESULT_OK,
> >       AGENT_RESULT_FAILED,
> > +     AGENT_RESULT_CANCELLED,
>
> I think we prefer 'CANCELED'

Ok.

>
> >   };
> >
>
> <snip>
>
> > diff --git a/src/netconfig.h b/src/netconfig.h
> > index c9ac6f8f..48018bc1 100644
> > --- a/src/netconfig.h
> > +++ b/src/netconfig.h
> > @@ -28,6 +28,21 @@ enum netconfig_event {
> >       NETCONFIG_EVENT_CONNECTED,
> >   };
> >
> > +enum netconfig_method {
> > +     NETCONFIG_METHOD_STATIC,
> > +     NETCONFIG_METHOD_AUTO,
> > +};
> > +
> > +struct netconfig_data {
> > +     uint8_t family;
> > +     enum netconfig_method method;
> > +     char *addr;
> > +     uint8_t prefix_len;
> > +     char *gateway_addr;
> > +     char **dns;
> > +     char **domain_names;
> > +};
> > +
>
> Since we want to introduce the 'netconfig settings applier entity', I'd s=
ay the
> netconfig version of this structure should use l_rtnl_* objects.  That wa=
y, both
> the 'immediate' and 'agent' backends for that entity can operate on the s=
ame input.
>
> If you want to introduce a separate structure for agent use, then it shou=
ld
> probably be declared inside agent.h.

Ok, let's see which works better.

Best regards
--===============7903576107219398861==--

