Content-Type: multipart/mixed; boundary="===============2057889121448106331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] wsc: Refactor to make the DBus interface reusable
Date: Tue, 07 Jan 2020 10:30:50 -0600
Message-ID: <801f0705-a12d-fe74-cc84-4b3d30f2257e@gmail.com>
In-Reply-To: <CAOq732Kd=cJacmg_76BQ4n-S9qz5MO=RQdapuKnRTw7_mDpSEw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2057889121448106331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/6/20 8:55 PM, Andrew Zaborowski wrote:
> On Mon, 6 Jan 2020 at 23:00, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 12/18/19 9:50 PM, Andrew Zaborowski wrote:
>>> @@ -210,8 +210,6 @@ static void wsc_disconnect_cb(struct netdev *netdev=
, bool success,
>>>
>>>        l_debug("%p, success: %d", wsc, success);
>>>
>>> -     wsc->wsc_association =3D false;
>>> -
>>>        reply =3D l_dbus_message_new_method_return(wsc->pending_cancel);
>>>        l_dbus_message_set_arguments(reply, "");
>>>        dbus_pending_reply(&wsc->pending_cancel, reply);
>>
>> Is this chunk a straggler from some earlier refactoring?  If so, then a
>> separate patch would be desirable
> =

> So in the new setup we have parts of wsc.c that are common between the
> Station mode use case and the external user use case (i.e. P2P), and
> then we have parts that are relevant to Station mode only.  We sort of
> have 3 parts:
> =

> 1. the core part that sets up the EAP method config, starts the
> connection and receives the credentials.
> 2. the DBus interface that lives even when we're not doing WSC (also
> common to both modes now)
> 3. the Station-specific code which interfaces between 1. and 2. and
> does the scanning etc., i.e. everything used by @wsc_device_ops
> =

> wsc_disconnect_cb belongs in 3., while wsc->wsc_association belongs in
> 2. so wsc_disconnect_cb shouldn't be touching wsc->wsc_association.

Not quite sure I follow.  wsc_disconnect_cb is called when cancel is =

invoked via D-Bus API (or in your proposal it would be invoked via =

wsc_cancel).  wsc->association tracks whether we have a connection =

established for the purposes of EAP-WSC.  Hence if wsc->association is =

true, we have to disconnect it first.  I see these two as inherently linked?

> It's being set to false in wsc_connect_cleanup which now gets called
> from wsc_cancel before wsc_disconnect_cb.  I think that the
> netdev_disconnect call also triggers an immediate wsc_connect_cb
> callback which also calls wsc_connect_cleanup, so wsc->wsc_association
> would have been always false.

Right.  The intent was for connect callback to be called with aborted or =

whatever and have that clean up the state.  You end up calling =

wsc_connect_cleanup multiple times.  This is probably okay, but seems =

unnecessary.

> =

>>
>> <snip>
>>
>>> @@ -525,40 +523,19 @@ static void wsc_connect(struct wsc *wsc)
>>>    error:
>>>        handshake_state_free(hs);
>>>        wsc_connect_cleanup(wsc);
>>> -     wsc->done_cb(r, NULL, 0, wsc->done_data);
>>> +     wsc->ops->enrollee_done_cb(r, NULL, 0, wsc->user_data);
>>>    }
>>>
>>> -/* Done callback for when WSC is triggered by DBus methods */
>>> -static void wsc_dbus_done_cb(int err, struct wsc_credentials_info *cre=
ds,
>>> -                             unsigned int n_creds, void *user_data)
>>> +static void wsc_connect_set_method(struct wsc *wsc)
>>>    {
>>> -     struct wsc *wsc =3D user_data;
>>> -
>>> -     l_debug("err=3D%i", err);
>>> +     const char *pin;
>>>
>>> -     switch (err) {
>>> -     case 0:
>>> -             break;
>>> -     case -ECANCELED:
>>> -             dbus_pending_reply(&wsc->pending,
>>> -                                     dbus_error_aborted(wsc->pending));
>>> -             return;
>>> -     case -ENOKEY:
>>> -             dbus_pending_reply(&wsc->pending,
>>> -                                     wsc_error_no_credentials(wsc->pen=
ding));
>>> -             return;
>>> -     case -EBUSY:
>>> -             dbus_pending_reply(&wsc->pending,
>>> -                                     dbus_error_busy(wsc->pending));
>>> -             return;
>>> -     default:
>>> -             dbus_pending_reply(&wsc->pending,
>>> -                                     dbus_error_failed(wsc->pending));
>>> -             return;
>>> -     }
>>> +     if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin"))
>>> +             l_dbus_message_get_arguments(wsc->pending, "s", &pin);
>>> +     else
>>> +             pin =3D NULL;
>>>
>>> -     wsc_store_credentials(wsc);
>>> -     wsc_try_credentials(wsc);
>>> +     wsc_start_enrollee(wsc, wsc->netdev, wsc->target, pin, NULL, 0);
>>
>> Is wsc_start_enrollee going to be called from p2p directly or only via
>> the D-Bus API?
> =

> So the D-Bus API will call the P2P code (to do GO Negotiation /
> Provision Discovery etc.) or the station-specific code inside wsc.c
> (to do the scanning) and they'll both call wsc_start_enrollee when
> ready.  wsc_connect_set_method is the station-specific code path where
> this happens.

Okay, but the PIN / PushButton setup is common to both, no?  And it =

seems that would logically belong in the overall D-Bus layer handlers. =

No point passing pin around, especially since you already made the =

change to store it inside the wsc object.

> =

>> This enclosing function (wsc_connect_set_method) is now
>> quite strange looking.  Maybe it'd look nicer to just set wsc->pin from
>> inside the StartPin / PushButton handlers instead and avoid this complet=
ely?
> =

> Well I can do this.  I preferred to keep the parts 1. and 2. of the
> code independent (e.g. for scenarios like auto-connecting to some P2P
> devices in the future) but it makes little differnce.
> =

> I notice the way git formatted this patch makes it hard to read.
> =

>>
>>>    }
>>>
>>>    static void station_state_watch(enum station_state state, void *user=
data)
>>> @@ -573,7 +550,7 @@ static void station_state_watch(enum station_state =
state, void *userdata)
>>>        station_remove_state_watch(wsc->station, wsc->station_state_watc=
h);
>>>        wsc->station_state_watch =3D 0;
>>>
>>> -     wsc_connect(wsc);
>>> +     wsc_connect_set_method(wsc);
>>>    }
>>>
>>>    static void wsc_check_can_connect(struct wsc *wsc, struct scan_bss *=
target)
>>> @@ -587,25 +564,9 @@ static void wsc_check_can_connect(struct wsc *wsc,=
 struct scan_bss *target)
>>>        wsc->target =3D target;
>>>        station_set_autoconnect(wsc->station, false);
>>>
>>> -     if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin"))=
 {
>>> -             char *pin;
>>> -
>>> -             wsc->config_method =3D WSC_CONFIGURATION_METHOD_KEYPAD;
>>> -
>>> -             if (!l_dbus_message_get_arguments(wsc->pending, "s", &pin=
))
>>> -                     goto error;
>>> -
>>> -             wsc->pin =3D l_strdup(pin);
>>> -     } else
>>> -             wsc->config_method =3D
>>> -                     WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
>>> -
>>> -     wsc->done_cb =3D wsc_dbus_done_cb;
>>> -     wsc->done_data =3D wsc;
>>> -
>>>        switch (station_get_state(wsc->station)) {
>>>        case STATION_STATE_DISCONNECTED:
>>> -             wsc_connect(wsc);
>>> +             wsc_connect_set_method(wsc);
>>>                return;
>>>        case STATION_STATE_CONNECTING:
>>>        case STATION_STATE_CONNECTED:
>>> @@ -652,20 +613,13 @@ static void walk_timeout(struct l_timeout *timeou=
t, void *user_data)
>>>
>>>        wsc_cancel_scan(wsc);
>>>
>>> -     if (wsc->pending)
>>> -             dbus_pending_reply(&wsc->pending,
>>> -                             wsc_error_walk_time_expired(wsc->pending)=
);
>>> -}
>>> +     if (wsc->pending) {
>>> +             struct l_dbus_message *reply =3D wsc->pin ?
>>> +                     wsc_error_time_expired(wsc->pending) :
>>> +                     wsc_error_walk_time_expired(wsc->pending);
>>>
>>> -static void pin_timeout(struct l_timeout *timeout, void *user_data)
>>> -{
>>> -     struct wsc *wsc =3D user_data;
>>> -
>>> -     wsc_cancel_scan(wsc);
>>> -
>>> -     if (wsc->pending)
>>> -             dbus_pending_reply(&wsc->pending,
>>> -                                     wsc_error_time_expired(wsc->pendi=
ng));
>>> +             dbus_pending_reply(&wsc->pending, reply);
>>> +     }
>>>    }
>>>
>>
>> Okay, but this really belongs as a separate patch
> =

> Ok.
> =

>>
>>>    static bool push_button_scan_results(int err, struct l_queue *bss_li=
st,
>>> @@ -1001,20 +955,7 @@ static struct l_dbus_message *wsc_push_button(str=
uct l_dbus *dbus,
>>>
>>>        l_debug("");
>>>
>>> -     if (wsc->pending)
>>> -             return dbus_error_busy(message);
>>> -
>>
>> So why would you move this check out into the ops provided operation and
>> not keep it here?
>>
> ...
>>> -     wsc->pending =3D l_dbus_message_ref(message);
>>> -
>>
>> Pending tracking should also likely be managed here...
>>
> ...
>>> -     if (wsc->pending)
>>> -             return dbus_error_busy(message);
>>
>> Same comments as above apply here ...
> =

> For one, in the P2P case, it's not going to have access to the
> internals of struct wsc, so if P2P replies with success or an error
> message to the PushButton call, it would need some way to also clear
> wsc->pending.  That's doable but it seems simpler to leave full
> control to the actual implementation.  So my idea in this version was
> that the DBus handlers would be really simple and stateless.
> =


But how would p2p set wsc->pending if it has no access to the wsc =

object?  Or are you duplicating the D-Bus handling code inside p2p?  I =

guess I was under the impression that you'd want to unify the D-Bus bits =

as well.

If you want to re-invent this inside p2p, then there's really no need =

for this wsc_ops abstraction.  Just have something like:

struct wsc_dbus_object {
	bool station;
	union {
		struct wsc_p2p *p2p;
		struct wsc *wsc;
	}
}

> Also remember that in the P2P case the PushButton method will kick off
> the connection process but there's a few different steps and WSC is
> just one of them and might be skipped completely in some scenarios.
> =


Sure, so you'd abstract wsc eap connection behind =

wsc_eap_start_enrollee, wsc_eap_cancel, etc.  This ends up being re-used =

and the rest you can do separate.

>>
>>> -
>>> -     wsc->station =3D station_find(netdev_get_ifindex(wsc->netdev));
>>> -     if (!wsc->station)
>>> -             return dbus_error_not_available(message);
>>> -
>>>        if (!l_dbus_message_get_arguments(message, "s", &pin))
>>>                return dbus_error_invalid_args(message);
>>>
>>>        if (!wsc_pin_is_valid(pin))
>>>                return dbus_error_invalid_format(message);
>>>
>>> -     if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
>>> -             dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
>>> -     else
>>> -             dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
>>> -
>>> -     if (!wsc_initiate_scan(wsc, dpid, pin_scan_results))
>>> -             return dbus_error_failed(message);
>>> -
>>> -     wsc->walk_timer =3D l_timeout_create(60, pin_timeout, wsc, NULL);
>>> -     wsc->pending =3D l_dbus_message_ref(message);
>>> -
>>> +     wsc->ops->connect(message, pin, wsc->user_data);
>>>        return NULL;
>>>    }
>>>
>>> -static struct l_dbus_message *wsc_cancel(struct l_dbus *dbus,
>>> +static struct l_dbus_message *wsc_dbus_cancel(struct l_dbus *dbus,
>>>                                                struct l_dbus_message *m=
essage,
>>>                                                void *user_data)
>>>    {
>>>        struct wsc *wsc =3D user_data;
>>> -     struct l_dbus_message *reply;
>>>
>>>        l_debug("");
>>>
>>> -     if (!wsc->pending)
>>> -             return dbus_error_not_available(message);
>>> -
>>> -     wsc_cancel_scan(wsc);
>>> -
>>> -     if (wsc->station_state_watch) {
>>> -             station_remove_state_watch(wsc->station,
>>> -                                             wsc->station_state_watch);
>>> -             wsc->station_state_watch =3D 0;
>>> -             wsc->target =3D NULL;
>>> -     }
>>> -
>>> -     if (wsc->wsc_association) {
>>> -             int r;
>>> -
>>> -             r =3D netdev_disconnect(wsc->netdev, wsc_disconnect_cb, w=
sc);
>>> -             if (r =3D=3D 0) {
>>> -                     wsc->pending_cancel =3D l_dbus_message_ref(messag=
e);
>>> -                     return NULL;
>>> -             }
>>> -
>>> -             l_warn("Unable to initiate disconnect: %s", strerror(-r));
>>> -             wsc->wsc_association =3D false;
>>> -     }
>>> -
>>> -     dbus_pending_reply(&wsc->pending, dbus_error_aborted(wsc->pending=
));
>>> -
>>> -     reply =3D l_dbus_message_new_method_return(message);
>>> -     l_dbus_message_set_arguments(reply, "");
>>> -
>>> -     return reply;
>>> +     wsc->ops->cancel(message, wsc->user_data);
>>> +     return NULL;
>>>    }
>>>
>>>    static void setup_wsc_interface(struct l_dbus_interface *interface)
>>> @@ -1128,7 +1021,7 @@ static void setup_wsc_interface(struct l_dbus_int=
erface *interface)
>>>        l_dbus_interface_method(interface, "StartPin", 0,
>>>                                wsc_start_pin, "", "s", "pin");
>>>        l_dbus_interface_method(interface, "Cancel", 0,
>>> -                             wsc_cancel, "", "");
>>> +                             wsc_dbus_cancel, "", "");
>>>    }
>>>
>>>    static void wsc_free(void *userdata)
>>> @@ -1155,7 +1048,194 @@ static void wsc_free(void *userdata)
>>>        l_free(wsc);
>>>    }
>>>
>>> -static void wsc_add_interface(struct netdev *netdev)
>>> +struct wsc *wsc_new(const struct wsc_ops *ops, void *user_data)
>>> +{
>>> +     struct l_dbus *dbus =3D dbus_get_bus();
>>> +     struct wsc *wsc;
>>> +     const char *path;
>>> +
>>> +     wsc =3D l_new(struct wsc, 1);
>>> +     wsc->ops =3D ops;
>>> +     wsc->user_data =3D user_data;
>>
>> This part seems rather weird
> =

> Do you mean the whole function? and why?

I really meant the user_data setting.  You pass in user_data to all the =

callbacks, but it is set to NULL in wsc_new.  I think the intent was for =

user_data to be the wsc object itself, but I don't see how that would =

even be accomplished in this setup.  Have you actually tested this patch =

standalone?

> =

>>
>>> +
>>> +     path =3D wsc->ops->get_path(wsc->user_data);
>>> +     if (!path)
>>> +             return wsc;
>>> +
>>> +     if (l_dbus_object_add_interface(dbus, path, IWD_WSC_INTERFACE, ws=
c))
>>> +             return wsc;
>>> +
>>> +     wsc_free(wsc);
>>> +     l_info("Unable to register interface %s at %s", IWD_WSC_INTERFACE,
>>> +             path);
>>> +     return NULL;
>>> +}
>>> +
>>> +void wsc_destroy(struct wsc *wsc)
>>> +{
>>> +     l_dbus_object_remove_interface(dbus_get_bus(),
>>> +                                     wsc->ops->get_path(wsc->user_data=
),
>>> +                                     IWD_WSC_INTERFACE);
>>> +}
>>> +
>>> +void wsc_start_enrollee(struct wsc *wsc, struct netdev *netdev,
>>> +                     struct scan_bss *target, const char *pin)
>>> +{
>>> +     wsc->netdev =3D netdev;
>>> +     wsc->target =3D target;
>>> +     wsc->config_method =3D pin ? WSC_CONFIGURATION_METHOD_KEYPAD :
>>> +             WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
>>> +     wsc->pin =3D l_strdup(pin);
>>> +
>>> +     wsc_connect(wsc);
>>> +}
>>> +
>>> +void wsc_cancel(struct wsc *wsc, netdev_disconnect_cb_t cb)
>>> +{
>>> +     int r;
>>> +
>>> +     if (!wsc->wsc_association)
>>> +             return;
>>> +
>>> +     r =3D netdev_disconnect(wsc->netdev, cb, wsc->user_data);
>>> +     if (r =3D=3D 0)
>>> +             return;
>>> +
>>> +     l_warn("Unable to initiate disconnect: %s", strerror(-r));
>>> +     wsc_connect_cleanup(wsc);
>>> +     wsc->ops->enrollee_done_cb(-ECANCELED, NULL, 0, wsc->user_data);
>>> +
>>> +     if (cb)
>>> +             cb(wsc->netdev, false, wsc->user_data);
>>> +}
>>> +
>>> +static const char *wsc_device_get_path(void *user_data)
>>> +{
>>> +     struct wsc *wsc =3D user_data;
>>> +
>>> +     if (!wsc || !wsc->netdev)
>>> +             return NULL;
>>> +
>>> +     return netdev_get_path(wsc->netdev);
>>> +}
>>> +
>>> +static void wsc_device_connect(struct l_dbus_message *message, const c=
har *pin,
>>> +                             void *user_data)
>>> +{
>>> +     struct wsc *wsc =3D user_data;
>>> +     struct l_dbus *dbus =3D dbus_get_bus();
>>> +     unsigned int walk_time;
>>> +     enum wsc_device_password_id dpid;
>>> +     scan_notify_func_t results_cb;
>>> +
>>> +     if (wsc->pending) {
>>> +             l_dbus_send(dbus, dbus_error_busy(message));
>>> +             return;
>>> +     }
>>> +
>>> +     wsc->station =3D station_find(netdev_get_ifindex(wsc->netdev));
>>> +     if (!wsc->station) {
>>> +             l_dbus_send(dbus, dbus_error_not_available(message));
>>> +             return;
>>> +     }
>>> +
>>> +     if (pin) {
>>> +             if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin=
))
>>> +                     dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
>>> +             else
>>> +                     dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
>>> +
>>> +             walk_time =3D 60;
>>> +             results_cb =3D pin_scan_results;
>>> +     } else {
>>> +             dpid =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
>>> +             walk_time =3D WALK_TIME;
>>> +             results_cb =3D push_button_scan_results;
>>> +     }
>>> +
>>> +     if (!wsc_initiate_scan(wsc, dpid, results_cb)) {
>>> +             l_dbus_send(dbus, dbus_error_failed(message));
>>> +             return;
>>> +     }
>>> +
>>> +     wsc->walk_timer =3D l_timeout_create(walk_time, walk_timeout, wsc=
, NULL);
>>> +     wsc->pending =3D l_dbus_message_ref(message);
>>> +}
>>> +
>>> +static void wsc_device_cancel(struct l_dbus_message *message, void *us=
er_data)
>>> +{
>>> +     struct wsc *wsc =3D user_data;
>>> +     struct l_dbus *dbus =3D dbus_get_bus();
>>> +
>>> +     if (!wsc->pending) {
>>> +             l_dbus_send(dbus, dbus_error_not_available(message));
>>> +             return;
>>> +     }
>>> +
>>> +     if (wsc->pending_cancel) {
>>> +             l_dbus_send(dbus, dbus_error_busy(message));
>>> +             return;
>>> +     }
>>> +
>>
>> As mentioned before, this doesn't seem like it belongs in the op itself
>> but in the higher layer...
>>
>>> +     wsc_cancel_scan(wsc);
>>> +
>>> +     if (wsc->station_state_watch) {
>>> +             station_remove_state_watch(wsc->station,
>>> +                                             wsc->station_state_watch);
>>> +             wsc->station_state_watch =3D 0;
>>> +             wsc->target =3D NULL;
>>> +     }
>>> +
>>> +     if (wsc->wsc_association) {
>>> +             wsc->pending_cancel =3D l_dbus_message_ref(message);
>>> +             wsc_cancel(wsc, wsc_disconnect_cb);
>>> +             return;
>>> +     }
>>> +
>>> +     dbus_pending_reply(&wsc->pending, dbus_error_aborted(wsc->pending=
));
>>> +     l_dbus_send(dbus, l_dbus_message_new_method_return(message));
>>
>> As is this...
>>
>>> +}
>>> +
>>> +static void wsc_device_enrollee_done(int err, struct wsc_credentials_i=
nfo *creds,
>>> +                                     unsigned int n_creds, void *user_=
data)
>>> +{
>>> +     struct wsc *wsc =3D user_data;
>>> +
>>> +     l_debug("err=3D%i", err);
>>> +
>>> +     switch (err) {
>>> +     case 0:
>>> +             break;
>>> +     case -ECANCELED:
>>> +             dbus_pending_reply(&wsc->pending,
>>> +                                     dbus_error_aborted(wsc->pending));
>>> +             return;
>>> +     case -ENOKEY:
>>> +             dbus_pending_reply(&wsc->pending,
>>> +                                     wsc_error_no_credentials(wsc->pen=
ding));
>>> +             return;
>>> +     case -EBUSY:
>>> +             dbus_pending_reply(&wsc->pending,
>>> +                                     dbus_error_busy(wsc->pending));
>>> +             return;
>>> +     default:
>>> +             dbus_pending_reply(&wsc->pending,
>>> +                                     dbus_error_failed(wsc->pending));
>>> +             return;
>>> +     }
>>> +
>>> +     wsc_store_credentials(creds, n_creds);
>>> +     wsc_try_credentials(wsc, creds, n_creds);
>>> +}
>>> +
>>> +static const struct wsc_ops wsc_device_ops =3D {
>>> +     .get_path =3D wsc_device_get_path,
>>> +     .connect =3D wsc_device_connect,
>>> +     .cancel =3D wsc_device_cancel,
>>> +     .enrollee_done_cb =3D wsc_device_enrollee_done,
>>> +};
>>> +
>>> +static void wsc_device_new(struct netdev *netdev)
>>>    {
>>>        struct l_dbus *dbus =3D dbus_get_bus();
>>>        struct wsc *wsc;
>>> @@ -1167,15 +1247,17 @@ static void wsc_add_interface(struct netdev *ne=
tdev)
>>>                return;
>>>        }
>>>
>>> -     wsc =3D l_new(struct wsc, 1);
>>> +     wsc =3D wsc_new(&wsc_device_ops, NULL);
>>> +     wsc->user_data =3D wsc;
>>>        wsc->netdev =3D netdev;
>>>
>>> -     if (!l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
>>> -                                             IWD_WSC_INTERFACE,
>>> -                                             wsc)) {
>>> -             wsc_free(wsc);
>>> -             l_info("Unable to register %s interface", IWD_WSC_INTERFA=
CE);
>>> -     }
>>> +     if (l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
>>> +                                     IWD_WSC_INTERFACE, wsc))
>>> +             return;
>>> +
>>> +     wsc_free(wsc);
>>> +     l_info("Unable to register interface %s at %s", IWD_WSC_INTERFACE,
>>> +             netdev_get_path(netdev));
>>
>> This logic flipping seems gratuitous, I'd just leave it the way it was...
> =

> Ok.
> =

>>
>>>    }
>>>
>>>    static void wsc_remove_interface(struct netdev *netdev)
>>> @@ -1194,7 +1276,7 @@ static void wsc_netdev_watch(struct netdev *netde=
v,
>>>        case NETDEV_WATCH_EVENT_NEW:
>>>                if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATI=
ON &&
>>>                                netdev_get_is_up(netdev))
>>> -                     wsc_add_interface(netdev);
>>> +                     wsc_device_new(netdev);
>>>                break;
>>>        case NETDEV_WATCH_EVENT_DOWN:
>>>        case NETDEV_WATCH_EVENT_DEL:
>>> diff --git a/src/wsc.h b/src/wsc.h
>>> index ada08c89..e8a965f2 100644
>>> --- a/src/wsc.h
>>> +++ b/src/wsc.h
>>> @@ -20,6 +20,11 @@
>>>     *
>>>     */
>>>
>>> +struct wsc;
>>> +struct netdev;
>>> +struct scan_bss;
>>> +struct iovec;
>>> +
>>>    struct wsc_credentials_info {
>>>        char ssid[33];
>>>        enum security security;
>>> @@ -31,5 +36,17 @@ struct wsc_credentials_info {
>>>        bool has_passphrase;
>>>    };
>>>
>>> -typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *cr=
eds,
>>> -                             unsigned int n_creds, void *user_data);
>>> +struct wsc_ops {
>>> +     const char *(*get_path)(void *user_data);
>>> +     void (*connect)(struct l_dbus_message *message, const char *pin,
>>> +                     void *user_data);
>>> +     void (*cancel)(struct l_dbus_message *message, void *user_data);
>>> +     void (*enrollee_done_cb)(int err, struct wsc_credentials_info *cr=
eds,
>>> +                                     unsigned int n_creds, void *user_=
data);
>>
>> So one thing I find very weird about this setup is the fact that you're
>> mixing operations with a callback in something called 'wsc_ops'.  Can't
>> your 'connect' operation simply set the callback or perhaps provide the
>> callback directly to wsc_start_enrollee?
> =

> It would work equally well, yes.  Maybe I was being lazy, I'll fix this.
> =

> One argument for keeping all the callbacks in this struct is that they
> implicitly use the same "user_data" and so we save both the callback
> parameter to wsc_start_enrollee, the user_data parameter (we often
> complained about our functions having too many arguments) and 2 fields
> in struct wsc for storing these two parameters.

Well, so far I only see a single callback being utilized.  So there =

seems to be no need for this just yet?  Also, see my comments above =

about user_data weirdness.

Regards,
-Denis
--===============2057889121448106331==--

