Content-Type: multipart/mixed; boundary="===============5722680917059212334=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] wsc: Refactor to make the DBus interface reusable
Date: Thu, 09 Jan 2020 11:20:57 -0600
Message-ID: <aaee309d-2aca-0752-73d1-e8eadebebdd9@gmail.com>
In-Reply-To: <CAOq732+r6Jj1rci_DL3uus2GnvW_D7UFGHPwSmBhkBZYOMV3bw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5722680917059212334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

<snip>

> The disconnect is handled at a lower level, by wsc_cancel.
> wsc_disconnect_cb doesn't need to do anything related to the internal
> protocol state.
> =

> The part 1. exposes an API that is used by 3. in wsc.c, or by the
> external caller which also supplies a callback like wsc_disconnect_cb.
> That callback also can't mess with variables like wsc->wsc_association
> (sitting outside wsc.c it has no way anyway).
> =


Okay, so I had to stare at this again for a while and I think I get it =

now.  Note that you only call wsc_connect_cleanup if netdev_disconnect =

fails.  So wsc_connect_cleanup is not called unnecessarily.

<snip>

> =

> In this case wsc->pending was only part of 3. (out of the three state
> machines in wsc.c I mentioned) and p2p.c had it's own "pending" which
> is also used as a flag internally.  I guess it makes sense to change
> this to handle the dbus message completely in wsc.c so p2p.c doesn't
> have to see the actual messages.

If it was me doing it, I'd try to unify the D-Bus API handling aspects. =

Especially since you went to the trouble of abstracting all the operations.

> =

>>
>> If you want to re-invent this inside p2p, then there's really no need
>> for this wsc_ops abstraction.  Just have something like:
>>
>> struct wsc_dbus_object {
>>          bool station;
>>          union {
>>                  struct wsc_p2p *p2p;
>>                  struct wsc *wsc;
>>          }
>> }
> =

> I don't follow.  Our entry points are the DBus method handlers, which
> are in wsc.c.  How will the control pass from wsc.c to p2p.c (or to
> the station specific CBs) without the wsc_ops?

it would just invoke the relevant function calls directly.  i.e.

wsc_p2p_push_button(p2p, msg);
wsc_p2p_start_pin(p2p, msg);
wsc_p2p_cancel(p2p, msg);

That would give you a whole lot more freedom to do whatever in p2p.

> =

> I think I did (this was a month ago) ;-)  You're right, the idea is
> for the user_data to be the wsc object itself because I didn't split
> the state into separate structs.  So in the station mode case
> wsc_add_interface calls wsc_new, then overwrites wsc->user_data.

Yep, I think I missed the part of you overwriting the user_data.  You =

went through all this trouble of defining an API for setting it and then =

turn around and backdoor it ;)  That is what threw me off here and also =

in the disconnect_cb bits above.  If user_data was meant to be set =

externally, it would have been clearer to add wsc_set_userdata() method =

or have the caller pass in the cb/userdata into the operation directly.

> =

> .connect and .cancel are both being utilized, and .enrollee_done_cb is
> also being utilized but at a different level.  There's currently one
> user_data for them.

So while this works, I would think that separating the layers more =

explicitly would make things more elegant.  You have the EAP-WSC state =

machine object that takes care of the actual WSC connection:
	wsc_enrollee_new
	wsc_enrollee_start
	wsc_enrollee_cancel
	wsc_enrollee_free

Then you have the p2p/station layers that take care of scanning, etc. =

This is where your ops stuff can live.  Something like:

struct wsc {
	const char *(*get_path)(struct wsc *wsc);
	int (*connect)(struct wsc *wsc, const char *pin,
			connect_cb_t cb, void *userdata);
	int (*cancel)(struct wsc *wsc, cancel_cb_t cb, void *userdata);
	void (*remove)(struct wsc *wsc);
};

Then for p2p you can do:

struct wsc_p2p {
	// some members
	struct wsc super;
};

struct wsc *wsc_p2p_new();

for station:
struct wsc_station {
	struct wsc super;
	// some members;
	struct station *station;
	uint32_t station_state_watch;
	...
};

struct wsc *wsc_station_new();

And if you want to unify the D-Bus bits, then:

struct wsc_dbus {
	struct wsc *wsc;
	struct l_dbus_message *pending;
	struct l_dbus_message *pending_cancel;
};
	=

Regards,
-Denis
--===============5722680917059212334==--

