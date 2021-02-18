Content-Type: multipart/mixed; boundary="===============1911912081050064105=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/4] ap: Pass vendor IEs between frames and the user
Date: Thu, 18 Feb 2021 20:37:08 +0100
Message-ID: <CAOq732+uUbU2etN3P-bUEZwER1_kbXmEJ24L7yLyPcoBamALWg@mail.gmail.com>
In-Reply-To: <43a4d084-47b0-085b-f382-3f695149a323@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1911912081050064105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 18 Feb 2021 at 18:17, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> On 2/5/21 5:46 PM, Andrew Zaborowski wrote:
> > Add API for the ap.h users to add extra vendor IEs to outgoing
> > management frames (beacons, etc.).  Pass the string IEs from the
> > incoming STA association frames to the user in the AP event data.
>
> This patch seems to be doing 2 separate things, no?  If so, it should rea=
lly be
> two commits.  Especially since patch 3 only cares about the latter part.

They seemed related enough but yes.

>
> >
> > I drop ap_event_station_added_data.rsn_ie because that probably
> > wasn't going to ever be useful and the RSN IE is included in the
> > assoc_ies array in any case.
> > ---
> >   src/ap.c | 233 ++++++++++++++++++++++++++++++++++++++++---------------
> >   src/ap.h |  15 +++-
> >   2 files changed, 186 insertions(+), 62 deletions(-)
> >
>
> <snip>
>
> > @@ -463,11 +474,51 @@ static void ap_set_rsn_info(struct ap_state *ap, =
struct ie_rsn_info *rsn)
> >       rsn->group_cipher =3D ap->group_cipher;
> >   }
> >
> > +static size_t ap_get_vendor_ies_len(struct ap_state *ap,
> > +                                     enum mpdu_management_subtype type)
> > +{
> > +     const struct l_queue_entry *entry;
> > +     size_t len =3D 0;
> > +
> > +     for (entry =3D l_queue_get_entries(ap->sta_states); entry;
> > +                     entry =3D entry->next) {
> > +             struct ap_vendor_ie_writer *writer =3D entry->data;
> > +
> > +             len +=3D writer->get_len_func(type, writer->user_data);
> > +     }
> > +
> > +     return len;
> > +}
> > +
> > +static size_t ap_write_vendor_ies(struct ap_state *ap,
> > +                                     enum mpdu_management_subtype type,
> > +                                     uint8_t *out_buf)
> > +{
> > +     const struct l_queue_entry *entry;
> > +     size_t len =3D 0;
> > +
> > +     for (entry =3D l_queue_get_entries(ap->sta_states); entry;
> > +                     entry =3D entry->next) {
> > +             struct ap_vendor_ie_writer *writer =3D entry->data;
> > +
> > +             len +=3D writer->write_func(type, out_buf + len,
> > +                                             writer->user_data);
> > +     }
> > +
> > +     return len;
> > +}
> > +
>
> I sort of wonder why you go through all these lengths when p2p is the only
> external user of this and registers the same user data object.
>
> <snip>
>
> > @@ -53,6 +57,10 @@ struct ap_event_registration_success_data {
> >   };
> >
> >   typedef void (*ap_stopped_func_t)(void *user_data);
> > +typedef size_t (*ap_get_vendor_ie_len)(enum mpdu_management_subtype ty=
pe,
> > +                                     void *user_data);
> > +typedef size_t (*ap_write_vendor_ie)(enum mpdu_management_subtype type,
> > +                                     uint8_t *out_buf, void *user_data=
);
> >
> >   struct ap_config {
> >       char *ssid;
> > @@ -83,6 +91,11 @@ void ap_shutdown(struct ap_state *ap, ap_stopped_fun=
c_t stopped_func,
> >                       void *user_data);
> >   void ap_free(struct ap_state *ap);
> >
> > +void ap_add_vendor_ie_writer(struct ap_state *ap,
> > +                             ap_get_vendor_ie_len get_len_func,
> > +                             ap_write_vendor_ie write_func,
> > +                             void *user_data);
> > +
>
> This part would likely look better as an .ops structure...

Ok, I can do it that way, in fact the previous version I sent did exactly t=
hat.

>
> Taking a step back here though, it feels like this API is really incomple=
te:
>
> - There's no way for an external observer to grab an ap_state object in o=
rder
> for them to add a vendor IE (for example, some vendor plugin might want to
> advertise extra IEs or something).
>
> - There's no way for an observer to react to any events since they're han=
dled by
> the singleton 'handle_event' operation passed in to ap_start.  This part =
is
> particularly asymmetric with how ap_add_vendor_ie_writer() is meant to be=
 used.

True, those two approaches can be seen as conflicting so we probably
should go one way or the other, i.e.

 * have a single ops callback that writes all the extra IEs as one, or

 * allow registering multiple IE writers but also add ways for ap.h
users (other than the caller of ap_start()) to iterate over ap_states,
or perhaps add their IEs globally without needing an ap_state.

In any case I don't see any need for the latter option right now.  You
also seem to prefer the simpler approach too.  The reason I went for
ap_add_vendor_ie_writer() is that it can be extended in the future if
we needed the IE order-by-tag logic mentioned in 802.11-2016 9.4.2.1
and would only require one-line changes in the callers.

>
> So what is the end goal for 'struct ap_state' APIs?  Should they be exter=
nally
> observable like station?  In that case you may want to add watchlists and=
 such
> for this.

I don't see much use for that.

>
> If they're meant only to be used by the P2P subclass, then you might as w=
ell
> move all these details into 'ap_ops' instead.
>
> Also, you may consider flipping things around and instead of using a 'pul=
l'
> mechanism, using a 'push' mechanism instead.  Add a couple of new events =
to
> signal that vendor IEs need to be updated (beaconing, association respons=
e, etc)
> and have the clients invoke a function to write the new IEs.  This may be=
 more
> flexible and would allow you hide some implementation details (i.e. add a
> growable buffer instead of a variable-length stack buffer, something whic=
h we
> probably should not use in this instance)

That will force us to memcpy those buffers when sending one of those
frames, and we would probably need reference counting too.  We may
also end up generating the IE contents even if the related frame never
gets sent, so we may be doing extra work.

Also we may need to build the probe response IEs based specifically on
the contents of the probe request (that happens to not be a problem
with Association Req / Association Response in P2P right now) but my
current patch doesn't handle that either, I think I'll add a separate,
but similar, ops-> callback for writing the probe response IEs which
takes the probe request IEs string as an extra parameter.

Best regards
--===============1911912081050064105==--

